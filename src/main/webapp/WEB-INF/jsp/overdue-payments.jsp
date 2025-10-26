<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.laundry_management_system.backend.billing.model.Order" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Overdue Payments - Laundry Management</title>
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
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background: linear-gradient(135deg, var(--primary), var(--dark));
            color: white;
            padding: 20px 0;
            box-shadow: var(--shadow);
            margin-bottom: 30px;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo i {
            font-size: 2.5rem;
        }

        .logo h1 {
            font-size: 1.8rem;
            font-weight: 600;
        }

        .nav-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 10px 20px;
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

        .btn-success {
            background-color: var(--success);
            color: white;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .btn-warning {
            background-color: var(--warning);
            color: white;
        }

        .btn-warning:hover {
            background-color: #e0a800;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .card {
            background: white;
            border-radius: 10px;
            box-shadow: var(--shadow);
            padding: 25px;
            margin-bottom: 30px;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .card-header h2 {
            color: var(--dark);
        }

        .alert {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #f8f9fa;
            color: var(--dark);
            font-weight: 600;
        }

        tr:hover {
            background-color: #f8f9fa;
        }

        .actions {
            display: flex;
            gap: 10px;
        }

        .actions .btn {
            padding: 5px 10px;
            font-size: 0.85rem;
        }

        .status-overdue {
            color: var(--danger);
            font-weight: 600;
        }

        .status-pending {
            color: var(--warning);
            font-weight: 600;
        }

        .status-paid {
            color: var(--success);
            font-weight: 600;
        }

        .currency {
            font-family: 'Courier New', monospace;
            font-weight: 600;
        }

        footer {
            background: var(--dark);
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 30px;
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 15px;
            }

            .actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="container">
        <div class="header-content">
            <div class="logo">
                <i class="fas fa-exclamation-circle"></i>
                <h1>Overdue Payments - Laundry Management</h1>
            </div>
            <div class="nav-buttons">
                <a href="billing-management" class="btn btn-primary">
                    <i class="fas fa-arrow-left"></i> Back to Billing
                </a>
            </div>
        </div>
    </div>
</header>

<div class="container">
    <div class="card">
        <div class="card-header">
            <h2><i class="fas fa-clock"></i> Overdue Payments</h2>
        </div>
        
        <%
            String message = "";
            String messageType = "";
            
            // Check for success or error messages
            if (request.getParameter("success") != null) {
                message = request.getParameter("success");
                messageType = "success";
            } else if (request.getParameter("error") != null) {
                message = request.getParameter("error");
                messageType = "danger";
            }
            
            if (!message.isEmpty()) {
        %>
            <div class="alert alert-<%= messageType %>">
                <%= message %>
            </div>
        <%
            }
        %>
        
        <%
            List<Order> overdueOrders = (List<Order>) request.getAttribute("overdueOrders");
            if (overdueOrders != null) {
                if (overdueOrders.isEmpty()) {
        %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> No overdue payments found.
            </div>
        <%
                } else {
        %>
            <table>
                <thead>
                    <tr>
                        <th>Order #</th>
                        <th>Customer</th>
                        <th>Date</th>
                        <th>Amount (LKR)</th>
                        <th>Status</th>
                        <th>Days Overdue</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Order order : overdueOrders) {
                            String statusClass = "status-" + order.getStatus().toLowerCase().replace("_", "-");
                            String statusText = order.getStatus().replace("_", " ");
                            
                            // Calculate days overdue (simplified)
                            long daysOverdue = 7; // Default to 7 days for demo
                    %>
                    <tr>
                        <td><%= order.getOrderNumber() %></td>
                        <td><%= order.getCustomerName() %></td>
                        <td><%= order.getOrderDate() %></td>
                        <td class="currency"><%= String.format("%.2f", order.getTotalAmount()) %></td>
                        <td><span class="<%= statusClass %>"><%= statusText %></span></td>
                        <td><%= daysOverdue %> days</td>
                        <td class="actions">
                            <form method="POST" action="/send-overdue-reminder" style="display: inline;">
                                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                <button type="submit" class="btn btn-warning">
                                    <i class="fas fa-bell"></i> Send Reminder
                                </button>
                            </form>
                            <form method="POST" action="/mark-overdue-paid" style="display: inline;">
                                <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                <button type="submit" class="btn btn-success">
                                    <i class="fas fa-check"></i> Mark Paid
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <%
                }
            } else {
        %>
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-triangle"></i> Error loading overdue payments.
            </div>
        <%
            }
        %>
    </div>
</div>

<footer>
    <div class="container">
        <p>Laundry Overdue Payments - Sri Lanka &copy; 2023 | All Rights Reserved</p>
    </div>
</footer>

</body>
</html>