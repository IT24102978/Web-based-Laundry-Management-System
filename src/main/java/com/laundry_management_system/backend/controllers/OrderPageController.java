//package com.laundry_management_system.backend.controllers;
//
//import com.laundry_management_system.backend.models.OrderEntity;
//import com.laundry_management_system.backend.services.OrderSupportService;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//
//@Controller
//public class OrderPageController {
//
//    private final OrderSupportService support;
//
//    public OrderPageController(OrderSupportService support) {
//        this.support = support;
//    }
//
//    @GetMapping("/orders/new")
//    public String createForm(Model model) {
//        model.addAttribute("order", new OrderEntity()); // <-- use OrderEntity, not Order
//        model.addAttribute("customerUsernames", support.customerUsernames());
//        return "order_form"; // your JSP: /WEB-INF/jsp/order_form.jsp
//    }
//}
