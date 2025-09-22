package com.laundry_management_system.backend.services;

import com.laundry_management_system.backend.models.OrderEntity;
import com.laundry_management_system.backend.models.OrderItem;
import com.laundry_management_system.backend.repositories.OrderRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {
    private final OrderRepository orders;
    public OrderService(OrderRepository orders){ this.orders = orders; }

    public List<OrderEntity> findAll(){ return orders.findAll(); }
    public OrderEntity findById(Integer id){ return orders.findById(id).orElseThrow(); }

    @Transactional
    public OrderEntity save(OrderEntity e) {
        // ensure items are linked
        if (e.getItems()!=null) for (OrderItem i : e.getItems()) i.setOrder(e);
        return orders.save(e);
    }

    @Transactional
    public void delete(Integer id){ orders.deleteById(id); }
}
