package com.laundry_management_system.backend.controllers;

import com.laundry_management_system.backend.models.OrderEntity;
import com.laundry_management_system.backend.repositories.OrderRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/orders")
public class OrderController {
    private final OrderRepository orders;

    public OrderController(OrderRepository orders) {
        this.orders = orders;
    }

    // /orders/{id} -> shows the page with data
    @GetMapping("/{id}")
    public String viewOrder(@PathVariable int id, Model model) {
        OrderEntity order = orders.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Order not found: " + id));
        model.addAttribute("order", order);
        return "view_order"; // /WEB-INF/jsp/view_order.jsp
    }

    // Optional: simple redirect for /view_order?id=123
    @GetMapping("/view")
    public String viewByQuery(@RequestParam("id") int id) {
        return "redirect:/orders/" + id;
    }
}
