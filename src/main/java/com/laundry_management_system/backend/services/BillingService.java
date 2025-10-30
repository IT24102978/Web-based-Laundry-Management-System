package com.laundry_management_system.backend.billing.service;

import com.laundry_management_system.backend.billing.dao.CustomerDAO;
import com.laundry_management_system.backend.billing.dao.OrderDAO;
import com.laundry_management_system.backend.billing.dao.PaymentDAO;
import com.laundry_management_system.backend.billing.dao.ServiceItemDAO;
import com.laundry_management_system.backend.billing.model.*;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

/**
 * Service layer for billing operations
 */
@Service
public class BillingService {
    
    private final OrderDAO orderDAO;
    private final CustomerDAO customerDAO;
    private final ServiceItemDAO serviceItemDAO;
    private final PaymentDAO paymentDAO;
    
    public BillingService() {
        this.orderDAO = new OrderDAO();
        this.customerDAO = new CustomerDAO();
        this.serviceItemDAO = new ServiceItemDAO();
        this.paymentDAO = new PaymentDAO();
    }
    
    // Constructor for dependency injection (testing)
    public BillingService(OrderDAO orderDAO, CustomerDAO customerDAO, 
                         ServiceItemDAO serviceItemDAO, PaymentDAO paymentDAO) {
        this.orderDAO = orderDAO;
        this.customerDAO = customerDAO;
        this.serviceItemDAO = serviceItemDAO;
        this.paymentDAO = paymentDAO;
    }
    
