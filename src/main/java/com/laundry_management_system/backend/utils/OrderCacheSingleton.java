package com.laundry_management_system.backend.utils;

import com.laundry_management_system.backend.models.OrderEntity;
import com.laundry_management_system.backend.repositories.OrderRepository;

import java.util.List;

public class OrderCacheSingleton {

    private static OrderCacheSingleton instance;
    private List<OrderEntity> cachedOrders;
    private final OrderRepository orderRepository;

    private OrderCacheSingleton(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
        loadCache(); // Initial load
    }

    public static synchronized OrderCacheSingleton getInstance(OrderRepository orderRepository) {
        if (instance == null) {
            instance = new OrderCacheSingleton(orderRepository);
        }
        return instance;
    }

    private void loadCache() {
        this.cachedOrders = orderRepository.findAll();
        System.out.println("️️♻️♻️ Orders loaded into cache: " + cachedOrders.size());
    }

    public List<OrderEntity> getAllOrders() {
        return cachedOrders;
    }

    public void refreshCache() {
        loadCache();
        System.out.println("♻️ Cache refreshed");
    }
}
