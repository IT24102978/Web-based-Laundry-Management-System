package com.laundry_management_system.backend.billing.service;

import com.laundry_management_system.backend.billing.dao.OrderDAO;
import com.laundry_management_system.backend.billing.dao.PaymentDAO;
import com.laundry_management_system.backend.billing.model.*;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

/**
 * Service layer for invoice operations
 */
@Service
public class InvoiceService {
    
    private final OrderDAO orderDAO;
    private final PaymentDAO paymentDAO;
    
    public InvoiceService() {
        this.orderDAO = new OrderDAO();
        this.paymentDAO = new PaymentDAO();
    }
    
    // Constructor for dependency injection (testing)
    public InvoiceService(OrderDAO orderDAO, PaymentDAO paymentDAO) {
        this.orderDAO = orderDAO;
        this.paymentDAO = paymentDAO;
    }
    
    /**
     * Generate invoice for an order
     * @param orderId Order ID
     * @return generated invoice
     * @throws ServiceException if operation fails
     */
    public Invoice generateInvoice(int orderId) throws ServiceException {
        try {
            // Get order details
            Order order = orderDAO.getOrderById(orderId);
            if (order == null) {
                throw new ServiceException("Order not found with ID: " + orderId);
            }
            
            // Create invoice
            String invoiceNumber = Invoice.generateInvoiceNumber(orderId);
            Invoice invoice = new Invoice(orderId, invoiceNumber, order.getCustomer(), order.getOrderItems());
            
            // Set invoice details
            invoice.setSubtotal(order.getTotalAmount());
            invoice.setDiscount(order.getDiscount());
            invoice.setTax(0.0); // For now, no tax
            invoice.setTotalAmount(order.calculateTotalAmount());
            invoice.setInvoiceDate(order.getOrderDate());
            
            // Set due date (7 days from order date)
            if (order.getOrderDate() != null) {
                LocalDateTime dueDateTime = order.getOrderDate().toLocalDateTime().plus(7, ChronoUnit.DAYS);
                invoice.setDueDate(Timestamp.valueOf(dueDateTime));
            }
            
            // Set status based on payment status
            Payment payment = paymentDAO.getPaymentByOrderId(orderId);
            if (payment != null) {
                invoice.setStatus(payment.getStatus());
            } else {
                invoice.setStatus("PENDING");
            }
            
            return invoice;
            
        } catch (SQLException e) {
            throw new ServiceException("Failed to generate invoice: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get all invoices
     * @return List of all invoices
     * @throws ServiceException if operation fails
     */
    public List<Invoice> getAllInvoices() throws ServiceException {
        try {
            // For now, we'll generate invoices for all orders
            // In a real implementation, you might have a separate Invoice table
            List<Order> orders = orderDAO.getAllOrders();
            // Implementation would depend on how invoices are stored
            throw new ServiceException("Not implemented yet");
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve invoices: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get invoice by ID
     * @param invoiceId Invoice ID
     * @return Invoice object or null if not found
     * @throws ServiceException if operation fails
     */
    public Invoice getInvoiceById(int invoiceId) throws ServiceException {
        // Implementation would depend on how invoices are stored
        throw new ServiceException("Not implemented yet");
    }
    
    /**
     * Update invoice status
     * @param invoiceId Invoice ID
     * @param status New status
     * @throws ServiceException if operation fails
     */
    public void updateInvoiceStatus(int invoiceId, String status) throws ServiceException {
        // Implementation would depend on how invoices are stored
        throw new ServiceException("Not implemented yet");
    }
    
    /**
     * Send invoice reminder for overdue payments
     * @param orderId Order ID
     * @return reminder message
     * @throws ServiceException if operation fails
     */
    public String sendInvoiceReminder(int orderId) throws ServiceException {
        try {
            Order order = orderDAO.getOrderById(orderId);
            if (order == null) {
                throw new ServiceException("Order not found with ID: " + orderId);
            }
            
            Payment payment = paymentDAO.getPaymentByOrderId(orderId);
            if (payment == null || !"PENDING".equals(payment.getStatus())) {
                throw new ServiceException("No pending payment found for order: " + orderId);
            }
            
            // In a real implementation, you would send an email or SMS
            // For now, we'll just return a message
            return "Reminder sent to customer " + order.getCustomer().getFullName() + 
                   " for order #" + order.getOrderNumber() + 
                   " with amount " + payment.getFormattedFinalAmount();
            
        } catch (SQLException e) {
            throw new ServiceException("Failed to send invoice reminder: " + e.getMessage(), e);
        }
    }
    
    /**
     * Get all overdue invoices
     * @return List of overdue invoices
     * @throws ServiceException if operation fails
     */
    public List<Order> getOverdueInvoices() throws ServiceException {
        try {
            // Get all orders with PENDING status
            List<Order> orders = orderDAO.getAllOrders();
            // In a real implementation, you would filter by actual due dates
            // For now, we'll return all orders with PENDING status
            orders.removeIf(order -> !"PENDING".equals(order.getStatus()));
            return orders;
        } catch (SQLException e) {
            throw new ServiceException("Failed to retrieve overdue invoices: " + e.getMessage(), e);
        }
    }
}