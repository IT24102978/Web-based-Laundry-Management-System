package com.laundry_management_system.backend.controllers;

import com.laundry_management_system.backend.models.OrderEntity;
import com.laundry_management_system.backend.repositories.OrderRepository;
import com.laundry_management_system.backend.utils.OrderCacheSingleton;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/order-cache")
public class OrderCacheController {

    private final OrderRepository orderRepo;
    private OrderCacheSingleton cacheSingleton;

    public OrderCacheController(OrderRepository orderRepo) {
        this.orderRepo = orderRepo;
        this.cacheSingleton = OrderCacheSingleton.getInstance(orderRepo);
    }

    @GetMapping
    public String viewCache(Model model) {
        List<OrderEntity> orders = cacheSingleton.getAllOrders();
        model.addAttribute("orders", orders);
        model.addAttribute("cacheTime", java.time.LocalDateTime.now());
        return "order_cache_view";
    }

    @GetMapping("/refresh")
    public String refreshCache(Model model) {
        cacheSingleton.refreshCache();
        List<OrderEntity> orders = cacheSingleton.getAllOrders();
        model.addAttribute("orders", orders);
        model.addAttribute("cacheTime", java.time.LocalDateTime.now());
        model.addAttribute("message", "♻️ Cache refreshed successfully!");
        return "order_cache_view";
    }
}
