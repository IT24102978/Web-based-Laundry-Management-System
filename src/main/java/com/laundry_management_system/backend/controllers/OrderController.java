package com.laundry_management_system.backend.controllers;

import com.laundry_management_system.backend.models.*;
import com.laundry_management_system.backend.repositories.*;
import com.laundry_management_system.backend.utils.DatabaseConnectionSingleton;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.sql.Connection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/orders")
public class OrderController {

    private final OrderRepository orders;
    private final CustomerRepository customers;
    private final ServiceItemRepository serviceItemRepository;
    private final OrderItemRepository orderItemRepository;

    public OrderController(OrderRepository orders, CustomerRepository customers, ServiceItemRepository serviceItemRepository, OrderItemRepository orderItemRepository) {
        this.orders = orders;
        this.customers = customers;
        this.serviceItemRepository = serviceItemRepository;
        this.orderItemRepository = orderItemRepository;
    }

    /** Build list like ["C001","C002",...] for dropdowns */
    private List<String> customerUsernames() {
        return customers.findAllByOrderByUserAccount_UsernameAsc()
                .stream()
                .map(c -> c.getUserAccount().getUsername())
                .toList();
    }

    /** LIST page (main /orders page with form + table) */
    @GetMapping
    public String list(Model model, HttpSession session) {
        UserAccount user = (UserAccount) session.getAttribute("USER");
        if (user == null) {
            return "redirect:/login";
        }
        char first = Character.toUpperCase(user.getUsername().charAt(0));
        if (first != 'A' && first != 'E') {
            return "redirect:/?notAllowed";
        }

        model.addAttribute("orders", orders.findAll());
        model.addAttribute("newOrder", new OrderEntity());
        model.addAttribute("customerUsernames", customerUsernames());
        model.addAttribute("services", serviceItemRepository.findAll());

        try {
            DatabaseConnectionSingleton db = DatabaseConnectionSingleton.getInstance();
            Connection conn = db.getConnection();
            boolean isConnected = (conn != null && !conn.isClosed());
            model.addAttribute("dbStatus", isConnected ? "🟢 Database Online" : "🔴 Database Disconnected");
        } catch (Exception e) {
            model.addAttribute("dbStatus", "🔴 Database Error: " + e.getMessage());
        }

        return "order";
    }

