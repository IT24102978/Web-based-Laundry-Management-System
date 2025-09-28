// OrderSupportService.java
package com.laundry_management_system.backend.services;

import com.laundry_management_system.backend.repositories.CustomerRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderSupportService {

    private final CustomerRepository customers;

    public OrderSupportService(CustomerRepository customers) {
        this.customers = customers;
    }

    /** Returns ["C001","C002",…] sorted by username. */
    public List<String> customerUsernames() {
        return customers.findAllByOrderByUserAccount_UsernameAsc()
                .stream()
                .map(c -> c.getUserAccount().getUsername())
                .toList();
    }
}
