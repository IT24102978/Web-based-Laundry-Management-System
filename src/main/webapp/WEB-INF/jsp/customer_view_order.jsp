<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en" class="">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - Customer View</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        :root {
            --background: 255 255 255;
            --foreground: 15 23 42;
            --card: 248 250 252;
            --card-foreground: 30 41 59;
            --primary: 37 99 235;
            --primary-foreground: 255 255 255;
            --secondary: 226 232 240;
            --secondary-foreground: 71 85 105;
            --muted: 241 245 249;
            --muted-foreground: 100 116 139;
            --accent: 59 130 246;
            --accent-foreground: 255 255 255;
            --destructive: 239 68 68;
            --destructive-foreground: 255 255 255;
            --border: 226 232 240;
            --input: 255 255 255;
            --ring: rgba(37, 99, 235, .3);
            --radius: 0.75rem;
            --shadow: 0 1px 3px 0 rgb(0 0 0 / .1), 0 1px 2px -1px rgb(0 0 0 / .1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / .1), 0 4px 6px -4px rgb(0 0 0 / .1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / .1), 0 8px 10px -6px rgb(0 0 0 / .1);
        }

        .dark {
            --background: 23 23 28;
            --foreground: 245 247 250;
            --card: 33 37 41;
            --card-foreground: 245 247 250;
            --primary: 245 247 250;
            --primary-foreground: 33 37 41;
            --secondary: 46 52 64;
            --secondary-foreground: 245 247 250;
            --muted: 46 52 64;
            --muted-foreground: 173 181 189;
            --accent: 46 52 64;
            --border: 46 52 64;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: system-ui, -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background: linear-gradient(135deg, rgb(var(--muted)) 0%, rgb(var(--secondary)) 100%);
            color: rgb(var(--foreground));
            line-height: 1.6;
            min-height: 100vh;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 2rem;
        }

        .header {
            background: rgb(var(--background));
            border: 1px solid rgb(var(--border));
            border-radius: var(--radius);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-lg);
            text-align: center;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: rgb(var(--primary));
            margin-bottom: 0.5rem;
        }

        .order-number {
            font-size: 1.25rem;
            color: rgb(var(--muted-foreground));
            font-weight: 600;
        }

        .content-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .info-card {
            background: rgb(var(--card));
            border: 1px solid rgb(var(--border));
            border-radius: var(--radius);
            padding: 2rem;
            box-shadow: var(--shadow-lg);
        }

        .info-card h3 {
            font-size: 1.5rem;
            font-weight: 600;
            color: rgb(var(--primary));
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid rgb(var(--border));
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: rgb(var(--muted-foreground));
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        .info-value {
            font-weight: 500;
            color: rgb(var(--foreground));
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            box-shadow: var(--shadow);
        }

        .status-received {
            background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
            color: #1e40af;
        }

        .status-in_process {
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            color: #d97706;
        }

        .status-ready {
            background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
            color: #059669;
        }

        .status-delivered {
            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
            color: #16a34a;
        }

        .status-cancelled {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: #dc2626;
        }

        .items-section {
            background: rgb(var(--card));
            border: 1px solid rgb(var(--border));
            border-radius: var(--radius);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-lg);
        }

        .items-header {
            margin-bottom: 1.5rem;
        }

        .items-header h3 {
            font-size: 1.5rem;
            font-weight: 600;
            color: rgb(var(--primary));
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
        }

        .items-table th {
            background: rgb(var(--muted));
            padding: 1rem;
            text-align: left;
            font-weight: 700;
            font-size: 0.875rem;
            color: rgb(var(--foreground));
            border-bottom: 2px solid rgb(var(--border));
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        .items-table td {
            padding: 1rem;
            border-bottom: 1px solid rgb(var(--border));
            font-size: 0.875rem;
        }

        .items-table tbody tr:hover {
            background: rgb(var(--secondary));
        }

        .price-cell {
            font-weight: 600;
            color: rgb(var(--primary));
        }

        .actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: var(--radius);
            font-weight: 600;
            font-size: 0.875rem;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 0.025em;
            box-shadow: var(--shadow-lg);
        }

        .btn-primary {
            background: linear-gradient(135deg, rgb(var(--primary)) 0%, rgb(var(--accent)) 100%);
            color: rgb(var(--primary-foreground));
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-xl);
            filter: brightness(1.1);
        }

        .btn-secondary {
            background: linear-gradient(135deg, rgb(var(--muted)) 0%, rgb(var(--secondary)) 100%);
            color: rgb(var(--secondary-foreground));
            border: 2px solid rgb(var(--border));
        }

        .btn-secondary:hover {
            background: rgb(var(--muted));
            transform: translateY(-2px);
        }

        .fade-in {
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .instructions-card {
            grid-column: 1 / -1;
            background: rgb(var(--card));
            padding: 2rem;
            border-radius: var(--radius);
            box-shadow: var(--shadow-lg);
            border: 1px solid rgb(var(--border));
            margin-top: 1rem;
        }

        .instructions-card h3 {
            color: rgb(var(--primary));
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .instructions-text {
            background: rgb(var(--muted));
            padding: 1.5rem;
            border-radius: 8px;
            border-left: 4px solid rgb(var(--primary));
            font-style: italic;
            color: rgb(var(--muted-foreground));
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            .content-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
            .header h1 {
                font-size: 2rem;
            }
            .actions {
                flex-direction: column;
                align-items: center;
            }
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header fade-in">
        <h1>Order Details</h1>
        <div class="order-number">Order #${order.orderId}</div>
    </div>

    <div class="content-grid fade-in">
        <div class="info-card">
            <h3>
                <svg width="24" height="24" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"/>
                </svg>
                Order Information
            </h3>
            <div class="info-item">
                <span class="info-label">Order ID:</span>
                <span class="info-value">#${order.orderId}</span>
            </div>

            <c:set var="statusLower" value="${fn:toLowerCase(order.status)}" />
            <c:set var="statusLabel" value="${fn:replace(order.status, '_', ' ')}" />

            <div class="info-item">
                <span class="info-label">Status:</span>
                <span class="status-badge status-${statusLower}">${statusLabel}</span>
            </div>
        </div>

        <div class="info-card">
            <h3>
                <svg width="24" height="24" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd"/>
                </svg>
                Important Dates
            </h3>
            <div class="info-item">
                <span class="info-label">Order Date:</span>
                <span class="info-value">
                    <c:choose>
                        <c:when test="${not empty order.orderDate}">${order.orderDate}</c:when>
                        <c:otherwise>Not set</c:otherwise>
                    </c:choose>
                </span>
            </div>
            <div class="info-item">
                <span class="info-label">Pickup Date:</span>
                <span class="info-value">
                    <c:choose>
                        <c:when test="${not empty order.pickupDate}">${order.pickupDate}</c:when>
                        <c:otherwise>Not scheduled</c:otherwise>
                    </c:choose>
                </span>
            </div>
            <div class="info-item">
                <span class="info-label">Delivery Date:</span>
                <span class="info-value">
                    <c:choose>
                        <c:when test="${not empty order.deliveryDate}">${order.deliveryDate}</c:when>
                        <c:otherwise>Not scheduled</c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
    </div>

    <div class="items-section fade-in">
        <div class="items-header">
            <h3>
                <svg width="24" height="24" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M3 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd"/>
                </svg>
                Service Items
            </h3>
        </div>
        <table class="items-table">
            <thead>
            <tr>
                <th>Service Name</th>
                <th>Quantity</th>
                <th>Unit Price</th>
                <th>Total Price</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${order.items}">
                <tr>
                    <td><strong>${item.serviceItem.serviceName}</strong></td>
                    <td>${item.quantity}</td>
                    <td>Rs. ${item.serviceItem.unitPrice}</td>
                    <td class="price-cell">Rs. ${item.price}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty order.items}">
                <tr>
                    <td colspan="4" style="color:rgb(var(--muted-foreground));padding:2rem;text-align:center;font-style:italic;">
                        No service items in this order.
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>

    <c:if test="${not empty order.instructions}">
        <div class="instructions-card fade-in">
            <h3>
                <svg width="24" height="24" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
                </svg>
                Special Instructions
            </h3>
            <div class="instructions-text">${order.instructions}</div>
        </div>
    </c:if>

    <div class="actions fade-in">
        <a href="/customer-dashboard/${order.orderId}/edit" class="btn btn-primary">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
                <path d="m18.5 2.5 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
            </svg>
            Edit Order
        </a>
        <a href="/customer-dashboard" class="btn btn-secondary">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                <path d="m12 19-7-7 7-7"/>
                <path d="M19 12H5"/>
            </svg>
            Back to Dashboard
        </a>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Auto-dismiss any alerts
        document.querySelectorAll('.alert').forEach(a => {
            setTimeout(() => {
                a.style.opacity = '0';
                a.style.transform = 'translateY(-10px)';
                setTimeout(() => a.remove(), 300);
            }, 5000);
        });

        // Stagger animations
        document.querySelectorAll('.info-card, .items-section, .instructions-card').forEach((c, i) => {
            c.style.animationDelay = `${i * 0.1}s`;
        });
    });
</script>

</body>
</html>
