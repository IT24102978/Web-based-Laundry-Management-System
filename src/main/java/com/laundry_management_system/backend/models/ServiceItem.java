package com.laundry_management_system.backend.models;
import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity
@Table(name = "ServiceItem")
public class ServiceItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "service_item_id")
    private Integer serviceItemId;

    @Column(name = "service_name", nullable = false, length = 120)
    private String serviceName;

    @Column(name = "description", length = 500)
    private String description;

    @Column(name = "unit_price", nullable = false)
    private BigDecimal unitPrice;


    // --- getters / setters ---
    public Integer getServiceItemId() { return serviceItemId; }
    public void setServiceItemId(Integer serviceItemId) { this.serviceItemId = serviceItemId; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public BigDecimal getUnitPrice() { return unitPrice; }
    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }
}

