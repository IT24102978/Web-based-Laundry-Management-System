package com.laundry_management_system.backend.billing.model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Invoice entity representing a billing invoice for an order
 */
public class Invoice {
    
    private int invoiceId;
    private int orderId;
    private String invoiceNumber;
    private Timestamp invoiceDate;
    private Customer customer;
    private List<OrderItem> orderItems;
    private double subtotal;
    private double discount;
    private double tax;
    private double totalAmount;
    private String status; // PENDING, PAID, OVERDUE
    private Timestamp dueDate;
    private String notes;
    
    // Constructors
    public Invoice() {}
    
    public Invoice(int orderId, String invoiceNumber, Customer customer, List<OrderItem> orderItems) {
        this.orderId = orderId;
        this.invoiceNumber = invoiceNumber;
        this.customer = customer;
        this.orderItems = orderItems;
        this.invoiceDate = new Timestamp(System.currentTimeMillis());
        this.status = "PENDING";
        this.calculateTotals();
    }
    
    // Calculate totals based on order items
    public void calculateTotals() {
        this.subtotal = 0;
        for (OrderItem item : orderItems) {
            this.subtotal += item.getTotalPrice();
        }
        
        // Calculate total (subtotal - discount + tax)
        this.totalAmount = this.subtotal - this.discount + this.tax;
    }
    
    // Get formatted invoice date
    public String getFormattedInvoiceDate() {
        if (invoiceDate != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return sdf.format(invoiceDate);
        }
        return "";
    }
    
    // Get formatted due date
    public String getFormattedDueDate() {
        if (dueDate != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            return sdf.format(dueDate);
        }
        return "";
    }
    
    // Get formatted total amount
    public String getFormattedTotalAmount() {
        return String.format("Rs. %.2f", totalAmount);
    }
    
    // Get formatted subtotal
    public String getFormattedSubtotal() {
        return String.format("Rs. %.2f", subtotal);
    }
    
    // Get formatted discount
    public String getFormattedDiscount() {
        return String.format("Rs. %.2f", discount);
    }
    
    // Get formatted tax
    public String getFormattedTax() {
        return String.format("Rs. %.2f", tax);
    }
    
    // Generate invoice number
    public static String generateInvoiceNumber(int orderId) {
        // Format: INV-YYYYMMDD-XXXX (where XXXX is the order ID)
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String dateStr = sdf.format(new java.util.Date());
        return "INV-" + dateStr + "-" + String.format("%04d", orderId);
    }
    
    // Getters and Setters
    public int getInvoiceId() {
        return invoiceId;
    }
    
    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }
    
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public String getInvoiceNumber() {
        return invoiceNumber;
    }
    
    public void setInvoiceNumber(String invoiceNumber) {
        this.invoiceNumber = invoiceNumber;
    }
    
    public Timestamp getInvoiceDate() {
        return invoiceDate;
    }
    
    public void setInvoiceDate(Timestamp invoiceDate) {
        this.invoiceDate = invoiceDate;
    }
    
    public Customer getCustomer() {
        return customer;
    }
    
    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
    
    public List<OrderItem> getOrderItems() {
        return orderItems;
    }
    
    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
    
    public double getSubtotal() {
        return subtotal;
    }
    
    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    
    public double getDiscount() {
        return discount;
    }
    
    public void setDiscount(double discount) {
        this.discount = discount;
    }
    
    public double getTax() {
        return tax;
    }
    
    public void setTax(double tax) {
        this.tax = tax;
    }
    
    public double getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getDueDate() {
        return dueDate;
    }
    
    public void setDueDate(Timestamp dueDate) {
        this.dueDate = dueDate;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    @Override
    public String toString() {
        return "Invoice{" +
                "invoiceId=" + invoiceId +
                ", orderId=" + orderId +
                ", invoiceNumber='" + invoiceNumber + '\'' +
                ", invoiceDate=" + invoiceDate +
                ", customer=" + customer +
                ", subtotal=" + subtotal +
                ", discount=" + discount +
                ", tax=" + tax +
                ", totalAmount=" + totalAmount +
                ", status='" + status + '\'' +
                ", dueDate=" + dueDate +
                '}';
    }
}