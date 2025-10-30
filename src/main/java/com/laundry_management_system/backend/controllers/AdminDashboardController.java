
package com.laundry_management_system.backend.controllers;

import com.laundry_management_system.backend.models.ServiceItem;
import com.laundry_management_system.backend.models.UserAccount;
import com.laundry_management_system.backend.services.AdminService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.*;


@Controller
public class AdminDashboardController {

    private final AdminService admin;

    public AdminDashboardController(AdminService admin) {
        this.admin = admin;
    }

    @GetMapping("/admin-dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        Object user = session.getAttribute("USER");

        // Check login
        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("username", session.getAttribute("USERNAME"));
        return "admin_dashboard"; // This points to admin_dashboard.jsp
    }

    // -------- User Accounts --------
    @GetMapping("/users")
    public String users(Model model) {
        model.addAttribute("users", admin.allUsers());
        model.addAttribute("newUser", new UserAccount());
        return "admin_users";
    }

    @PostMapping("/users")
    public String createUser(@ModelAttribute("newUser") UserAccount u,
                             RedirectAttributes ra) {
        // validation
        if (u.getPasswordHash() == null || u.getPasswordHash().length() < 3) {
            ra.addFlashAttribute("msg", "Password must have at least 3 characters.");
            return "redirect:/admin/users";
        }

        if ("ADMIN".equals(u.getRole()) && !u.getUsername().startsWith("A")) {
            ra.addFlashAttribute("msg", "Admin username must start with A.");
            return "redirect:/admin/users";
        }
        if ("CUSTOMER".equals(u.getRole()) && !u.getUsername().startsWith("C")) {
            ra.addFlashAttribute("msg", "Customer username must start with C.");
            return "redirect:/admin/users";
        }
        if ("EMPLOYEE".equals(u.getRole()) && !u.getUsername().startsWith("E")) {
            ra.addFlashAttribute("msg", "Employee username must start with E.");
            return "redirect:/admin/users";
        }


        u.setActive(true);  // force default active


        admin.saveUser(u);
        ra.addFlashAttribute("msg", "User created: " + u.getUsername());
        return "redirect:/admin/users";
    }




    @PostMapping("/users/{id}/delete")
    public String deleteUser(@PathVariable Integer id, RedirectAttributes ra) {
        admin.deleteUser(id);
        ra.addFlashAttribute("msg", "User deleted: " + id);
        return "redirect:/admin/users";
    }

    // -------- Service Items --------
    @GetMapping("/services")
    public String services(Model model) {
        model.addAttribute("services", admin.allServices());
        model.addAttribute("newService", new ServiceItem());
        return "admin_services";
    }

    @PostMapping("/services")
    public String createService(@ModelAttribute("newService") ServiceItem s, RedirectAttributes ra) {
        admin.saveService(s);
        ra.addFlashAttribute("msg", "Service saved: " + s.getServiceName());
        return "redirect:/admin/services";
    }

    @PostMapping("/services/{id}/delete")
    public String deleteService(@PathVariable Integer id, RedirectAttributes ra) {
        admin.deleteService(id);
        ra.addFlashAttribute("msg", "Service deleted: " + id);
        return "redirect:/admin/services";
    }

    // -------- EDIT USER --------
    @GetMapping("/users/{id}/edit")
    public String editUser(@PathVariable Integer id, Model model) {
        UserAccount user = admin.findUserById(id);
        model.addAttribute("user", user);
        return "admin_user_form"; // separate JSP for edit
    }

    @PostMapping("/users/{id}")
    public String updateUser(@PathVariable Integer id,
                             @ModelAttribute("user") UserAccount updated,
                             RedirectAttributes ra) {
        // Find the existing user
        UserAccount existing = admin.findUserById(id);

        if (existing != null) {
            // Keep old password if not updated
            if (updated.getPasswordHash() == null || updated.getPasswordHash().isEmpty()) {
                updated.setPasswordHash(existing.getPasswordHash());
            }

            // Keep createdAt value unchanged
            updated.setCreatedAt(existing.getCreatedAt());

            // Handle active/inactive checkbox properly
            if (!updated.isActive()) {
                updated.setActive(false);

            }

            // Save changes
            admin.updateUser(id, updated);
            ra.addFlashAttribute("msg", "User updated successfully: " + updated.getUsername());
        } else {
            ra.addFlashAttribute("msg", "User not found.");
        }

        return "redirect:/admin/users";
    }


    // -------- EDIT SERVICE --------
    @GetMapping("/services/{id}/edit")
    public String editService(@PathVariable Integer id, Model model) {
        ServiceItem service = admin.findServiceById(id);
        model.addAttribute("service", service);
        return "admin_service_form"; // separate JSP for edit
    }

    @PostMapping("/services/{id}")
    public String updateService(@PathVariable Integer id,
                                @ModelAttribute("service") ServiceItem updated,
                                RedirectAttributes ra) {
        admin.updateService(id, updated);
        ra.addFlashAttribute("msg", "Service updated: " + updated.getServiceName());
        return "redirect:/admin/services";
    }


}

