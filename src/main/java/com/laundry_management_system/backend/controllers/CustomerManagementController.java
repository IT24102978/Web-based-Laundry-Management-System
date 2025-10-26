package com.laundry_management_system.backend.controllers;

import com.laundry_management_system.backend.models.Customer;
import com.laundry_management_system.backend.services.CustomerService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/customers")
public class CustomerManagementController {

    private final CustomerService customerService;

    public CustomerManagementController(CustomerService customerService) {
        this.customerService = customerService;
    }

    // ✅ View all customers
    @GetMapping
    public String listCustomers(HttpSession session, Model model) {
        if (session.getAttribute("USER") == null) {
            return "redirect:/login";
        }

        model.addAttribute("customers", customerService.getAllCustomers());
        return "customers"; // customers.jsp
    }

    // ✅ Create new customer form
    @GetMapping("/new")
    public String newCustomerForm(Model model) {
        model.addAttribute("customer", new Customer());
        return "customer_form";
    }

    // ✅ Edit existing customer
    @GetMapping("/edit/{id}")
    public String editCustomerForm(@PathVariable int id, Model model) {
        model.addAttribute("customer", customerService.getCustomerById(id));
        return "customer_form";
    }

    // ✅ Save (new or updated)
    @PostMapping("/save")
    public String saveCustomer(@ModelAttribute Customer customer) {
        customerService.saveCustomer(customer);
        return "redirect:/customers";
    }

    // ✅ Delete customer
    @GetMapping("/delete/{id}")
    public String deleteCustomer(@PathVariable int id) {
        customerService.deleteCustomer(id);
        return "redirect:/customers";
    }
}
