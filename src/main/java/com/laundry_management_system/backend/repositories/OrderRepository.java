package com.laundry_management_system.backend.repositories;

import com.laundry_management_system.backend.models.OrderEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<OrderEntity, Integer> {}


