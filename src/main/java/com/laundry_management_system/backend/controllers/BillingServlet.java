package com.laundry_management_system.backend.billing.controller;

import com.laundry_management_system.backend.billing.model.*;
import com.laundry_management_system.backend.billing.service.BillingService;
import com.laundry_management_system.backend.billing.service.ServiceException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/billing")
public class BillingServlet {

    private final BillingService billingService;

    public BillingServlet(BillingService billingService) {
        this.billingService = billingService;
    }

    @GetMapping("/orders")
    public ResponseEntity<List<Order>> getOrders() throws ServiceException {
        return ResponseEntity.ok(billingService.getAllOrders());
    }

    @GetMapping("/customers")
    public ResponseEntity<List<Customer>> getCustomers() throws ServiceException {
        return ResponseEntity.ok(billingService.getAllCustomers());
    }

    @GetMapping("/services")
    public ResponseEntity<List<ServiceItem>> getServices() throws ServiceException {
        return ResponseEntity.ok(billingService.getAllActiveServiceItems());
    }

    @GetMapping("/order/{id}")
    public ResponseEntity<Order> getOrder(@PathVariable int id) throws ServiceException {
        Order order = billingService.getOrderById(id);
        if (order == null) return ResponseEntity.notFound().build();
        return ResponseEntity.ok(order);
    }

    @PostMapping("/create-order")
    public ResponseEntity<Order> createOrder(@RequestBody Order order) throws ServiceException {
        return ResponseEntity.status(201).body(billingService.createOrder(order));
    }

    @PutMapping("/update-status")
    public ResponseEntity<?> updateStatus(@RequestParam int orderId, @RequestParam String status)
            throws ServiceException {
        billingService.updateOrderStatus(orderId, status);
        return ResponseEntity.ok("{\"message\":\"Order status updated successfully\"}");
    }

    @PostMapping("/process-payment")
    public ResponseEntity<?> processPayment(@RequestParam int orderId,
                                            @RequestParam String paymentMethod) {
        try {
            billingService.processPayment(orderId, paymentMethod);
            return ResponseEntity.ok("{\"message\":\"Payment processed successfully\"}");
        } catch (ServiceException se) {
            System.err.println("process-payment failed: " + se.getMessage());
            return ResponseEntity.badRequest().body("{\"error\":\"" + se.getMessage().replace("\"", "'") + "\"}");
        } catch (Exception e) {
            System.err.println("process-payment unexpected error: " + e.getMessage());
            return ResponseEntity.status(500).body("{\"error\":\"" + (e.getMessage() == null ? "Internal Server Error" : e.getMessage().replace("\"", "'")) + "\"}");
        }
    }

    @PostMapping("/process-refund")
    public ResponseEntity<?> processRefund(@RequestParam int orderId,
                                           @RequestParam double refundAmount,
                                           @RequestParam String reason)
            throws ServiceException {
        billingService.processRefund(orderId, refundAmount, reason);
        return ResponseEntity.ok("{\"message\":\"Refund processed successfully\"}");
    }

    @PostMapping("/apply-discount")
    public ResponseEntity<?> applyDiscount(@RequestParam int orderId,
                                           @RequestParam double discountPercentage)
            throws ServiceException {
        billingService.applyDiscount(orderId, discountPercentage);
        return ResponseEntity.ok("{\"message\":\"Discount applied successfully\"}");
    }

    @DeleteMapping("/order/{id}")
    public ResponseEntity<?> deleteOrder(@PathVariable int id) throws ServiceException {
        billingService.deleteOrder(id);
        return ResponseEntity.ok("{\"message\":\"Order deleted successfully\"}");
    }
}
