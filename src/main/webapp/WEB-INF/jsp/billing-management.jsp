<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.laundry_management_system.backend.billing.util.BillingHelper" %>
<%@ page import="com.laundry_management_system.backend.billing.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laundry Billing Management - Sri Lanka</title>
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

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: var(--shadow);
            text-align: center;
            transition: transform 0.3s ease;
            border-left: 4px solid var(--primary);
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card i {
            font-size: 2rem;
            margin-bottom: 10px;
            color: var(--primary);
        }

        .stat-card h3 {
            font-size: 1.8rem;
            margin: 10px 0;
        }

        .stat-card p {
            color: #7f8c8d;
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

        .btn-info {
            background-color: #17a2b8;
            color: white;
        }

        .btn-info:hover {
            background-color: #138496;
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
            display: none;
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

        .delete-confirm-modal {
            max-width: 500px;
        }

        .delete-confirm-modal .modal-body {
            text-align: center;
            padding: 30px;
        }

        .delete-confirm-modal .modal-body i {
            font-size: 4rem;
            color: var(--danger);
            margin-bottom: 20px;
        }

        .delete-confirm-modal .modal-body h4 {
            margin-bottom: 10px;
            font-size: 1.5rem;
        }

        .delete-confirm-modal .modal-body p {
            margin-bottom: 20px;
            color: #7f8c8d;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }

            .header-content {
                flex-direction: column;
                gap: 15px;
            }

            .stats {
                grid-template-columns: 1fr;
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
                <h1>Laundry Billing Management - Sri Lanka</h1>
            </div>
            <div>
                <span id="currentDate"></span>
            </div>
        </div>
    </div>
</header>

<div class="container">
    <!-- Database Connection Status -->
    <div class="card">
        <div class="card-header">
            <h2>System Status</h2>
        </div>
        <div class="form-group">
            <label>Database Connection:</label>
            <% if (BillingHelper.testDatabaseConnection()) { %>
                <span style="color: green; font-weight: bold;">Connected</span>
            <% } else { %>
                <span style="color: red; font-weight: bold;">Disconnected</span>
            <% } %>
        </div>
        <div class="form-group">
            <label>Customer Count:</label>
            <span><%= BillingHelper.getCustomerCount() %> customers found</span>
        </div>
    </div>
    
    <div class="stats">
        <div class="stat-card">
            <i class="fas fa-money-bill-wave"></i>
            <h3 class="currency"><%= BillingHelper.getTotalRevenue() %></h3>
            <p>Total Revenue</p>
        </div>
        <div class="stat-card">
            <i class="fas fa-receipt"></i>
            <h3 id="invoiceCount"><%= BillingHelper.getOrderCount() %></h3>
            <p>Orders This Month</p>
        </div>
        <div class="stat-card">
            <i class="fas fa-hand-holding-usd"></i>
            <h3 class="currency"><%= BillingHelper.getPendingPayments() %></h3>
            <p>Pending Payments</p>
        </div>
        <div class="stat-card">
            <i class="fas fa-chart-line"></i>
            <h3>+<%= BillingHelper.getGrowthPercentage() %>%</h3>
            <p>Growth This Month</p>
        </div>
    </div>

    <div class="card">
        <div class="card-header">
            <h2>Order Management</h2>
            <div>
                <a href="/invoice-management" class="btn btn-info">
                    <i class="fas fa-file-invoice"></i> Invoice Management
                </a>
                <a href="overdue-payments.jsp" class="btn btn-warning">
                    <i class="fas fa-exclamation-circle"></i> Overdue Payments
                </a>
                <a href="financial-reports.jsp" class="btn btn-secondary">
                    <i class="fas fa-chart-bar"></i> Financial Reports
                </a>
                <button class="btn btn-primary" id="addOrderBtn">
                    <i class="fas fa-plus"></i> New Order
                </button>
            </div>
        </div>

        <table id="ordersTable" style="width: 100%;">
            <thead>
            <tr>
                <th>Order #</th>
                <th>Customer</th>
                <th>Date</th>
                <th>Amount (LKR)</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="ordersTableBody">
            <%= BillingHelper.renderOrders() %>
            </tbody>
        </table>
        <% if (BillingHelper.getOrders().isEmpty()) { %>
        <div id="ordersEmptyState" class="empty-state" style="display: block;">
        <% } else { %>
        <div id="ordersEmptyState" class="empty-state" style="display: none;">
        <% } %>
            <i class="fas fa-file-invoice"></i>
            <h3>No Orders Found</h3>
            <p>Create your first order to get started</p>
        </div>
    </div>

    <!-- Display success or error messages -->
    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success" id="successAlert">
        <%= request.getParameter("success") %>
    </div>
    <% } %>
    
    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger" id="errorAlert">
        <%= request.getParameter("error") %>
    </div>
    <% } %>
</div>

<!-- Add/Edit Order Modal -->
<div class="modal" id="orderModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 id="orderModalTitle">Create New Order</h3>
            <button class="close">&times;</button>
        </div>
        <div class="modal-body">
            <form id="orderForm" method="POST" action="/billing-management">
                <input type="hidden" name="action" id="action" value="create">
                <input type="hidden" name="orderId" id="orderId" value="">

                <div class="form-row">
                    <div class="form-group">
                        <label for="customerId">Customer</label>
                        <select id="customerId" name="customerId" class="form-control" required>
                            <option value="">Select Customer</option>
                            <%= BillingHelper.renderCustomerOptions() %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="orderDate">Order Date</label>
                        <input type="datetime-local" id="orderDate" name="orderDate" class="form-control" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="pickupDate">Pickup Date</label>
                        <input type="datetime-local" id="pickupDate" name="pickupDate" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="deliveryDate">Delivery Date</label>
                        <input type="datetime-local" id="deliveryDate" name="deliveryDate" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label for="items">Services</label>
                    <table id="itemsTable" style="width: 100%;">
                        <thead>
                        <tr>
                            <th>Service</th>
                            <th>Quantity</th>
                            <th>Price (LKR)</th>
                            <th>Total (LKR)</th>
                            <th>Action</th>
                        </tr>
                        </thead>
                        <tbody id="itemsTableBody">
                        <!-- Items will be dynamically added here -->
                        </tbody>
                    </table>
                    <button type="button" class="btn btn-primary" id="addItem" style="margin-top: 10px;">
                        <i class="fas fa-plus"></i> Add Service
                    </button>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="subtotal">Subtotal (LKR)</label>
                        <input type="text" id="subtotal" class="form-control currency" readonly value="0.00">
                    </div>
                    <div class="form-group">
                        <label for="discount">Discount (%)</label>
                        <input type="number" id="discount" name="discount" class="form-control" min="0" max="100" value="0">
                    </div>
                    <div class="form-group">
                        <label for="total">Total (LKR)</label>
                        <input type="text" id="total" name="total" class="form-control currency" readonly value="0.00">
                    </div>
                </div>
                <div class="form-group">
                    <label for="instructions">Instructions</label>
                    <textarea id="instructions" name="instructions" class="form-control" rows="3"></textarea>
                </div>
            </form>
        </div>
        <div class="modal-footer">
            <button class="btn btn-danger" id="cancelOrderBtn">Cancel</button>
            <button class="btn btn-success" id="saveOrderBtn">Save Order</button>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal" id="deleteConfirmModal">
    <div class="modal-content delete-confirm-modal">
        <div class="modal-body">
            <i class="fas fa-exclamation-triangle"></i>
            <h4>Confirm Delete</h4>
            <p id="deleteConfirmText">Are you sure you want to delete this order? This action cannot be undone.</p>
            <div style="display: flex; gap: 10px; justify-content: center; margin-top: 20px;">
                <form id="deleteForm" method="POST" action="/billing-management" style="display: inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="orderId" id="deleteOrderId" value="">
                    <button type="submit" class="btn btn-danger">Yes, Delete</button>
                </form>
                <button class="btn btn-primary" id="cancelDeleteBtn">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Refund Modal -->
<div class="modal" id="refundModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Process Refund</h3>
            <button class="close">&times;</button>
        </div>
        <div class="modal-body">
            <form id="refundForm" method="POST" action="/process-refund">
                <input type="hidden" name="orderId" id="refundOrderId" value="">
                <div class="form-group">
                    <label for="refundAmount">Refund Amount (LKR)</label>
                    <input type="number" id="refundAmount" name="refundAmount" class="form-control" step="0.01" min="0" required>
                </div>
                <div class="form-group">
                    <label for="refundReason">Reason for Refund</label>
                    <textarea id="refundReason" name="reason" class="form-control" rows="3" required></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="cancelRefundBtn">Cancel</button>
                    <button type="submit" class="btn btn-danger">Process Refund</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Discount Modal -->
<div class="modal" id="discountModal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Apply Discount</h3>
            <button class="close">&times;</button>
        </div>
        <div class="modal-body">
            <form id="discountForm" method="POST" action="/apply-discount">
                <input type="hidden" name="orderId" id="discountOrderId" value="">
                <div class="form-group">
                    <label for="discountPercentage">Discount Percentage (%)</label>
                    <input type="number" id="discountPercentage" name="discount" class="form-control" min="0" max="100" step="0.01" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="cancelDiscountBtn">Cancel</button>
                    <button type="submit" class="btn btn-warning">Apply Discount</button>
                </div>
            </form>
        </div>
    </div>
</div>

<footer>
    <div class="container">
        <p>Laundry Billing Management System - Sri Lanka &copy; 2023 | All Rights Reserved</p>
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

    // Set default dates for order
    const today = new Date();
    const pickupDate = new Date();
    pickupDate.setDate(today.getDate() + 1);
    const deliveryDate = new Date();
    deliveryDate.setDate(today.getDate() + 2);

    document.getElementById('orderDate').value = formatDateTimeLocal(today);
    document.getElementById('pickupDate').value = formatDateTimeLocal(pickupDate);
    document.getElementById('deliveryDate').value = formatDateTimeLocal(deliveryDate);

    function formatDateTimeLocal(date) {
        return date.toISOString().slice(0, 16);
    }

    // Modal functionality
    const orderModal = document.getElementById('orderModal');
    const deleteConfirmModal = document.getElementById('deleteConfirmModal');
    const refundModal = document.getElementById('refundModal');
    const discountModal = document.getElementById('discountModal');

    const addOrderBtn = document.getElementById('addOrderBtn');
    const addItemBtn = document.getElementById('addItem');

    const closeBtns = document.querySelectorAll('.close');
    const cancelOrderBtn = document.getElementById('cancelOrderBtn');
    const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');
    const cancelRefundBtn = document.getElementById('cancelRefundBtn');
    const cancelDiscountBtn = document.getElementById('cancelDiscountBtn');
    const saveOrderBtn = document.getElementById('saveOrderBtn');

    function openModal(modal) {
        modal.style.display = 'flex';
    }

    function closeModal(modal) {
        modal.style.display = 'none';
    }

    addOrderBtn.addEventListener('click', () => {
        document.getElementById('orderModalTitle').textContent = 'Create New Order';
        document.getElementById('action').value = 'create';
        document.getElementById('orderId').value = '';
        document.getElementById('customerId').value = '';
        document.getElementById('instructions').value = '';
        document.getElementById('discount').value = '0';
        initializeOrderForm();
        openModal(orderModal);
    });

    addItemBtn.addEventListener('click', addItemRow);

    // Add event listener to customer select to ensure it works
    document.getElementById('customerId').addEventListener('change', function() {
        // This is just to ensure the change event is captured
        console.log('Customer selected: ' + this.value);
    });

    closeBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            if (orderModal.style.display === 'flex') closeModal(orderModal);
            if (deleteConfirmModal.style.display === 'flex') closeModal(deleteConfirmModal);
            if (refundModal.style.display === 'flex') closeModal(refundModal);
            if (discountModal.style.display === 'flex') closeModal(discountModal);
        });
    });

    cancelOrderBtn.addEventListener('click', () => closeModal(orderModal));
    cancelDeleteBtn.addEventListener('click', () => closeModal(deleteConfirmModal));
    cancelRefundBtn.addEventListener('click', () => closeModal(refundModal));
    cancelDiscountBtn.addEventListener('click', () => closeModal(discountModal));
    saveOrderBtn.addEventListener('click', () => {
        document.getElementById('orderForm').submit();
    });

    // Close modal when clicking outside
    window.addEventListener('click', (e) => {
        if (e.target === orderModal) closeModal(orderModal);
        if (e.target === deleteConfirmModal) closeModal(deleteConfirmModal);
        if (e.target === refundModal) closeModal(refundModal);
        if (e.target === discountModal) closeModal(discountModal);
    });

    // Add event listener to discount input
    document.getElementById('discount').addEventListener('input', updateOrderTotals);

    // Initialize order form
    function initializeOrderForm() {
        const tbody = document.getElementById('itemsTableBody');
        tbody.innerHTML = '';
        addItemRow();
        updateOrderTotals();
    }

    // Add item row to order form
    function addItemRow() {
        const tbody = document.getElementById('itemsTableBody');
        const rowCount = tbody.children.length;
        const newRow = document.createElement('tr');

        newRow.innerHTML = `
                <td>
                    <select class="form-control service-item" required>
                        <option value="">Select Service</option>
                        <%= BillingHelper.renderServiceOptions() %>
                    </select>
                </td>
                <td>
                    <input type="number" class="form-control item-quantity" min="1" value="1" required>
                </td>
                <td>
                    <input type="number" class="form-control item-price" step="0.01" min="0" readonly>
                </td>
                <td class="item-total currency">0.00</td>
                <td>
                    <button type="button" class="btn btn-danger remove-item">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            `;

        tbody.appendChild(newRow);

        // Add event listeners to the new row
        const serviceSelect = newRow.querySelector('.service-item');
        const quantityInput = newRow.querySelector('.item-quantity');
        const priceInput = newRow.querySelector('.item-price');
        const removeBtn = newRow.querySelector('.remove-item');

        // Update price when service is selected
        serviceSelect.addEventListener('change', function() {
            const selectedOption = serviceSelect.options[serviceSelect.selectedIndex];
            const price = selectedOption.getAttribute('data-price') || 0;
            priceInput.value = parseFloat(price).toFixed(2);
            updateItemTotal(newRow);
        });

        // Update total when quantity changes
        quantityInput.addEventListener('input', function() {
            updateItemTotal(newRow);
        });

        // Remove item
        removeBtn.addEventListener('click', function() {
            newRow.remove();
            updateOrderTotals();
        });
        
        // Trigger change event to set initial price if service is already selected
        if (serviceSelect.value) {
            const event = new Event('change');
            serviceSelect.dispatchEvent(event);
        }
    }

    // Update item total
    function updateItemTotal(row) {
        const quantity = parseFloat(row.querySelector('.item-quantity').value) || 0;
        const price = parseFloat(row.querySelector('.item-price').value) || 0;
        const total = quantity * price;
        row.querySelector('.item-total').textContent = total.toFixed(2);
        updateOrderTotals();
    }

    // Update order totals
    function updateOrderTotals() {
        let subtotal = 0;
        document.querySelectorAll('.item-total').forEach(cell => {
            const total = parseFloat(cell.textContent) || 0;
            subtotal += total;
        });

        const discountRate = parseFloat(document.getElementById('discount').value) || 0;
        const discountAmount = subtotal * (discountRate / 100);
        const total = subtotal - discountAmount;

        document.getElementById('subtotal').value = subtotal.toFixed(2);
        document.getElementById('total').value = total.toFixed(2);

        // Update hidden form fields
        updateOrderFormItems();
    }

    // Update hidden form fields with order items
    function updateOrderFormItems() {
        const items = [];
        document.querySelectorAll('#itemsTableBody tr').forEach((row, index) => {
            const serviceId = row.querySelector('.service-item').value;
            const quantity = row.querySelector('.item-quantity').value;
            const price = row.querySelector('.item-price').value;

            if (serviceId && quantity && price) {
                items.push({
                    serviceId: serviceId,
                    quantity: quantity,
                    price: price
                });
            }
        });

        // Remove existing orderItems input if it exists
        const existingInput = document.querySelector('input[name="orderItems"]');
        if (existingInput) {
            existingInput.remove();
        }

        // Add new orderItems input
        const orderForm = document.getElementById('orderForm');
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'orderItems';
        input.value = JSON.stringify(items);
        orderForm.appendChild(input);
    }

    // Delete order confirmation
    function confirmDelete(orderId, orderNumber) {
        document.getElementById('deleteOrderId').value = orderId;
        document.getElementById('deleteConfirmText').textContent =
            'Are you sure you want to delete order ' + orderNumber + '? This action cannot be undone.';
        openModal(deleteConfirmModal);
    }
    
    // Process payment
    function processPayment(orderId) {
        const paymentMethod = prompt('Enter payment method (CASH, CARD, BANK_TRANSFER):', 'CASH');
        if (paymentMethod) {
            const transactionId = prompt('Enter transaction ID (optional):', '');
            
            // In a real implementation, you would make an AJAX call to the server
            // For now, we'll just show a message
            alert('Payment processed for order ' + orderId + ' with method ' + paymentMethod + 
                  (transactionId ? ' and transaction ID ' + transactionId : ''));
            
            // Refresh the page to show updated status
            location.reload();
        }
    }
    
    // Apply discount
    function applyDiscount(orderId) {
        document.getElementById('discountOrderId').value = orderId;
        document.getElementById('discountPercentage').value = '';
        openModal(discountModal);
    }
    
    // Process refund
    function processRefund(orderId) {
        document.getElementById('refundOrderId').value = orderId;
        document.getElementById('refundAmount').value = '';
        document.getElementById('refundReason').value = '';
        openModal(refundModal);
    }
    
    // View invoice
    function viewInvoice(orderId) {
        window.location.href = '/generate-invoice?orderId=' + orderId;
    }

    // Show success/error messages from server
    document.addEventListener('DOMContentLoaded', function() {
        // Check for success parameter
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('success')) {
            document.getElementById('successAlert').textContent = urlParams.get('success');
            document.getElementById('successAlert').style.display = 'block';
            setTimeout(() => {
                document.getElementById('successAlert').style.display = 'none';
            }, 3000);
        }
        
        // Check for error parameter
        if (urlParams.has('error')) {
            document.getElementById('errorAlert').textContent = urlParams.get('error');
            document.getElementById('errorAlert').style.display = 'block';
            setTimeout(() => {
                document.getElementById('errorAlert').style.display = 'none';
            }, 3000);
        }
    });
</script>
</body>
</html>