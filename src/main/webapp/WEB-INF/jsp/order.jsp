<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laundry Management - Orders</title>
    <style>
        /* [CSS remains unchanged from the previous response for brevity] */
        :root {
            --background: #ffffff;
            --foreground: #475569;
            --card: #fdf2f8;
            --card-foreground: #475569;
            --primary: #be123c;
            --primary-foreground: #ffffff;
            --secondary: #fdf2f8;
            --secondary-foreground: #475569;
            --muted: #f3f4f6;
            --muted-foreground: #6b7280;
            --accent: #ec4899;
            --accent-foreground: #ffffff;
            --destructive: #ef4444;
            --destructive-foreground: #ffffff;
            --border: #e5e7eb;
            --input: #ffffff;
            --ring: rgba(190, 18, 60, 0.5);
            --radius: 0.5rem;
            --shadow: 0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: var(--background); color: var(--foreground); line-height: 1.6; min-height: 100vh; }
        .header { background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%); color: var(--primary-foreground); padding: 2rem 0; box-shadow: var(--shadow-lg); }
        .header-content { max-width: 1200px; margin: 0 auto; padding: 0 2rem; display: flex; align-items: center; justify-content: space-between; }
        .header h1 { font-size: 2rem; font-weight: 700; display: flex; align-items: center; gap: 0.75rem; }
        .header-icon { width: 2.5rem; height: 2.5rem; background: rgba(255, 255, 255, 0.2); border-radius: var(--radius); display: flex; align-items: center; justify-content: center; }
        .breadcrumb { display: flex; align-items: center; gap: 0.5rem; font-size: 0.875rem; opacity: 0.9; }
        .container { max-width: 1200px; margin: 0 auto; padding: 2rem; }
        .alert { background: var(--card); border: 1px solid var(--border); border-radius: var(--radius); padding: 1rem; margin-bottom: 2rem; box-shadow: var(--shadow); display: flex; align-items: center; gap: 0.75rem; }
        .alert.success { background: #f0fdf4; border-color: #22c55e; color: #166534; }
        .alert-icon { width: 1.25rem; height: 1.25rem; flex-shrink: 0; }
        .form-card { background: var(--card); border: 1px solid var(--border); border-radius: var(--radius); padding: 2rem; margin-bottom: 2rem; box-shadow: var(--shadow); }
        .form-card h2 { font-size: 1.5rem; font-weight: 600; margin-bottom: 1.5rem; color: var(--primary); display: flex; align-items: center; gap: 0.5rem; }
        .form-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem; margin-bottom: 2rem; }
        .form-group { display: flex; flex-direction: column; gap: 0.5rem; }
        .form-group label { font-weight: 500; color: var(--foreground); font-size: 0.875rem; }
        .form-control { padding: 0.75rem; border: 1px solid var(--border); border-radius: var(--radius); background: var(--input); color: var(--foreground); font-size: 0.875rem; transition: all 0.2s ease; }
        .form-control:focus { outline: none; border-color: var(--primary); box-shadow: 0 0 0 3px var(--ring); }
        .form-control.wide { grid-column: span 2; }
        .btn { padding: 0.75rem 1.5rem; border: none; border-radius: var(--radius); font-weight: 500; font-size: 0.875rem; cursor: pointer; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 0.5rem; text-decoration: none; }
        .btn-primary { background: var(--primary); color: var(--primary-foreground); }
        .btn-primary:hover { background: #9f1239; transform: translateY(-1px); box-shadow: var(--shadow-lg); }
        .btn-secondary { background: var(--secondary); color: var(--secondary-foreground); border: 1px solid var(--border); }
        .btn-secondary:hover { background: var(--muted); }
        .btn-danger { background: var(--destructive); color: var(--destructive-foreground); }
        .btn-danger:hover { background: #dc2626; }
        .btn-sm { padding: 0.5rem 1rem; font-size: 0.75rem; }
        .table-card { background: var(--card); border: 1px solid var(--border); border-radius: var(--radius); overflow: hidden; box-shadow: var(--shadow); }
        .table-header { padding: 1.5rem 2rem; border-bottom: 1px solid var(--border); display: flex; align-items: center; justify-content: space-between; }
        .table-header h2 { font-size: 1.25rem; font-weight: 600; color: var(--primary); }
        .table-container { overflow-x: auto; }
        .table { width: 100%; border-collapse: collapse; }
        .table th { background: var(--muted); padding: 1rem; text-align: left; font-weight: 600; font-size: 0.875rem; color: var(--foreground); border-bottom: 1px solid var(--border); }
        .table td { padding: 1rem; border-bottom: 1px solid var(--border); font-size: 0.875rem; }
        .table tbody tr:hover { background: var(--secondary); }
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 9999px; font-size: 0.75rem; font-weight: 500; text-transform: uppercase; letter-spacing: 0.025em; }
        .status-received { background: #dbeafe; color: #1e40af; }
        .status-in_process { background: #fef3c7; color: #d97706; }
        .status-ready { background: #d1fae5; color: #059669; }
        .status-delivered { background: #dcfce7; color: #16a34a; }
        .status-cancelled { background: #fee2e2; color: #dc2626; }
        .action-buttons { display: flex; gap: 0.5rem; align-items: center; }
        .action-link { color: var(--primary); text-decoration: none; font-size: 0.875rem; font-weight: 500; padding: 0.25rem 0.5rem; border-radius: calc(var(--radius) / 2); transition: all 0.2s ease; }
        .action-link:hover { background: var(--secondary); }
        .footer { margin-top: 3rem; padding: 2rem 0; border-top: 1px solid var(--border); text-align: center; }
        @media (max-width: 768px) {
            .header-content { flex-direction: column; gap: 1rem; text-align: center; }
            .container { padding: 1rem; }
            .form-grid { grid-template-columns: 1fr; }
            .form-control.wide { grid-column: span 1; }
            .table-header { flex-direction: column; gap: 1rem; align-items: flex-start; }
            .action-buttons { flex-direction: column; align-items: flex-start; }
        }
        .loading { display: inline-block; width: 1rem; height: 1rem; border: 2px solid var(--border); border-radius: 50%; border-top-color: var(--primary); animation: spin 1s ease-in-out infinite; }
        @keyframes spin { to { transform: rotate(360deg); } }
        .fade-in { animation: fadeIn 0.5s ease-in; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>
<!-- Header -->
<header class="header">
    <div class="header-content">
        <h1>
            <div class="header-icon">🧺</div>
            Laundry Management System
        </h1>
        <nav class="breadcrumb">
            <a href="/home" style="color: inherit; text-decoration: none;">Home</a>
            <span>›</span>
            <span>Orders</span>
        </nav>
    </div>
</header>

<!-- Main Container -->
<main class="container">
    <!-- Success/Error Messages -->
    <c:if test="${not empty msg}">
        <div class="alert success fade-in">
            <svg class="alert-icon" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
            </svg>
                ${msg}
        </div>
    </c:if>

    <!-- Create Order Form -->
    <div class="form-card fade-in">
        <h2>
            <svg width="20" height="20" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd"/>
            </svg>
            Create New Order
        </h2>
        <form action="/orders" method="post" id="orderForm">
            <div class="form-grid">
                <div class="form-group">
                    <label for="customerId">Customer ID *</label>
                    <input type="number" id="customerId" name="customerId" class="form-control" required min="1" placeholder="Enter customer ID">
                </div>
                <div class="form-group">
                    <label for="status">Status *</label>
                    <select id="status" name="status" class="form-control" required>
                        <option value="">Select status</option>
                        <option value="RECEIVED">Received</option>
                        <option value="IN_PROCESS">In Process</option>
                        <option value="READY">Ready</option>
                        <option value="DELIVERED">Delivered</option>
                        <option value="CANCELLED">Cancelled</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="orderDate">Order Date</label>
                    <input type="datetime-local" id="orderDate" name="orderDate" class="form-control">
                </div>
                <div class="form-group">
                    <label for="pickupDate">Pickup Date</label>
                    <input type="datetime-local" id="pickupDate" name="pickupDate" class="form-control">
                </div>
                <div class="form-group">
                    <label for="deliveryDate">Delivery Date</label>
                    <input type="datetime-local" id="deliveryDate" name="deliveryDate" class="form-control">
                </div>
                <div class="form-group wide">
                    <label for="instructions">Special Instructions</label>
                    <input type="text" id="instructions" name="instructions" class="form-control" placeholder="Any special handling instructions...">
                </div>
            </div>
            <button type="submit" class="btn btn-primary" id="submitBtn">
                <svg width="16" height="16" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd"/>
                </svg>
                Create Order
            </button>
        </form>
    </div>

    <!-- Orders Table -->
    <div class="table-card fade-in">
        <div class="table-header">
            <h2>
                <svg width="20" height="20" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                    <path fill-rule="evenodd" d="M4 5a2 2 0 012-2v1a1 1 0 001 1h6a1 1 0 001-1V3a2 2 0 012 2v6a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/>
                </svg>
                Order Management
            </h2>
            <div class="action-buttons">
                <button class="btn btn-secondary btn-sm" onclick="refreshTable()">
                    <svg width="14" height="14" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M4 2a1 1 0 011 1v2.101a7.002 7.002 0 0111.601 2.566 1 1 0 11-1.885.666A5.002 5.002 0 005.999 7H9a1 1 0 010 2H4a1 1 0 01-1-1V3a1 1 0 011-1zm.008 9.057a1 1 0 011.276.61A5.002 5.002 0 0014.001 13H11a1 1 0 110-2h5a1 1 0 011 1v5a1 1 0 11-2 0v-2.101a7.002 7.002 0 01-11.601-2.566 1 1 0 01.61-1.276z" clip-rule="evenodd"/>
                    </svg>
                    Refresh
                </button>
            </div>
        </div>
        <div class="table-container">
            <table class="table">
                <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Status</th>
                    <th>Order Date</th>
                    <th>Pickup Date</th>
                    <th>Delivery Date</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="o" items="${orders}">
                    <tr class="fade-in">
                        <td><strong>#${o.orderId}</strong></td>
                        <td>Customer ${o.customerId}</td>
                        <td>
                                    <span class="status-badge status-${o.status.name().toLowerCase()}">
                                            ${o.status.name().replace('_', ' ')}
                                    </span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty o.orderDate}">
                                    ${o.orderDate}
                                </c:when>
                                <c:otherwise>
                                    <span style="color: var(--muted-foreground);">Not set</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty o.pickupDate}">
                                    ${o.pickupDate}
                                </c:when>
                                <c:otherwise>
                                    <span style="color: var(--muted-foreground);">Not scheduled</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty o.deliveryDate}">
                                    ${o.deliveryDate}
                                </c:when>
                                <c:otherwise>
                                    <span style="color: var(--muted-foreground);">Not scheduled</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <a href="/orders/${o.orderId}" class="action-link">View</a>
                                <a href="/orders/${o.orderId}/edit" class="action-link">Edit</a>
                                <form action="/orders/${o.orderId}/delete" method="post" style="display:inline"
                                      onsubmit="return confirmDelete('${o.orderId}');">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orders}">
                    <tr>
                        <td colspan="7" style="text-align: center; padding: 3rem; color: var(--muted-foreground);">
                            <svg width="48" height="48" fill="currentColor" viewBox="0 0 20 20" style="margin-bottom: 1rem; opacity: 0.5;">
                                <path fill-rule="evenodd" d="M5 4a3 3 0 00-3 3v6a3 3 0 003 3h10a3 3 0 003-3V7a3 3 0 00-3-3H5zm-1 9v-1h5v2H5a1 1 0 01-1-1zm7 1h4a1 1 0 001-1v-1h-5v2zm0-4h5V8h-5v2zM9 8H4v2h5V8z" clip-rule="evenodd"/>
                            </svg>
                            <div>No orders found. Create your first order above!</div>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p style="color: var(--muted-foreground);">
            <a href="/home" class="action-link">← Back to Home</a>
        </p>
    </footer>
</main>

<script>
    // Form validation and enhancement
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('orderForm');
        const submitBtn = document.getElementById('submitBtn');

        // Set default order date to now
        const orderDateInput = document.getElementById('orderDate');
        if (orderDateInput && !orderDateInput.value) {
            const now = new Date();
            now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
            orderDateInput.value = now.toISOString().slice(0, 16);
        }

        // Form submission with loading state
        form.addEventListener('submit', function(e) {
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<div class="loading"></div> Creating Order...';

            // Re-enable button after 3 seconds as fallback
            setTimeout(() => {
                submitBtn.disabled = false;
                submitBtn.innerHTML = `
                        <svg width="16" height="16" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd"/>
                        </svg>
                        Create Order
                    `;
            }, 3000);
        });

        // Auto-hide success messages
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            setTimeout(() => {
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-10px)';
                setTimeout(() => alert.remove(), 300);
            }, 5000);
        });
    });

    // Delete confirmation
    function confirmDelete(orderId) {
        return confirm(`Are you sure you want to delete order #${orderId}? This action cannot be undone.`);
    }

    // Refresh table function
    function refreshTable() {
        window.location.reload();
    }

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl/Cmd + N for new order
        if ((e.ctrlKey || e.metaKey) && e.key === 'n') {
            e.preventDefault();
            document.getElementById('customerId').focus();
        }

        // Escape to clear form
        if (e.key === 'Escape') {
            const form = document.getElementById('orderForm');
            if (confirm('Clear the form?')) {
                form.reset();
                // Reset order date to current time
                const now = new Date();
                now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
                document.getElementById('orderDate').value = now.toISOString().slice(0, 16);
            }
        }
    });
</script>
</body>
</html>