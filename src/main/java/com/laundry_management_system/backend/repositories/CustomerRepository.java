package com.laundry_management_system.backend.repositories;

import com.laundry_management_system.backend.models.Customer;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CustomerRepository extends JpaRepository<Customer, Integer> {

    // Find one customer by their linked username
    Optional<Customer> findByUserAccount_Username(String username);

    // Fetch all customers sorted by username
    List<Customer> findAllByOrderByUserAccount_UsernameAsc();
}
