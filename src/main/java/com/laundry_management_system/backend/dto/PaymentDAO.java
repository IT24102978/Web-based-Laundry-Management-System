package com.laundry_management_system.backend.billing.dao;

import com.laundry_management_system.backend.billing.config.DatabaseConfig;
import com.laundry_management_system.backend.billing.model.Payment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Payment operations
 */
public class PaymentDAO {

    /**
     * Get total revenue (sum of all paid payments)
     * @return total revenue amount
     * @throws SQLException if database operation fails
     */
    public double getTotalRevenue() throws SQLException {
        String sql = "SELECT ISNULL(SUM(amount - discount + late_fee - refund_amount), 0) as total " +
                "FROM Payment WHERE status = 'PAID'";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble("total");
            }
        }

        return 0.0;
    }

    /**
     * Get total pending payments
     * @return total pending payment amount
     * @throws SQLException if database operation fails
     */
    public double getPendingPayments() throws SQLException {
        String sql = "SELECT ISNULL(SUM(amount - discount + late_fee - refund_amount), 0) as total " +
                "FROM Payment WHERE status = 'PENDING'";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble("total");
            }
        }

        return 0.0;
    }

    /**
     * Get all payments
     * @return List of all payments
     * @throws SQLException if database operation fails
     */
    public List<Payment> getAllPayments() throws SQLException {
        String sql = "SELECT * FROM Payment ORDER BY payment_date DESC";
        List<Payment> payments = new ArrayList<>();

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setOrderId(rs.getInt("order_id"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setDiscount(rs.getDouble("discount"));
                payment.setLateFee(rs.getDouble("late_fee"));
                payment.setRefundAmount(rs.getDouble("refund_amount"));
                payment.setMethod(rs.getString("method"));
                payment.setStatus(rs.getString("status"));
                payment.setPaymentDate(rs.getTimestamp("payment_date"));

                payments.add(payment);
            }
        }

        return payments;
    }

    /**
     * Get payments within a date range
     * @param startDate Start date
     * @param endDate End date
     * @return List of payments within the date range
     * @throws SQLException if database operation fails
     */
    public List<Payment> getPaymentsByDateRange(Timestamp startDate, Timestamp endDate) throws SQLException {
        String sql = "SELECT * FROM Payment WHERE payment_date >= ? AND payment_date <= ? ORDER BY payment_date DESC";
        List<Payment> payments = new ArrayList<>();

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setTimestamp(1, startDate);
            stmt.setTimestamp(2, endDate);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentId(rs.getInt("payment_id"));
                    payment.setOrderId(rs.getInt("order_id"));
                    payment.setAmount(rs.getDouble("amount"));
                    payment.setDiscount(rs.getDouble("discount"));
                    payment.setLateFee(rs.getDouble("late_fee"));
                    payment.setRefundAmount(rs.getDouble("refund_amount"));
                    payment.setMethod(rs.getString("method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setPaymentDate(rs.getTimestamp("payment_date"));

                    payments.add(payment);
                }
            }
        }

        return payments;
    }

    /**
     * Get payment by ID
     * @param paymentId Payment ID
     * @return Payment object or null if not found
     * @throws SQLException if database operation fails
     */
    public Payment getPaymentById(int paymentId) throws SQLException {
        String sql = "SELECT * FROM Payment WHERE payment_id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, paymentId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentId(rs.getInt("payment_id"));
                    payment.setOrderId(rs.getInt("order_id"));
                    payment.setAmount(rs.getDouble("amount"));
                    payment.setDiscount(rs.getDouble("discount"));
                    payment.setLateFee(rs.getDouble("late_fee"));
                    payment.setRefundAmount(rs.getDouble("refund_amount"));
                    payment.setMethod(rs.getString("method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setPaymentDate(rs.getTimestamp("payment_date"));

                    return payment;
                }
            }
        }

        return null;
    }

    /**
     * Get payment by order ID
     * @param orderId Order ID
     * @return Payment object or null if not found
     * @throws SQLException if database operation fails
     */
    public Payment getPaymentByOrderId(int orderId) throws SQLException {
        String sql = "SELECT * FROM Payment WHERE order_id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentId(rs.getInt("payment_id"));
                    payment.setOrderId(rs.getInt("order_id"));
                    payment.setAmount(rs.getDouble("amount"));
                    payment.setDiscount(rs.getDouble("discount"));
                    payment.setLateFee(rs.getDouble("late_fee"));
                    payment.setRefundAmount(rs.getDouble("refund_amount"));
                    payment.setMethod(rs.getString("method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setPaymentDate(rs.getTimestamp("payment_date"));

                    return payment;
                }
            }
        }

        return null;
    }

    /**
     * Create a new payment
     * @param payment Payment to create
     * @return generated payment ID
     * @throws SQLException if database operation fails
     */
    public int createPayment(Payment payment) throws SQLException {
        String sql = "INSERT INTO Payment (order_id, amount, discount, late_fee, refund_amount, " +
                "method, status, payment_date) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, payment.getOrderId());
            stmt.setDouble(2, payment.getAmount());
            stmt.setDouble(3, payment.getDiscount());
            stmt.setDouble(4, payment.getLateFee());
            stmt.setDouble(5, payment.getRefundAmount());
            stmt.setString(6, payment.getMethod());
            stmt.setString(7, payment.getStatus());
            stmt.setTimestamp(8, payment.getPaymentDate());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating payment failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int paymentId = generatedKeys.getInt(1);
                    payment.setPaymentId(paymentId);
                    return paymentId;
                } else {
                    throw new SQLException("Creating payment failed, no ID obtained.");
                }
            }
        }
    }

    /**
     * Update payment information
     * @param payment Payment with updated information
     * @throws SQLException if database operation fails
     */
    public void updatePayment(Payment payment) throws SQLException {
        String sql = "UPDATE Payment SET amount = ?, discount = ?, late_fee = ?, refund_amount = ?, " +
                "method = ?, status = ?, payment_date = ? " +
                "WHERE payment_id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDouble(1, payment.getAmount());
            stmt.setDouble(2, payment.getDiscount());
            stmt.setDouble(3, payment.getLateFee());
            stmt.setDouble(4, payment.getRefundAmount());
            stmt.setString(5, payment.getMethod());
            stmt.setString(6, payment.getStatus());
            stmt.setTimestamp(7, payment.getPaymentDate());
            stmt.setInt(8, payment.getPaymentId());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Updating payment failed, no rows affected.");
            }
        }
    }

    /**
     * Update payment status
     * @param paymentId Payment ID
     * @param status New status
     * @throws SQLException if database operation fails
     */
    public void updatePaymentStatus(int paymentId, String status) throws SQLException {
        String sql = "UPDATE Payment SET status = ?, payment_date = ? WHERE payment_id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setTimestamp(2, "PAID".equals(status) ? new Timestamp(System.currentTimeMillis()) : null);
            stmt.setInt(3, paymentId);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Updating payment status failed, no rows affected.");
            }
        }
    }

    /**
     * Delete payment
     * @param paymentId Payment ID
     * @throws SQLException if database operation fails
     */
    public void deletePayment(int paymentId) throws SQLException {
        String sql = "DELETE FROM Payment WHERE payment_id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, paymentId);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Deleting payment failed, no rows affected.");
            }
        }
    }

    /**
     * Get payments by status
     * @param status Payment status
     * @return List of payments with the specified status
     * @throws SQLException if database operation fails
     */
    public List<Payment> getPaymentsByStatus(String status) throws SQLException {
        String sql = "SELECT * FROM Payment WHERE status = ? ORDER BY payment_date DESC";
        List<Payment> payments = new ArrayList<>();

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentId(rs.getInt("payment_id"));
                    payment.setOrderId(rs.getInt("order_id"));
                    payment.setAmount(rs.getDouble("amount"));
                    payment.setDiscount(rs.getDouble("discount"));
                    payment.setLateFee(rs.getDouble("late_fee"));
                    payment.setRefundAmount(rs.getDouble("refund_amount"));
                    payment.setMethod(rs.getString("method"));
                    payment.setStatus(rs.getString("status"));
                    payment.setPaymentDate(rs.getTimestamp("payment_date"));

                    payments.add(payment);
                }
            }
        }

        return payments;
    }

    /**
     * Get revenue for current month
     * @return revenue for current month
     * @throws SQLException if database operation fails
     */
    public double getRevenueThisMonth() throws SQLException {
        String sql = "SELECT ISNULL(SUM(amount - discount + late_fee - refund_amount), 0) as total " +
                "FROM Payment WHERE status = 'PAID' " +
                "AND MONTH(payment_date) = MONTH(GETDATE()) AND YEAR(payment_date) = YEAR(GETDATE())";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble("total");
            }
        }

        return 0.0;
    }

    /**
     * Get revenue for previous month
     * @return revenue for previous month
     * @throws SQLException if database operation fails
     */
    public double getRevenuePreviousMonth() throws SQLException {
        String sql = "SELECT ISNULL(SUM(amount - discount + late_fee - refund_amount), 0) as total " +
                "FROM Payment WHERE status = 'PAID' " +
                "AND MONTH(payment_date) = MONTH(DATEADD(MONTH, -1, GETDATE())) " +
                "AND YEAR(payment_date) = YEAR(DATEADD(MONTH, -1, GETDATE()))";

        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble("total");
            }
        }

        return 0.0;
    }
}