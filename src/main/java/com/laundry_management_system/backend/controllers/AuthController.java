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
    public AuthController(AuthService auth) { this.auth = auth; }

    @GetMapping("/login")
    public String loginPage(@RequestParam(value="error", required=false) String error, Model model) {
        model.addAttribute("error", error != null);
        return "login";  // resolves to /WEB-INF/jsp/login.jsp
    }

    @PostMapping("/login")
    public String doLogin(@RequestParam String username,
                          @RequestParam String password,
                          HttpSession session) {
        Optional<UserAccount> user = auth.authenticate(username, password);
        if (user.isPresent()) {
            session.setAttribute("USER", user.get());
            return "redirect:/order_form";
        }
        return "redirect:/login?error=1";
    }
}
