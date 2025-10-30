package com.laundry_management_system.backend.repositories;

import com.laundry_management_system.backend.models.OrderEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<OrderEntity, Integer> {

    List<OrderEntity> findByCustomerId(Integer customerId);

}


