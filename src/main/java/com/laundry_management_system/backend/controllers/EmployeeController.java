package com.laundry_management_system.backend.controllers;

import com.laundry_management_system.backend.models.Employee;
import com.laundry_management_system.backend.models.UserAccount;
import com.laundry_management_system.backend.services.EmployeeService;
import com.laundry_management_system.backend.services.UserAccountService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/employees")
public class EmployeeController {

    private final EmployeeService employeeService;
    private final UserAccountService userAccountService;

    public EmployeeController(EmployeeService employeeService, UserAccountService userAccountService) {
        this.employeeService = employeeService;
        this.userAccountService = userAccountService;
    }

    // ✅ Employee list page
    @GetMapping
    public String listEmployees(HttpSession session, Model model) {
        if (session.getAttribute("USER") == null) {
            return "redirect:/login";
        }

        model.addAttribute("employees", employeeService.getAllEmployees());
        return "employee_list";
    }

    // ✅ Edit employee (existing)
    @GetMapping("/edit/{id}")
    public String editEmployeeForm(@PathVariable int id, Model model) {
        model.addAttribute("employee", employeeService.getEmployeeById(id));
        model.addAttribute("users", userAccountService.getAllUsers());
        model.addAttribute("managers", employeeService.getAllEmployees()); // ✅ Add this
        return "employee_form";
    }

    // ✅ Save (new or updated)
    @PostMapping("/save")
    public String saveEmployee(@ModelAttribute Employee employee) {
        // Preserve linked user account
        Employee existing = employeeService.getEmployeeById(employee.getEmployeeId());
        employee.setUserAccount(existing.getUserAccount());

        employeeService.saveEmployee(employee);
        return "redirect:/employees";
    }

    // ✅ Delete employee
    @GetMapping("/delete/{id}")
    public String deleteEmployee(@PathVariable int id) {
        employeeService.deleteEmployee(id);
        return "redirect:/employees";
    }

    // ✅ Add new employee account form
    @GetMapping("/new")
    public String newEmployeeAccountForm(Model model) {
        String nextUsername = userAccountService.getNextUsername();
        model.addAttribute("employee", new Employee());
        model.addAttribute("username", nextUsername);
        model.addAttribute("managers", employeeService.getAllEmployees()); // ✅ Add this
        return "employee_account_form";
    }

    // ✅ Create a new employee account
    @PostMapping("/create-account")
    public String createEmployeeAccount(@RequestParam String username,
                                        @RequestParam String password,
                                        @ModelAttribute Employee employee) {

        // 1️⃣ Create linked user account
        UserAccount user = userAccountService.createUser(username, password, "EMPLOYEE");

        // 2️⃣ Link employee with the user account
        employee.setUserAccount(user);

        // 3️⃣ Save employee (includes isManager flag)
        employeeService.saveEmployee(employee);

        return "redirect:/employees";
    }
}
