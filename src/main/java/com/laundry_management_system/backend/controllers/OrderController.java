package com.laundry_management_system.backend.controllers;

import com.laundry_management_system.backend.models.Customer;
import com.laundry_management_system.backend.models.OrderEntity;
import com.laundry_management_system.backend.repositories.CustomerRepository;
import com.laundry_management_system.backend.repositories.OrderRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/orders")
public class OrderController {

    private final OrderRepository orders;
    private final CustomerRepository customers;

    public OrderController(OrderRepository orders, CustomerRepository customers) {
        this.orders = orders;
        this.customers = customers;
    }

    /** Build list like ["C001","C002",...] for dropdowns */
    private List<String> customerUsernames() {
        return customers.findAllByOrderByUserAccount_UsernameAsc()
                .stream()
                .map(c -> c.getUserAccount().getUsername())
                .toList();
    }

    /** LIST page (with inline create form on order.jsp) */
    @GetMapping
    public String list(Model model) {
        model.addAttribute("orders", orders.findAll());
        model.addAttribute("newOrder", new OrderEntity()); // inline create form
        model.addAttribute("customerUsernames", customerUsernames());
        return "order";
    }

    /** CREATE from inline form on /orders */
    @PostMapping
    @Transactional
    public String create(@ModelAttribute("newOrder") OrderEntity newOrder,
                         @RequestParam(value = "customerUsername", required = false) String customerUsername,
                         RedirectAttributes ra) {

        if (customerUsername != null && !customerUsername.isBlank()) {
            Customer c = customers.findByUserAccount_Username(customerUsername)
                    .orElseThrow(() -> new IllegalArgumentException("Unknown customer username: " + customerUsername));
            newOrder.setCustomerId(c.getCustomerId());
        }

        orders.save(newOrder);
        ra.addFlashAttribute("msg", "Order #" + newOrder.getOrderId() + " created.");
        return "redirect:/orders";
    }

    /** VIEW single order */
    @GetMapping("/{id}")
    public String view(@PathVariable int id, Model model) {
        OrderEntity order = orders.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Order not found: " + id));
        model.addAttribute("order", order);
        return "view_order";
    }

    /** EDIT page (uses order_form.jsp) */
    @GetMapping("/{id}/edit")
    public String edit(@PathVariable int id, Model model) {
        OrderEntity order = orders.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Order not found: " + id));
        model.addAttribute("order", order);
        model.addAttribute("mode", "edit");
        model.addAttribute("customerUsernames", customerUsernames());
        return "order_form";
    }

    /** UPDATE */
    @PostMapping("/{id}")
    @Transactional
    public String update(@PathVariable int id,
                         @ModelAttribute("order") OrderEntity fromForm,
                         @RequestParam(value = "customerUsername", required = false) String customerUsername,
                         RedirectAttributes ra) {

        OrderEntity existing = orders.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Order not found: " + id));

        if (customerUsername != null && !customerUsername.isBlank()) {
            Customer c = customers.findByUserAccount_Username(customerUsername)
                    .orElseThrow(() -> new IllegalArgumentException("Unknown customer username: " + customerUsername));
            existing.setCustomerId(c.getCustomerId());
        } else {
            existing.setCustomerId(fromForm.getCustomerId()); // fallback if numeric id is posted
        }

        existing.setStatus(fromForm.getStatus());
        existing.setOrderDate(fromForm.getOrderDate());
        existing.setPickupDate(fromForm.getPickupDate());
        existing.setDeliveryDate(fromForm.getDeliveryDate());
        existing.setInstructions(fromForm.getInstructions());

        orders.save(existing);
        ra.addFlashAttribute("msg", "Order #" + id + " updated.");
        return "redirect:/orders/" + id;
    }

    /** CREATE page (dedicated) */
    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("order", new OrderEntity());
        model.addAttribute("mode", "create");
        model.addAttribute("customerUsernames", customerUsernames());
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
