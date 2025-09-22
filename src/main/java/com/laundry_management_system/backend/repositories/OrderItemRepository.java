package com.laundry_management_system.backend.repositories;

import com.laundry_management_system.backend.models.OrderItem;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderItemRepository extends JpaRepository<OrderItem, Integer> {
    List<OrderItem> findByOrder_OrderId(Integer orderId);
}