    /** CREATE (safe version) */
    @PostMapping
    @Transactional
    public String create(@ModelAttribute("newOrder") OrderEntity newOrder,
                         @RequestParam(value = "customerUsername", required = false) String customerUsername,
                         HttpServletRequest request,
                         RedirectAttributes ra) {

        // ✅ 1. Handle customer
        if (customerUsername != null && !customerUsername.isBlank()) {
            Customer c = customers.findByUserAccount_Username(customerUsername)
                    .orElseThrow(() -> new IllegalArgumentException("Unknown customer username: " + customerUsername));
            newOrder.setCustomerId(c.getCustomerId());
        }

        // ✅ 2. Save base order first
        OrderEntity savedOrder = orders.save(newOrder);
        System.out.println("🔍 DEBUG: Base order saved with ID: " + savedOrder.getOrderId());

        // ✅ 3. Get all selected service IDs
        String[] serviceIdParams = request.getParameterValues("serviceIds");
        
        // Debug: Log received parameters
        System.out.println("🔍 DEBUG: serviceIdParams = " + (serviceIdParams != null ? java.util.Arrays.toString(serviceIdParams) : "null"));
        System.out.println("🔍 DEBUG: All request parameters:");
        request.getParameterMap().forEach((key, values) -> 
            System.out.println("  " + key + " = " + java.util.Arrays.toString(values)));

        if (serviceIdParams != null && serviceIdParams.length > 0) {
            System.out.println("🔍 DEBUG: Processing " + serviceIdParams.length + " service items");
            for (String sidStr : serviceIdParams) {
                if (sidStr == null || sidStr.isBlank()) continue;
                try {
                    int sid = Integer.parseInt(sidStr);
                    String qtyParam = request.getParameter("quantity_" + sid);

                    int qty = 1; // default
                    if (qtyParam != null && !qtyParam.isBlank()) {
                        qty = Integer.parseInt(qtyParam);
                    }

                    ServiceItem s = serviceItemRepository.findById(sid)
                            .orElseThrow(() -> new IllegalArgumentException("Invalid service ID: " + sid));

                    System.out.println("🔍 DEBUG: Creating OrderItem for Service ID: " + sid + ", Service: " + s.getServiceName() + ", Qty: " + qty);

                    OrderItem oi = new OrderItem();
                    oi.setOrder(savedOrder);
                    oi.setServiceItem(s);
                    oi.setQuantity(qty);
                    oi.setPrice(s.getUnitPrice().multiply(BigDecimal.valueOf(qty)));

                    System.out.println("🔍 DEBUG: OrderItem created - Order ID: " + oi.getOrder().getOrderId() + 
                                      ", Service: " + oi.getServiceItem().getServiceName() + 
                                      ", Qty: " + oi.getQuantity() + 
                                      ", Price: " + oi.getPrice());

                    // ✅ Save the OrderItem explicitly
                    OrderItem savedItem = orderItemRepository.save(oi);
                    System.out.println("🔍 DEBUG: OrderItem SAVED with ID: " + savedItem.getOrderItemId() + 
                                      " for Order: " + savedItem.getOrder().getOrderId() + 
                                      " Service: " + savedItem.getServiceItem().getServiceName() + 
                                      " Qty: " + savedItem.getQuantity());
                } catch (NumberFormatException e) {
                    System.err.println("⚠️ Skipping invalid serviceId or quantity: " + sidStr);
                }
            }
        } else {
            System.out.println("🔍 DEBUG: No service items found in request parameters");
        }

        // Debug: Check if order items were saved
        System.out.println("🔍 DEBUG: Final check - Order ID: " + savedOrder.getOrderId());
        System.out.println("🔍 DEBUG: Order items count from database: " + orderItemRepository.findByOrder_OrderId(savedOrder.getOrderId()).size());
        orderItemRepository.findByOrder_OrderId(savedOrder.getOrderId()).forEach(item -> 
            System.out.println("🔍 DEBUG: Found OrderItem - ID: " + item.getOrderItemId() + 
                              ", Service: " + item.getServiceItem().getServiceName() + 
                              ", Qty: " + item.getQuantity() + 
                              ", Price: " + item.getPrice()));

        ra.addFlashAttribute("msg", "Order #" + savedOrder.getOrderId() + " created successfully ✅");
        return "redirect:/orders";
    }

    /** VIEW */
    @GetMapping("/{id}")
    public String view(@PathVariable int id, Model model) {
        OrderEntity order = orders.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Order not found: " + id));
        
        // Debug: Check order items
        System.out.println("🔍 DEBUG VIEW: Order ID: " + order.getOrderId());
        System.out.println("🔍 DEBUG VIEW: Order items count: " + order.getItems().size());
        order.getItems().forEach(item -> 
            System.out.println("🔍 DEBUG VIEW: OrderItem - ID: " + item.getOrderItemId() + 
                              ", Service: " + (item.getServiceItem() != null ? item.getServiceItem().getServiceName() : "NULL") + 
                              ", Qty: " + item.getQuantity() + 
                              ", Price: " + item.getPrice()));
        
        model.addAttribute("order", order);
        return "view_order";
    }

    /** EDIT PAGE */
    @GetMapping("/{id}/edit")
    public String edit(@PathVariable int id, Model model) {
        OrderEntity order = orders.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Order not found: " + id));
        model.addAttribute("order", order);
        model.addAttribute("mode", "edit");
        model.addAttribute("customerUsernames", customerUsernames());
        model.addAttribute("services", serviceItemRepository.findAll());
        return "order_form";
    }

