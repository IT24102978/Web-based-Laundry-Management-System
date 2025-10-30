package com.laundry_management_system.backend.controllers;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EmployeeDashboardController {

    @GetMapping("/employee-dashboard")
    public String employeeDashboard(HttpSession session, Model model) {
        Object user = session.getAttribute("USER");

        if (user == null) {
            // not logged in → back to login page
            return "redirect:/login";
        }

        model.addAttribute("username", session.getAttribute("USERNAME"));
        return "employee_dashboard";   // refers to employee_dashboard.jsp
    }
}
