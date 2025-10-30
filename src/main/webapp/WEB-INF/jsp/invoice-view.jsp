<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.laundry_management_system.backend.billing.model.Invoice" %>
<%@ page import="com.laundry_management_system.backend.billing.model.OrderItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice - Laundry Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        :root {
            --primary: #0054A6; /* Sri Lankan blue */
            --secondary: #FFB400; /* Sri Lankan gold */
            --danger: #E42529; /* Sri Lankan red */
            --warning: #FF7E00;
            --dark: #1A3E72;
            --light: #F0F8FF;
            --success: #28a745;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        body {
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: var(--shadow);
            padding: 30px;
        }

        header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid var(--primary);
        }

        .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
            margin-bottom: 15px;
        }

        .logo i {
            font-size: 2.5rem;
            color: var(--primary);
        }

        .logo h1 {
            font-size: 2rem;
            color: var(--dark);
        }

        .invoice-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
        }

        .invoice-details {
            flex: 1;
        }

        .invoice-details h2 {
            color: var(--dark);
            margin-bottom: 10px;
        }

        .invoice-details p {
            margin-bottom: 5px;
        }

        .invoice-meta {
            background: var(--light);
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .invoice-meta p {
            margin-bottom: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: var(--primary);
            color: white;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .text-right {
            text-align: right;
        }

        .summary {
            width: 300px;
            margin-left: auto;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
        }

        .summary-row.total {
            border-top: 2px solid #333;
            font-weight: bold;
            font-size: 1.1rem;
            margin-top: 5px;
        }

        .actions {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: #004085;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .btn-success {
            background-color: var(--success);
            color: white;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .status-paid {
            background-color: #d4edda;
            color: #155724;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-overdue {
            background-color: #f8d7da;
            color: #721c24;
        }

        footer {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            color: #7f8c8d;
        }

        @media print {
            body {
                padding: 0;
                background: white;
            }
            
            .container {
                box-shadow: none;
                padding: 20px;
            }
            
            .actions {
                display: none;
            }
        }

        @media (max-width: 768px) {
            .invoice-header {
                flex-direction: column;
                gap: 20px;
            }
            
            .summary {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="logo">
                <i class="fas fa-tshirt"></i>
                <h1>LaundryPro Lanka</h1>
            </div>
            <p>Premium Laundry Services - Sri Lanka</p>
            <p>No. 123, Main Street, Colombo 01</p>
            <p>Phone: +94 11 234 5678 | Email: info@laundrypro.lk</p>
        </header>

        <%
            Invoice invoice = (Invoice) request.getAttribute("invoice");
            if (invoice != null) {
        %>

        <div class="invoice-header">
            <div class="invoice-details">
                <h2>INVOICE</h2>
                <p><strong>Invoice #:</strong> <%= invoice.getInvoiceNumber() %></p>
                <p><strong>Invoice Date:</strong> <%= invoice.getFormattedInvoiceDate() %></p>
                <p><strong>Due Date:</strong> <%= invoice.getFormattedDueDate() %></p>
            </div>
            
            <div class="invoice-details">
                <h2>BILLED TO</h2>
                <p><strong><%= invoice.getCustomer().getFullName() %></strong></p>
                <p><%= invoice.getCustomer().getFullAddress() %></p>
                <p>Phone: <%= invoice.getCustomer().getPhone() %></p>
                <p>Email: <%= invoice.getCustomer().getEmail() %></p>
            </div>
        </div>

        <div class="invoice-meta">
            <p><strong>Order #:</strong> <%= invoice.getOrderId() %></p>
            <p><strong>Status:</strong> 
                <span class="status-badge status-<%= invoice.getStatus().toLowerCase() %>">
                    <%= invoice.getStatus() %>
                </span>
            </p>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Service</th>
                    <th>Quantity</th>
                    <th>Unit Price (LKR)</th>
                    <th>Total (LKR)</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (OrderItem item : invoice.getOrderItems()) {
                %>
                <tr>
                    <td><%= item.getServiceName() %></td>
                    <td><%= item.getQuantity() %></td>
                    <td class="text-right"><%= String.format("Rs. %.2f", item.getPrice()) %></td>
                    <td class="text-right"><%= item.getFormattedTotalPrice() %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <div class="summary">
            <div class="summary-row">
                <span>Subtotal:</span>
                <span><%= invoice.getFormattedSubtotal() %></span>
            </div>
            <div class="summary-row">
                <span>Discount (<%= String.format("%.2f", invoice.getDiscount()) %>%):</span>
                <span>- <%= invoice.getFormattedDiscount() %></span>
            </div>
            <div class="summary-row">
                <span>Tax:</span>
                <span><%= invoice.getFormattedTax() %></span>
            </div>
            <div class="summary-row total">
                <span>Total:</span>
                <span><%= invoice.getFormattedTotalAmount() %></span>
            </div>
        </div>

        <div class="actions">
            <button class="btn btn-primary" onclick="window.print()">
                <i class="fas fa-print"></i> Print Invoice
            </button>
            <button class="btn btn-secondary" onclick="window.location.href='/billing-management'">
                <i class="fas fa-arrow-left"></i> Back to Billing
            </button>
            <form method="POST" action="/send-invoice-reminder" style="display: inline;">
                <input type="hidden" name="orderId" value="<%= invoice.getOrderId() %>">
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-bell"></i> Send Reminder
                </button>
            </form>
        </div>

        <%
            } else {
        %>
        <div style="text-align: center; padding: 40px;">
            <i class="fas fa-exclamation-triangle" style="font-size: 3rem; color: var(--warning); margin-bottom: 20px;"></i>
            <h2>Invoice Not Found</h2>
            <p>Unable to generate invoice. Please try again.</p>
            <a href="/billing-management" class="btn btn-primary" style="margin-top: 20px;">
                <i class="fas fa-arrow-left"></i> Back to Billing
            </a>
        </div>
        <%
            }
        %>

        <footer>
            <p>Thank you for choosing LaundryPro Lanka!</p>
            <p>Payment is due within 7 days of invoice date.</p>
            <p>For payment inquiries, contact: billing@laundrypro.lk</p>
        </footer>
    </div>
</body>
</html>