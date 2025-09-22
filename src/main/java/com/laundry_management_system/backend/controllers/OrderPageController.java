package com.laundry_management_system.backend.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OrderPageController {

    @GetMapping("/view_order")
    public String viewOrderPage(Model model) {
        // add any model attributes you want to show on the page
        // model.addAttribute("order", ...);
        return "view_order"; // -> /WEB-INF/jsp/view_order.jsp
    }
}
