<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.laundry_management_system.backend.billing.model.Invoice" %>
<%@ page import="com.laundry_management_system.backend.billing.model.Order" %>
<%@ page import="com.laundry_management_system.backend.billing.service.InvoiceService" %>
<%@ page import="com.laundry_management_system.backend.billing.service.BillingService" %>
<%@ page import="com.laundry_management_system.backend.billing.service.ServiceException" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice Management - Laundry Management System</title>
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
            border-radius: 0 0 10px 10px;
            margin-bottom: 30px;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        .status-paid {
            color: var(--success);
            font-weight: 600;
        }

        .status-pending {
            color: var(--warning);
            font-weight: 600;
        }

        .status-overdue {
            color: var(--danger);
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--dark);
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 2px rgba(0, 84, 166, 0.2);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            width: 90%;
            max-width: 700px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .modal-header {
            padding: 20px;
            background: var(--primary);
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h3 {
            margin: 0;
        }

        .close {
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
        }

        .modal-body {
            padding: 20px;
            max-height: 70vh;
            overflow-y: auto;
        }

        .modal-footer {
            padding: 15px 20px;
            background: #f8f9fa;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
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

        footer {
            text-align: center;
            padding: 20px;
            margin-top: 30px;
            color: #7f8c8d;
            border-top: 1px solid #eee;
        }

        .currency {
            font-weight: 600;
            color: var(--dark);
        }

        .currency::before {
            content: "Rs. ";
        }

        .empty-state {
            text-align: center;
            padding: 40px 20px;
            color: #7f8c8d;
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 15px;
            color: #bdc3c7;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }

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
                <i class="fas fa-file-invoice-dollar"></i>
                <h1>Invoice Management - Laundry Management System</h1>
            </div>

<!-- Record Payment Modal -->
<div class="modal" id="payModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Record Payment</h3>
            <button class="close">&times;</button>
        </div>
        <div class="modal-body">
            <form id="payForm" method="POST" action="#">
                <input type="hidden" id="payOrderId" name="orderId" value="">
                <div class="form-group">
                    <label for="paymentMethod">Payment Method</label>
                    <select id="paymentMethod" name="paymentMethod" class="form-control" required>
                        <option value="">Select method</option>
                        <option value="CASH">Cash</option>
                        <option value="CARD">Card</option>
                        <option value="BANK_TRANSFER">Bank Transfer</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="cancelPayBtn">Cancel</button>
                    <button type="submit" class="btn btn-success">Record Payment</button>
                </div>
            </form>
        </div>
    </div>
    </div>
            <div>
                <span id="currentDate"></span>
            </div>
        </div>
    </div>
</header>

<div class="container">
    <div class="card">
        <div class="card-header">
            <h2><i class="fas fa-file-invoice"></i> Invoice Management</h2>
            <div>
                <button class="btn btn-primary" id="addInvoiceBtn">
                    <i class="fas fa-plus"></i> Generate New Invoice
                </button>
                <a href="/billing-management" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Billing
                </a>
            </div>
        </div>

        <%
            // Display success or error messages
            String message = (String) request.getAttribute("message");
            String messageType = (String) request.getAttribute("messageType");
            if (message != null && messageType != null) {
        %>
            <div class="alert alert-<%= messageType %>">
                <%= message %>
            </div>
        <%
            }
        %>

        <table id="invoicesTable">
            <thead>
                <tr>
                    <th>Invoice #</th>
                    <th>Order #</th>
                    <th>Customer</th>
                    <th>Date</th>
                    <th>Amount (LKR)</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        InvoiceService invoiceService = new InvoiceService();
                        BillingService billingService = new BillingService();
                        List<Order> orders = billingService.getAllOrders();

                        if (orders != null && !orders.isEmpty()) {
                            for (Order order : orders) {
                                // Generate invoice for each order
                                try {
                                    Invoice invoice = invoiceService.generateInvoice(order.getOrderId());
                                    String statusClass = "status-" + invoice.getStatus().toLowerCase();
                                %>
                                <tr>
                                    <td><%= invoice.getInvoiceNumber() %></td>
                                    <td><%= order.getOrderNumber() %></td>
                                    <td><%= invoice.getCustomer().getFullName() %></td>
                                    <td><%= invoice.getFormattedInvoiceDate() %></td>
                                    <td class="currency"><%= String.format("%.2f", invoice.getTotalAmount()) %></td>
                                    <td><span class="<%= statusClass %>"><%= invoice.getStatus() %></span></td>
                                    <td class="actions">
                                        <form method="GET" action="/generate-invoice" style="display: inline;">
                                            <input type="hidden" name="orderId" value="<%= invoice.getOrderId() %>">
                                            <button type="submit" class="btn btn-primary" title="View Invoice">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </form>
                                        <button class="btn btn-success pay-btn" data-order-id="<%= invoice.getOrderId() %>" title="Record Payment">
                                            <i class="fas fa-money-bill"></i>
                                        </button>
                                        <button class="btn btn-warning edit-btn" data-invoice-id="<%= invoice.getInvoiceId() %>" title="Edit Invoice">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-danger delete-btn" data-invoice-id="<%= invoice.getInvoiceId() %>" data-order-id="<%= invoice.getOrderId() %>" data-invoice-number="<%= invoice.getInvoiceNumber() %>" title="Delete Invoice">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                        <form method="POST" action="/send-invoice-reminder" style="display: inline;">
                                            <input type="hidden" name="orderId" value="<%= invoice.getOrderId() %>">
                                            <button type="submit" class="btn btn-success" title="Send Reminder">
                                                <i class="fas fa-bell"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                                <%
                                } catch (ServiceException e) {
                                    // Skip orders that can't generate invoices
                                }
                            }
                        } else {
                %>
                <tr>
                    <td colspan="7" class="empty-state">
                        <i class="fas fa-file-invoice"></i>
                        <h3>No Invoices Found</h3>
                        <p>Generate invoices from the billing management section</p>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                %>
                <tr>
                    <td colspan="7" class="empty-state">
                        <i class="fas fa-exclamation-triangle"></i>
                        <h3>Error Loading Invoices</h3>
                        <p><%= e.getMessage() %></p>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- Generate Invoice Modal -->
<div class="modal" id="generateInvoiceModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Generate Invoice</h3>
            <button class="close">&times;</button>
        </div>
        <div class="modal-body">
            <form id="generateInvoiceForm" method="POST" action="/generate-invoice">
                <div class="form-group">
                    <label for="orderId">Select Order</label>
                    <select id="orderId" name="orderId" class="form-control" required>
                        <option value="">Select an Order</option>
                        <%
                            try {
                                BillingService billingService = new BillingService();
                                List<Order> orders = billingService.getAllOrders();
                                if (orders != null) {
                                    for (Order order : orders) {
                        %>
                        <option value="<%= order.getOrderId() %>">Order #<%= order.getOrderNumber() %> - <%= order.getCustomerName() %></option>
                        <%
                                    }
                                }
                            } catch (Exception e) {
                        %>
                        <option value="">Error loading orders</option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="cancelGenerateBtn">Cancel</button>
                    <button type="submit" class="btn btn-primary">Generate Invoice</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Invoice Modal -->
<div class="modal" id="editInvoiceModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Edit Invoice</h3>
            <button class="close">&times;</button>
        </div>
        <div class="modal-body">
            <form id="editInvoiceForm" method="POST" action="/update-invoice">
                <input type="hidden" id="editInvoiceId" name="invoiceId" value="">
                <div class="form-group">
                    <label for="editStatus">Status</label>
                    <select id="editStatus" name="status" class="form-control" required>
                        <option value="PENDING">Pending</option>
                        <option value="PAID">Paid</option>
                        <option value="OVERDUE">Overdue</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="editNotes">Notes</label>
                    <textarea id="editNotes" name="notes" class="form-control" rows="3"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="cancelEditBtn">Cancel</button>
                    <button type="submit" class="btn btn-primary">Update Invoice</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal" id="deleteConfirmModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Confirm Delete</h3>
            <button class="close">&times;</button>
        </div>
        <div class="modal-body">
            <p>Are you sure you want to delete invoice <span id="deleteInvoiceNumber"></span>? This action cannot be undone.</p>
            <form id="deleteInvoiceForm" method="POST" action="#">
                <input type="hidden" id="deleteInvoiceId" name="invoiceId" value="">
                <input type="hidden" id="deleteOrderId" name="orderId" value="">
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="cancelDeleteBtn">Cancel</button>
                    <button type="submit" class="btn btn-danger">Delete Invoice</button>
                </div>
            </form>
        </div>
    </div>
</div>

<footer>
    <div class="container">
        <p>Laundry Management System - Sri Lanka &copy; 2023 | All Rights Reserved</p>
    </div>
</footer>

<script>
    // Set current date
    document.getElementById('currentDate').textContent = new Date().toLocaleDateString('en-US', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });

    // Modal functionality
    const generateInvoiceModal = document.getElementById('generateInvoiceModal');
    const editInvoiceModal = document.getElementById('editInvoiceModal');
    const deleteConfirmModal = document.getElementById('deleteConfirmModal');
    const payModal = document.getElementById('payModal');

    const addInvoiceBtn = document.getElementById('addInvoiceBtn');
    const closeBtns = document.querySelectorAll('.close');
    const cancelGenerateBtn = document.getElementById('cancelGenerateBtn');
    const cancelEditBtn = document.getElementById('cancelEditBtn');
    const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');

    function openModal(modal) {
        modal.style.display = 'flex';
    }

    function closeModal(modal) {
        modal.style.display = 'none';
    }

    addInvoiceBtn.addEventListener('click', () => {
        openModal(generateInvoiceModal);
    });

    closeBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            if (generateInvoiceModal.style.display === 'flex') closeModal(generateInvoiceModal);
            if (editInvoiceModal.style.display === 'flex') closeModal(editInvoiceModal);
            if (deleteConfirmModal.style.display === 'flex') closeModal(deleteConfirmModal);
            if (payModal.style.display === 'flex') closeModal(payModal);
        });
    });

    cancelGenerateBtn.addEventListener('click', () => closeModal(generateInvoiceModal));
    cancelEditBtn.addEventListener('click', () => closeModal(editInvoiceModal));
    cancelDeleteBtn.addEventListener('click', () => closeModal(deleteConfirmModal));
    const cancelPayBtn = document.getElementById('cancelPayBtn');
    cancelPayBtn.addEventListener('click', () => closeModal(payModal));

    // Close modal when clicking outside
    window.addEventListener('click', (e) => {
        if (e.target === generateInvoiceModal) closeModal(generateInvoiceModal);
        if (e.target === editInvoiceModal) closeModal(editInvoiceModal);
        if (e.target === deleteConfirmModal) closeModal(deleteConfirmModal);
        if (e.target === payModal) closeModal(payModal);
    });

    // Edit invoice function using data attributes
    document.querySelectorAll('.edit-btn').forEach(button => {
        button.addEventListener('click', function() {
            const invoiceId = this.getAttribute('data-invoice-id');
            document.getElementById('editInvoiceId').value = invoiceId;
            openModal(editInvoiceModal);
        });
    });

    // Delete invoice function using data attributes
    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function() {
            const invoiceId = this.getAttribute('data-invoice-id');
            const orderId = this.getAttribute('data-order-id');
            const invoiceNumber = this.getAttribute('data-invoice-number');
            document.getElementById('deleteInvoiceId').value = invoiceId || '';
            document.getElementById('deleteOrderId').value = orderId || '';
            document.getElementById('deleteInvoiceNumber').textContent = invoiceNumber;
            openModal(deleteConfirmModal);
        });
    });

    // Hook delete form to REST DELETE for order
    (function() {
        const delForm = document.getElementById('deleteInvoiceForm');
        if (!delForm) return;
        delForm.addEventListener('submit', async function(e) {
            e.preventDefault();
            const orderId = document.getElementById('deleteOrderId').value;
            if (!orderId) {
                alert('Missing order id to delete');
                return;
            }
            try {
                const res = await fetch('/billing/order/' + encodeURIComponent(orderId), { method: 'DELETE' });
                if (!res.ok) {
                    const txt = await res.text();
                    throw new Error(txt || 'Delete failed');
                }
                closeModal(deleteConfirmModal);
                alert('Invoice deleted (order removed) successfully');
                location.reload();
            } catch (err) {
                alert('Error deleting: ' + (err.message || err));
            }
        });
    })();

    // Open Record Payment modal
    document.querySelectorAll('.pay-btn').forEach(button => {
        button.addEventListener('click', function() {
            const orderId = this.getAttribute('data-order-id');
            document.getElementById('payOrderId').value = orderId || '';
            openModal(payModal);
        });
    });

    // Submit payment form to backend
    (function() {
        const payForm = document.getElementById('payForm');
        if (!payForm) return;
        payForm.addEventListener('submit', async function(e) {
            e.preventDefault();
            const orderId = document.getElementById('payOrderId').value;
            const method = document.getElementById('paymentMethod').value;
            if (!orderId || !method) {
                alert('Select a payment method.');
                return;
            }
            try {
                const params = new URLSearchParams();
                params.append('orderId', orderId);
                params.append('paymentMethod', method);
                const res = await fetch('/billing/process-payment', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: params.toString()
                });
                if (!res.ok) {
                    const txt = await res.text();
                    throw new Error(txt || 'Payment failed');
                }
                closeModal(payModal);
                alert('Payment recorded successfully');
                location.reload();
            } catch (err) {
                alert('Error: ' + (err.message || err));
            }
        });
    })();
</script>
</body>
</html>