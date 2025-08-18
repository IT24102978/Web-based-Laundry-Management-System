package com.laundry_mangement_system.backend.controllers;

import com.laundry_mangement_system.backend.models.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequestMapping("/home")
public class HomeController {

    @GetMapping
    public String home(Model model) {
        String userName = "chandupa";
        User user = new User(userName, userName);
        // Get the username from the database (according to the session values maybe)
        model.addAttribute("user", user);
        return "test";
    }


}
