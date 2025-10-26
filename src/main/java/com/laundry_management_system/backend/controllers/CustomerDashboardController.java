package com.laundry_management_system.backend.controllers;

import com.laundry_management_system.backend.models.Customer;
import com.laundry_management_system.backend.models.OrderEntity;
import com.laundry_management_system.backend.models.OrderItem;
import com.laundry_management_system.backend.models.ServiceItem;
import com.laundry_management_system.backend.models.UserAccount;
import com.laundry_management_system.backend.repositories.CustomerRepository;
import com.laundry_management_system.backend.repositories.OrderItemRepository;
import com.laundry_management_system.backend.repositories.OrderRepository;
import com.laundry_management_system.backend.repositories.ServiceItemRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/customer-dashboard")
public class CustomerDashboardController {

    private final OrderRepository orderRepo;
    private final CustomerRepository customerRepo;
    private final ServiceItemRepository serviceItemRepository;
    private final OrderItemRepository orderItemRepository;

    public CustomerDashboardController(OrderRepository orderRepo, CustomerRepository customerRepo, 
                                     ServiceItemRepository serviceItemRepository, OrderItemRepository orderItemRepository) {
        this.orderRepo = orderRepo;
        this.customerRepo = customerRepo;
        this.serviceItemRepository = serviceItemRepository;
        this.orderItemRepository = orderItemRepository;
    }

    /** Show all orders for the logged-in customer */
    @GetMapping
    public String dashboard(Model model, HttpSession session) {
        UserAccount user = (UserAccount) session.getAttribute("USER");
        if (user == null) return "redirect:/login";

        Customer customer = customerRepo.findByUserAccount_Username(user.getUsername())
                .orElseThrow(() -> new IllegalArgumentException("Customer not found"));

        List<OrderEntity> myOrders = orderRepo.findByCustomerId(customer.getCustomerId());
        model.addAttribute("orders", myOrders);
        model.addAttribute("customer", customer);
        return "customer_dashboard";
    }

    /** Show order creation form */
    @GetMapping("/new")
    public String newOrder(Model model) {
        model.addAttribute("order", new OrderEntity());
        model.addAttribute("services", serviceItemRepository.findAll());
        return "customer_order_form";
    }

    /** Handle new order submission */
    @PostMapping("/new")
    @Transactional
    public String createOrder(@ModelAttribute("order") OrderEntity order,
                              HttpSession session,
                              HttpServletRequest request,
                              RedirectAttributes ra) {
        UserAccount user = (UserAccount) session.getAttribute("USER");
        if (user == null) return "redirect:/login";

        Customer customer = customerRepo.findByUserAccount_Username(user.getUsername())
                .orElseThrow(() -> new IllegalArgumentException("Customer not found"));
        order.setCustomerId(customer.getCustomerId());
        OrderEntity savedOrder = orderRepo.save(order);

        // Handle service items
        String[] serviceIdParams = request.getParameterValues("serviceIds");
        if (serviceIdParams != null && serviceIdParams.length > 0) {
            for (String sidStr : serviceIdParams) {
                if (sidStr == null || sidStr.isBlank()) continue;
                try {
                    int sid = Integer.parseInt(sidStr);
                    String qtyParam = request.getParameter("quantity_" + sid);
                    int qty = (qtyParam != null && !qtyParam.isBlank()) ? Integer.parseInt(qtyParam) : 1;

                    ServiceItem service = serviceItemRepository.findById(sid)
                            .orElseThrow(() -> new IllegalArgumentException("Invalid service ID: " + sid));

                    OrderItem orderItem = new OrderItem();
                    orderItem.setOrder(savedOrder);
                    orderItem.setServiceItem(service);
                    orderItem.setQuantity(qty);
                    orderItem.setPrice(service.getUnitPrice().multiply(BigDecimal.valueOf(qty)));

                    orderItemRepository.save(orderItem);
                } catch (NumberFormatException e) {
                    System.err.println("⚠️ Skipping invalid serviceId or quantity: " + sidStr);
                }
            }
        }

        ra.addFlashAttribute("msg", "✅ Order created successfully!");
        return "redirect:/customer-dashboard";
    }

    /** Edit an existing order */
    @GetMapping("/{id}/edit")
    public String editOrder(@PathVariable int id, Model model, HttpSession session) {
        UserAccount user = (UserAccount) session.getAttribute("USER");
        if (user == null) return "redirect:/login";

        OrderEntity order = orderRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));

        model.addAttribute("order", order);
        model.addAttribute("services", serviceItemRepository.findAll());
        return "customer_order_form";
    }

    /** Save edited order */
    @PostMapping("/{id}/edit")
    @Transactional
    public String updateOrder(@PathVariable int id,
                              @ModelAttribute("order") OrderEntity fromForm,
                              HttpServletRequest request,
                              RedirectAttributes ra) {
        OrderEntity existing = orderRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));

        existing.setStatus(fromForm.getStatus());
        existing.setPickupDate(fromForm.getPickupDate());
        existing.setDeliveryDate(fromForm.getDeliveryDate());
        existing.setInstructions(fromForm.getInstructions());

        // Clear old items and rebuild with new service items
        existing.getItems().clear();
        String[] serviceIdParams = request.getParameterValues("serviceIds");

        if (serviceIdParams != null && serviceIdParams.length > 0) {
            for (String sidStr : serviceIdParams) {
                if (sidStr == null || sidStr.isBlank()) continue;
                try {
                    int sid = Integer.parseInt(sidStr);
                    String qtyParam = request.getParameter("quantity_" + sid);
                    int qty = (qtyParam != null && !qtyParam.isBlank()) ? Integer.parseInt(qtyParam) : 1;

                    ServiceItem service = serviceItemRepository.findById(sid)
                            .orElseThrow(() -> new IllegalArgumentException("Invalid service ID: " + sid));

                    OrderItem orderItem = new OrderItem();
                    orderItem.setOrder(existing);
                    orderItem.setServiceItem(service);
                    orderItem.setQuantity(qty);
                    orderItem.setPrice(service.getUnitPrice().multiply(BigDecimal.valueOf(qty)));

                    orderItemRepository.save(orderItem);
                } catch (NumberFormatException e) {
                    System.err.println("⚠️ Skipping invalid serviceId or quantity: " + sidStr);
                }
            }
        }

        orderRepo.save(existing);
        ra.addFlashAttribute("msg", "✅ Order updated successfully!");
        return "redirect:/customer-dashboard";
    }

    /** View an existing order */
    @GetMapping("/{id}")
    public String viewOrder(@PathVariable int id, Model model, HttpSession session) {
        UserAccount user = (UserAccount) session.getAttribute("USER");
        if (user == null) return "redirect:/login";

        OrderEntity order = orderRepo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));

        // Verify the order belongs to the logged-in customer
        Customer customer = customerRepo.findByUserAccount_Username(user.getUsername())
                .orElseThrow(() -> new IllegalArgumentException("Customer not found"));
        
        if (order.getCustomerId() != customer.getCustomerId()) {
            throw new IllegalArgumentException("Access denied: Order does not belong to this customer");
        }

        model.addAttribute("order", order);
        return "customer_view_order";
    }
}