    /** UPDATE (safe version) */
    @PostMapping("/{id}")
    @Transactional
    public String update(@PathVariable int id,
                         @ModelAttribute("order") OrderEntity fromForm,
                         @RequestParam(value = "customerUsername", required = false) String customerUsername,
                         HttpServletRequest request,
                         RedirectAttributes ra) {

        OrderEntity existing = orders.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Order not found: " + id));

        if (customerUsername != null && !customerUsername.isBlank()) {
            Customer c = customers.findByUserAccount_Username(customerUsername)
                    .orElseThrow(() -> new IllegalArgumentException("Unknown customer username: " + customerUsername));
            existing.setCustomerId(c.getCustomerId());
        } else {
            existing.setCustomerId(fromForm.getCustomerId());
        }

        existing.setStatus(fromForm.getStatus());
        existing.setOrderDate(fromForm.getOrderDate());
        existing.setPickupDate(fromForm.getPickupDate());
        existing.setDeliveryDate(fromForm.getDeliveryDate());
        existing.setInstructions(fromForm.getInstructions());

        // ✅ Clear old items and rebuild safely
        existing.getItems().clear();
        String[] serviceIdParams = request.getParameterValues("serviceIds");

        if (serviceIdParams != null && serviceIdParams.length > 0) {
            for (String sidStr : serviceIdParams) {
                if (sidStr == null || sidStr.isBlank()) continue;
                try {
                    int sid = Integer.parseInt(sidStr);
                    String qtyParam = request.getParameter("quantity_" + sid);
                    int qty = (qtyParam != null && !qtyParam.isBlank()) ? Integer.parseInt(qtyParam) : 1;

                    ServiceItem s = serviceItemRepository.findById(sid)
                            .orElseThrow(() -> new IllegalArgumentException("Invalid service ID: " + sid));

                    System.out.println("🔍 DEBUG UPDATE: Creating OrderItem for Service ID: " + sid + ", Service: " + s.getServiceName() + ", Qty: " + qty);

                    OrderItem oi = new OrderItem();
                    oi.setOrder(existing);
                    oi.setServiceItem(s);
                    oi.setQuantity(qty);
                    oi.setPrice(s.getUnitPrice().multiply(BigDecimal.valueOf(qty)));
                    
                    System.out.println("🔍 DEBUG UPDATE: OrderItem created - Order ID: " + oi.getOrder().getOrderId() + 
                                      ", Service: " + oi.getServiceItem().getServiceName() + 
                                      ", Qty: " + oi.getQuantity() + 
                                      ", Price: " + oi.getPrice());
                    
                    // ✅ Save the OrderItem explicitly
                    OrderItem savedItem = orderItemRepository.save(oi);
                    System.out.println("🔍 DEBUG UPDATE: OrderItem SAVED with ID: " + savedItem.getOrderItemId() + 
                                      " for Order: " + savedItem.getOrder().getOrderId() + 
                                      " Service: " + savedItem.getServiceItem().getServiceName() + 
                                      " Qty: " + savedItem.getQuantity());
                } catch (NumberFormatException e) {
                    System.err.println("⚠️ Skipping invalid serviceId or quantity: " + sidStr);
                }
            }
        }

        orders.save(existing);
        ra.addFlashAttribute("msg", "Order #" + id + " updated successfully ✅");
        return "redirect:/orders/" + id;
    }

    /** NEW FORM */
    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("order", new OrderEntity());
        model.addAttribute("mode", "create");
        model.addAttribute("customerUsernames", customerUsernames());
        model.addAttribute("services", serviceItemRepository.findAll());
        return "order_form";
    }

    /** DELETE */
    @PostMapping("/{id}/delete")
    @Transactional
    public String delete(@PathVariable int id, RedirectAttributes ra) {
        if (orders.existsById(id)) {
            orders.deleteById(id);
            ra.addFlashAttribute("msg", "Order #" + id + " deleted.");
        } else {
            ra.addFlashAttribute("msg", "Order #" + id + " not found.");
        }
        return "redirect:/orders";
    }

    /** DEBUG: Test endpoint to check OrderItemRepository */
    @GetMapping("/debug/orderitems/{orderId}")
    @ResponseBody
    public String debugOrderItems(@PathVariable int orderId) {
        try {
            List<OrderItem> items = orderItemRepository.findByOrder_OrderId(orderId);
            StringBuilder result = new StringBuilder();
            result.append("Order ID: ").append(orderId).append("\n");
            result.append("Order Items Count: ").append(items.size()).append("\n");
            for (OrderItem item : items) {
                result.append("Item ID: ").append(item.getOrderItemId())
                      .append(", Service: ").append(item.getServiceItem().getServiceName())
                      .append(", Qty: ").append(item.getQuantity())
                      .append(", Price: ").append(item.getPrice()).append("\n");
            }
            return result.toString();
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }

    /** Map CustomerId → Username for JSP dropdowns */
    @ModelAttribute("idToUsername")
    public Map<Integer, String> idToUsername() {
        return customers.findAll().stream()
                .filter(c -> c.getUserAccount() != null)
                .collect(Collectors.toMap(
                        Customer::getCustomerId,
                        c -> c.getUserAccount().getUsername()
                ));
    }
}