    /**
     * Create a new order with payment
     * @param order Order to create
     * @return created order with generated ID
     * @throws ServiceException if operation fails
     */
    public Order createOrder(Order order) throws ServiceException {
        try {
            // Validate order
            validateOrder(order);
            
            // Set default status if not provided
            if (order.getStatus() == null || order.getStatus().trim().isEmpty()) {
                order.setStatus("RECEIVED");
            }
            
            // Set order date if not provided
            if (order.getOrderDate() == null) {
                order.setOrderDate(new Timestamp(System.currentTimeMillis()));
            }
            
            // Calculate total amount
            order.calculateTotalAmount();
            
            // Create payment record if not exists
            if (order.getPayment() == null) {
                Payment payment = new Payment();
                payment.setAmount(order.getTotalAmount());
                payment.setDiscount(order.getDiscount());
                payment.setMethod("CASH");
                payment.setStatus("PENDING");
                order.setPayment(payment);
            }
            
            // Create order in database
            int orderId = orderDAO.createOrder(order);
            order.setOrderId(orderId);
            
            return order;
            
        } catch (SQLException e) {
            throw new ServiceException("Failed to create order: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get all orders with customer information
     * @return List of orders
     * @throws ServiceException if operation fails
     */
    public List<Order> getAllOrders() throws ServiceException {
        try {
            return orderDAO.getAllOrders();
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve orders: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get order by ID
     * @param orderId Order ID
     * @return Order object or null if not found
     * @throws ServiceException if operation fails
     */
    public Order getOrderById(int orderId) throws ServiceException {
        try {
            return orderDAO.getOrderById(orderId);
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve order: " + e.getMessage(), e);
        }
    }
    
    /**
     * Update order status
     * @param orderId Order ID
     * @param status New status
     * @throws ServiceException if operation fails
     */
    public void updateOrderStatus(int orderId, String status) throws ServiceException {
        try {
            // Validate status
            if (status == null || status.trim().isEmpty()) {
                throw new ServiceException("Status cannot be empty");
            }
            
            orderDAO.updateOrderStatus(orderId, status);
            
            // If order is completed, mark payment as paid
            if ("COMPLETED".equalsIgnoreCase(status)) {
                Payment payment = paymentDAO.getPaymentByOrderId(orderId);
                if (payment != null && "PENDING".equalsIgnoreCase(payment.getStatus())) {
                    paymentDAO.updatePaymentStatus(payment.getPaymentId(), "PAID");
                }
            }
            
        } catch (SQLException e) {
            throw new ServiceException("Failed to update order status: " + e.getMessage(), e);
        }
    }
    
    /**
     * Delete order
     * @param orderId Order ID
     * @throws ServiceException if operation fails
     */
    public void deleteOrder(int orderId) throws ServiceException {
        try {
            orderDAO.deleteOrder(orderId);
        } catch (SQLException e) {
            throw new ServiceException("Failed to delete order: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get all customers
     * @return List of customers
     * @throws ServiceException if operation fails
     */
    public List<Customer> getAllCustomers() throws ServiceException {
        try {
            return customerDAO.getAllCustomers();
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve customers: " + e.getMessage(), e);
        }
    }
    
    /**
     * Test what columns exist in the Customer table
     */
    public void testCustomerColumns() {
        try {
            customerDAO.testCustomerColumns();
        } catch (Exception e) {
            System.err.println("Error testing Customer columns: " + e.getMessage());
        }
    }
    
    /**
     * Test what columns exist in the ServiceItem table
     */
    public void testServiceItemColumns() {
        try {
            serviceItemDAO.testServiceItemColumns();
        } catch (Exception e) {
            System.err.println("Error testing ServiceItem columns: " + e.getMessage());
        }
    }
    
    /**
     * Get customer count
     * @return total number of customers
     * @throws ServiceException if operation fails
     */
    public int getCustomerCount() throws ServiceException {
        try {
            return customerDAO.getCustomerCount();
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve customer count: " + e.getMessage(), e);
        }
    }
    
    /**
     * Test database connection
     * @return true if connection is successful
     */
    public boolean testConnection() {
        try {
            return customerDAO.testConnection();
        } catch (Exception e) {
            System.err.println("Database connection test failed: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Get all active service items
     * @return List of active service items
     * @throws ServiceException if operation fails
     */
    public List<ServiceItem> getAllActiveServiceItems() throws ServiceException {
        try {
            return serviceItemDAO.getAllActiveServiceItems();
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve service items: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get dashboard statistics
     * @return Dashboard statistics
     * @throws ServiceException if operation fails
     */
    public DashboardStats getDashboardStats() throws ServiceException {
        try {
            DashboardStats stats = new DashboardStats();
            
            stats.setTotalRevenue(paymentDAO.getTotalRevenue());
            stats.setOrdersThisMonth(orderDAO.getOrderCountThisMonth());
            stats.setPendingPayments(paymentDAO.getPendingPayments());
            
            // Calculate growth percentage
            double currentMonthRevenue = paymentDAO.getRevenueThisMonth();
            double previousMonthRevenue = paymentDAO.getRevenuePreviousMonth();
            
            if (previousMonthRevenue > 0) {
                double growthPercentage = ((currentMonthRevenue - previousMonthRevenue) / previousMonthRevenue) * 100;
                stats.setGrowthPercentage((int) Math.round(growthPercentage));
            } else {
                stats.setGrowthPercentage(0);
            }
            
            return stats;
            
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve dashboard statistics: " + e.getMessage(), e);
        }
    }
    
    /**
     * Process payment for an order
     * @param orderId Order ID
     * @param paymentMethod Payment method
     * @throws ServiceException if operation fails
     */
    public void processPayment(int orderId, String paymentMethod) throws ServiceException {
        try {
            Payment payment = paymentDAO.getPaymentByOrderId(orderId);
            Timestamp now = new Timestamp(System.currentTimeMillis());
            if (payment == null) {
                // Create a payment record if missing (older data or manual inserts)
                Order order = orderDAO.getOrderById(orderId);
                if (order == null) {
                    throw new ServiceException("Order not found: " + orderId);
                }
                // Ensure latest total
                order.calculateTotalAmount();
                Payment newPayment = new Payment();
                newPayment.setOrderId(orderId);
                newPayment.setAmount(order.getTotalAmount());
                newPayment.setDiscount(order.getDiscount());
                newPayment.setLateFee(0.0);
                newPayment.setRefundAmount(0.0);
                newPayment.setMethod(paymentMethod);
                newPayment.setStatus("PAID");
                newPayment.setPaymentDate(now);
                paymentDAO.createPayment(newPayment);
            } else {
                payment.setMethod(paymentMethod);
                payment.setStatus("PAID");
                payment.setPaymentDate(now);
                paymentDAO.updatePayment(payment);
            }
            
            // Update order status to completed
            orderDAO.updateOrderStatus(orderId, "COMPLETED");
            
        } catch (SQLException e) {
            throw new ServiceException("Failed to process payment: " + e.getMessage(), e);
        }
    }
    
    /**
     * Process refund for an order
     * @param orderId Order ID
     * @param refundAmount Refund amount
     * @param reason Refund reason
     * @throws ServiceException if operation fails
     */
    public void processRefund(int orderId, double refundAmount, String reason) throws ServiceException {
        try {
            Payment payment = paymentDAO.getPaymentByOrderId(orderId);
            if (payment == null) {
                throw new ServiceException("Payment record not found for order: " + orderId);
            }
            
            // Validate refund amount
            if (refundAmount <= 0) {
                throw new ServiceException("Refund amount must be greater than 0");
            }
            
            if (refundAmount > payment.getAmount()) {
                throw new ServiceException("Refund amount cannot exceed payment amount");
            }
            
            // Update payment with refund information
            payment.setRefundAmount(refundAmount);
            
            paymentDAO.updatePayment(payment);
            
        } catch (SQLException e) {
            throw new ServiceException("Failed to process refund: " + e.getMessage(), e);
        }
    }
    
    /**
     * Apply discount to an order
     * @param orderId Order ID
     * @param discountPercentage Discount percentage
     * @throws ServiceException if operation fails
     */
    public void applyDiscount(int orderId, double discountPercentage) throws ServiceException {
        try {
            Payment payment = paymentDAO.getPaymentByOrderId(orderId);
            if (payment == null) {
                throw new ServiceException("Payment record not found for order: " + orderId);
            }
            
            // Validate discount percentage
            if (discountPercentage < 0 || discountPercentage > 100) {
                throw new ServiceException("Discount percentage must be between 0 and 100");
            }
            
            // Update payment with discount information
            payment.setDiscount(discountPercentage);
            
            paymentDAO.updatePayment(payment);
            
        } catch (SQLException e) {
            throw new ServiceException("Failed to apply discount: " + e.getMessage(), e);
        }
    }
    
    /**
     * Validate order data
     * @param order Order to validate
     * @throws ServiceException if validation fails
     */
    private void validateOrder(Order order) throws ServiceException {
        if (order == null) {
            throw new ServiceException("Order cannot be null");
        }
        
        if (order.getCustomerId() <= 0) {
            throw new ServiceException("Valid customer must be selected");
        }
        
        if (order.getOrderItems() == null || order.getOrderItems().isEmpty()) {
            throw new ServiceException("Order must have at least one item");
        }
        
        // Validate order items
        for (OrderItem item : order.getOrderItems()) {
            if (item.getServiceItemId() <= 0) {
                throw new ServiceException("Valid service must be selected for all items");
            }
            if (item.getQuantity() <= 0) {
                throw new ServiceException("Quantity must be greater than 0 for all items");
            }
            if (item.getPrice() < 0) {
                throw new ServiceException("Price cannot be negative for any item");
            }
        }
        
        if (order.getDiscount() < 0 || order.getDiscount() > 100) {
            throw new ServiceException("Discount must be between 0 and 100 percent");
        }
    }
    
    /**
     * Inner class for dashboard statistics
     */
    public static class DashboardStats {
        private double totalRevenue;
        private int ordersThisMonth;
        private double pendingPayments;
        private int growthPercentage;
        
        // Getters and setters
        public double getTotalRevenue() { return totalRevenue; }
        public void setTotalRevenue(double totalRevenue) { this.totalRevenue = totalRevenue; }
        
        public int getOrdersThisMonth() { return ordersThisMonth; }
        public void setOrdersThisMonth(int ordersThisMonth) { this.ordersThisMonth = ordersThisMonth; }
        
        public double getPendingPayments() { return pendingPayments; }
        public void setPendingPayments(double pendingPayments) { this.pendingPayments = pendingPayments; }
        
        public int getGrowthPercentage() { return growthPercentage; }
        public void setGrowthPercentage(int growthPercentage) { this.growthPercentage = growthPercentage; }
        
        public String getFormattedTotalRevenue() {
            return String.format("%.2f", totalRevenue);
        }
        
        public String getFormattedPendingPayments() {
            return String.format("%.2f", pendingPayments);
        }
    }
}