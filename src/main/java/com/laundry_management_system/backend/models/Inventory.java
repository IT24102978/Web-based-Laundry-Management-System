package com.laundry_management_system.backend.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;

import java.time.LocalDateTime;

@Entity
@Table(name = "Inventory")
public class Inventory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "item_id")
    private Integer itemId;

    @Column(name = "item_name", nullable = false)
    @NotBlank
    private String itemName;

    @Column(name = "stock_level", nullable = false)
    @Min(0)
    private int stockLevel;

    @Column(name = "reorder_threshold", nullable = false)
    @Min(0)
    private int reorderThreshold;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt = LocalDateTime.now();

    public Inventory() {}

    public Inventory(String itemName, int stockLevel, int reorderThreshold) {
        this.itemName = itemName;
        this.stockLevel = stockLevel;
        this.reorderThreshold = reorderThreshold;
        this.updatedAt = LocalDateTime.now();
    }

    // Getters & Setters
    public Integer getItemId() { return itemId; }
    public void setItemId(Integer itemId) { this.itemId = itemId; }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }

    public int getStockLevel() { return stockLevel; }
    public void setStockLevel(int stockLevel) { this.stockLevel = stockLevel; }

    public int getReorderThreshold() { return reorderThreshold; }
    public void setReorderThreshold(int reorderThreshold) { this.reorderThreshold = reorderThreshold; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
