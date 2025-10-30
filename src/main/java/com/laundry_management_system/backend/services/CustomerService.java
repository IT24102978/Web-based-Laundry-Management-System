package com.laundry_management_system.backend.services;

import com.laundry_management_system.backend.models.Customer;
import com.laundry_management_system.backend.models.UserAccount;
import com.laundry_management_system.backend.repositories.CustomerRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CustomerService {

    private final CustomerRepository repo;
    private final UserAccountService userAccountService;

    public CustomerService(CustomerRepository repo, UserAccountService userAccountService) {
        this.repo = repo;
        this.userAccountService = userAccountService;
    }

    /**
     * ✅ Fetch all customers
     */
    public List<Customer> getAllCustomers() {
        return repo.findAll();
    }

    /**
     * ✅ Get a customer by ID
     */
    public Customer getCustomerById(int id) {
        return repo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Customer not found"));
    }

    /**
     * ✅ Save or update a customer record
     */
    public void saveCustomer(Customer customer) {
        if (customer.getCustomerId() == null) {
            // 🆕 Creating new customer → auto-create linked user account
            String nextUsername = generateNextUsername();
            String password = "1234"; // simple text password for demo

            UserAccount user = new UserAccount();
            user.setUsername(nextUsername);
            user.setPasswordHash(password);
            user.setRole("CUSTOMER");
            user.setCreatedAt(LocalDateTime.now());
            user.setActive(true);

            // ✅ Save user and link it to customer
            user = userAccountService.saveUser(user);
            customer.setUserAccount(user);

        } else {
            // 📝 Updating existing → retain linked user account
            Customer existing = repo.findById(customer.getCustomerId())
                    .orElseThrow(() -> new IllegalArgumentException("Customer not found"));
            customer.setUserAccount(existing.getUserAccount());
        }

        repo.save(customer);
    }

    /**
     * ✅ Delete customer
     */
    public void deleteCustomer(int id) {
        repo.deleteById(id);
    }

    /**
     * ✅ Generate next username (like C001, C002, etc.)
     */
    private String generateNextUsername() {
        List<Customer> all = repo.findAll();
        int max = 0;

        for (Customer c : all) {
            if (c.getUserAccount() != null && c.getUserAccount().getUsername() != null) {
                String username = c.getUserAccount().getUsername();
                if (username.startsWith("C")) {
                    try {
                        int num = Integer.parseInt(username.substring(1));
                        if (num > max) max = num;
                    } catch (NumberFormatException ignored) {}
                }
            }
        }

        return String.format("C%03d", max + 1);
    }
}
