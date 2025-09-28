package com.laundry_management_system.backend.controllers;

import com.laundry_management_system.backend.dto.SignupForm;
import com.laundry_management_system.backend.services.SignupService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/signup")
public class SignupController {

    private final SignupService signupService;

    public SignupController(SignupService signupService) {
        this.signupService = signupService;
    }

    @GetMapping
    public String form(Model model) {
        SignupForm form = new SignupForm();
        form.setUsername(signupService.nextUsername(com.laundry_management_system.backend.enums.Role.CUSTOMER)); // readonly in JSP
        model.addAttribute("form", form);
        return "signup";
    }

    @PostMapping
    public String submit(@ModelAttribute("form") SignupForm form, RedirectAttributes ra) {
        var ua = signupService.signup(form); // server enforces CUSTOMER
        ra.addFlashAttribute("msg", "Account created for " + ua.getUsername());
        return "redirect:/login";
    }


}