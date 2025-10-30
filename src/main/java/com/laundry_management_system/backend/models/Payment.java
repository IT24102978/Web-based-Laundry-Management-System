package com.laundry_management_system.backend.billing.model;

import java.sql.Timestamp;

/**
 * Payment entity representing payment information for an order
 */
public class Payment {
    
    private int paymentId;
    private int orderId;
    private double amount;
    private double discount;
    private double lateFee;
    private double refundAmount;
    private String method;
    private String status;
    private Timestamp paymentDate;
    private String transactionId;
    private String notes;
    
    // Constructors
    public Payment() {}
    
    public Payment(int orderId, double amount, String method, String status) {
        this.orderId = orderId;
        this.amount = amount;
        this.method = method;
        this.status = status;
        this.discount = 0.0;
        this.lateFee = 0.0;
        this.refundAmount = 0.0;
    }
    
    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }
    
    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }
    
    public int getOrderId() {
        return orderId;
    }
    
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public double getAmount() {
        return amount;
    }
    
    public void setAmount(double amount) {
        this.amount = amount;
    }
    
    public double getDiscount() {
        return discount;
    }
    
    public void setDiscount(double discount) {
        this.discount = discount;
    }
    
    public double getLateFee() {
        return lateFee;
    }
    
    public void setLateFee(double lateFee) {
        this.lateFee = lateFee;
    }
    
    public double getRefundAmount() {
        return refundAmount;
    }
    
    public void setRefundAmount(double refundAmount) {
        this.refundAmount = refundAmount;
    }
    
    public String getMethod() {
        return method;
    }
    
    public void setMethod(String method) {
        this.method = method;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getPaymentDate() {
        return paymentDate;
    }
    
    public void setPaymentDate(Timestamp paymentDate) {
        this.paymentDate = paymentDate;
    }
    
    public String getTransactionId() {
        return transactionId;
    }
    
    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    
    /**
     * Calculate final amount after discount, late fee, and refund
     * @return final amount to be paid/received
     */
    public double getFinalAmount() {
        return amount - discount + lateFee - refundAmount;
    }
    
    /**
     * Get formatted final amount
     * @return formatted final amount with currency
     */
    public String getFormattedFinalAmount() {
        return String.format("LKR. %.2f", getFinalAmount());
    }
    
    /**
     * Check if payment is completed
     * @return true if payment status is PAID
     */
    public boolean isPaid() {
        return "PAID".equalsIgnoreCase(status);
    }
    
    /**
     * Check if payment is pending
     * @return true if payment status is PENDING
     */
    public boolean isPending() {
        return "PENDING".equalsIgnoreCase(status);
    }
    
    @Override
    public String toString() {
        return "Payment{" +
                "paymentId=" + paymentId +
                ", orderId=" + orderId +
                ", amount=" + amount +
                ", discount=" + discount +
                ", method='" + method + '\'' +
                ", status='" + status + '\'' +
                ", finalAmount=" + getFinalAmount() +
                '}';
    }
}

