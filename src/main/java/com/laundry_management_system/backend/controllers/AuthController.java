package com.laundry_management_system.backend.controllers;

import com.laundry_management_system.backend.models.UserAccount;
import com.laundry_management_system.backend.services.AuthService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@Controller
public class AuthController {

    private final AuthService auth;

    public AuthController(AuthService auth) {
        this.auth = auth;
    }

    // Public home page
    @GetMapping("/")
    public String homePage() {
        return "home";
    }

    @GetMapping("/login")
    public String loginPage(@RequestParam(value = "error", required = false) String error, Model model) {
        model.addAttribute("error", error != null);
        return "login";
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String username,
                          @RequestParam String password,
                          HttpSession session) {
        Optional<UserAccount> user = auth.authenticate(username, password);

        if (user.isPresent()) {
            UserAccount ua = user.get();
            session.setAttribute("USER", ua);

            // Identify user type by prefix
            char prefix = Character.toUpperCase(username.charAt(0));

            switch (prefix) {
                case 'A':
                    return "redirect:/admin-dashboard";
                case 'E':
                    return "redirect:/employee-dashboard";
                case 'C':
                    return "redirect:/customer-dashboard";
                default:
                    // Unknown prefix → redirect to home
                    return "redirect:/home";
            }
        }

        // Login failed
        return "redirect:/login?error=1";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // clear session
        return "redirect:/login?logout";
    }
}
