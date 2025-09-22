package com.laundry_management_system.backend.models;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "Order", schema = "dbo")   // Hibernate will quote it
public class OrderEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Integer orderId;

    @Column(name = "customer_id", nullable = false)
    private Integer customerId;

    @Column(name = "order_date", nullable = false)
    private LocalDateTime orderDate = LocalDateTime.now();

    @Column(name = "pickup_date")
    private LocalDateTime pickupDate;

    @Column(name = "delivery_date")
    private LocalDateTime deliveryDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    private OrderStatus status = OrderStatus.RECEIVED;

    @Column(name = "instructions", length = 800)
    private String instructions;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderItem> items = new ArrayList<>();

    // ---- getters / setters ----
    public Integer getOrderId() { return orderId; }

    public Integer getCustomerId() { return customerId; }
    public void setCustomerId(Integer customerId) { this.customerId = customerId; }

    public LocalDateTime getOrderDate() { return orderDate; }
    public void setOrderDate(LocalDateTime orderDate) { this.orderDate = orderDate; }

    public LocalDateTime getPickupDate() { return pickupDate; }
    public void setPickupDate(LocalDateTime pickupDate) { this.pickupDate = pickupDate; }

    public LocalDateTime getDeliveryDate() { return deliveryDate; }
    public void setDeliveryDate(LocalDateTime deliveryDate) { this.deliveryDate = deliveryDate; }

    public OrderStatus getStatus() { return status; }
    public void setStatus(OrderStatus status) { this.status = status; }

    public String getInstructions() { return instructions; }
    public void setInstructions(String instructions) { this.instructions = instructions; }

    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) {
        this.items.clear();
        if (items != null) for (OrderItem i : items) addItem(i);
    }

    public void addItem(OrderItem item) {
        item.setOrder(this);
        this.items.add(item);
    }

    public void removeItem(OrderItem item) {
        item.setOrder(null);
        this.items.remove(item);
    }
}
