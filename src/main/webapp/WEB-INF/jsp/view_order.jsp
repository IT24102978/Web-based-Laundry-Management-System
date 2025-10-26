<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Order - Laundry Management</title>
    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-blue-dark: #1d4ed8;
            --secondary-blue: #3b82f6;
            --light-blue: #dbeafe;
            --very-light-blue: #eff6ff;
            --white: #ffffff;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }
        *{margin:0;padding:0;box-sizing:border-box}
        body{
            font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;
            background:linear-gradient(135deg,var(--very-light-blue) 0%,var(--light-blue) 100%);
            min-height:100vh;color:var(--gray-800);line-height:1.6
        }
        .container{max-width:1000px;margin:0 auto;padding:2rem}
        .header{
            background:linear-gradient(135deg,var(--primary-blue) 0%,var(--secondary-blue) 100%);
            color:var(--white);padding:2rem;border-radius:16px;margin-bottom:2rem;
            box-shadow:var(--shadow-xl);position:relative;overflow:hidden
        }
        .header::before{
            content:'';position:absolute;inset:0;
            background:url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.1'%3E%3Ccircle cx='30' cy='30' r='2'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E") repeat;
            opacity:.3
        }
        .header h1{font-size:2.5rem;font-weight:700;margin-bottom:.5rem;position:relative;z-index:1}
        .order-number{font-size:1.2rem;opacity:.9;position:relative;z-index:1}
        .content-grid{display:grid;grid-template-columns:1fr 1fr;gap:2rem;margin-bottom:2rem}
        .info-card{
            background:var(--white);padding:2rem;border-radius:12px;box-shadow:var(--shadow-lg);
            border:1px solid var(--gray-200);transition:all .3s ease
        }
        .info-card:hover{transform:translateY(-4px);box-shadow:var(--shadow-xl);border-color:var(--light-blue)}
        .info-card h3{color:var(--primary-blue);font-size:1.5rem;font-weight:600;margin-bottom:1.5rem;padding-bottom:.5rem;border-bottom:2px solid var(--light-blue)}
        .info-item{display:flex;justify-content:space-between;align-items:center;padding:.75rem 0;border-bottom:1px solid var(--gray-100)}
        .info-item:last-child{border-bottom:none}
        .info-label{font-weight:600;color:var(--gray-700)}
        .info-value{color:var(--gray-600);font-weight:500}
        .status-badge{padding:.5rem 1rem;border-radius:20px;font-weight:600;font-size:.875rem;text-transform:uppercase;letter-spacing:.5px}
        .status-received{background:linear-gradient(135deg,#fef3c7,#fde68a);color:#92400e}
        .status-in_process{background:linear-gradient(135deg,var(--light-blue),#bfdbfe);color:var(--primary-blue-dark)}
        .status-ready{background:linear-gradient(135deg,#d1fae5,#a7f3d0);color:#065f46}
        .status-delivered{background:linear-gradient(135deg,#dcfce7,#bbf7d0);color:#166534}
        .status-cancelled{background:linear-gradient(135deg,#fee2e2,#fecaca);color:#991b1b}
        .items-section{background:var(--white);border-radius:12px;box-shadow:var(--shadow-lg);overflow:hidden;border:1px solid var(--gray-200)}
        .items-header{background:linear-gradient(135deg,var(--primary-blue),var(--secondary-blue));color:var(--white);padding:1.5rem 2rem}
        .items-header h3{font-size:1.5rem;font-weight:600}
        .items-table{width:100%;border-collapse:collapse}
        .items-table th{background:var(--gray-50);padding:1rem 1.5rem;text-align:left;font-weight:600;color:var(--gray-700);border-bottom:2px solid var(--gray-200)}
        .items-table td{padding:1rem 1.5rem;border-bottom:1px solid var(--gray-100);transition:background-color .2s ease}
        .items-table tr:hover td{background:var(--very-light-blue)}
        .items-table tr:last-child td{border-bottom:none}
        .price-cell{font-weight:600;color:var(--primary-blue)}
        .actions{display:flex;gap:1rem;justify-content:center;margin-top:2rem}
        .btn{padding:.75rem 2rem;border:none;border-radius:8px;font-weight:600;text-decoration:none;display:inline-flex;align-items:center;gap:.5rem;transition:all .3s ease;cursor:pointer;font-size:1rem}
        .btn-primary{background:linear-gradient(135deg,var(--primary-blue),var(--secondary-blue));color:var(--white);box-shadow:var(--shadow-md)}
        .btn-primary:hover{transform:translateY(-2px);box-shadow:var(--shadow-lg);background:linear-gradient(135deg,var(--primary-blue-dark),var(--primary-blue))}
        .btn-secondary{background:var(--white);color:var(--primary-blue);border:2px solid var(--primary-blue);box-shadow:var(--shadow-sm)}
        .btn-secondary:hover{background:var(--very-light-blue);transform:translateY(-2px);box-shadow:var(--shadow-md)}
        .instructions-card{grid-column:1 / -1;background:var(--white);padding:2rem;border-radius:12px;box-shadow:var(--shadow-lg);border:1px solid var(--gray-200);margin-top:1rem}
        .instructions-card h3{color:var(--primary-blue);font-size:1.5rem;font-weight:600;margin-bottom:1rem}
        .instructions-text{background:var(--gray-50);padding:1.5rem;border-radius:8px;border-left:4px solid var(--primary-blue);font-style:italic;color:var(--gray-700)}
        @media (max-width:768px){
            .container{padding:1rem}
            .content-grid{grid-template-columns:1fr;gap:1rem}
            .header h1{font-size:2rem}
            .actions{flex-direction:column;align-items:center}
            .btn{width:100%;justify-content:center}
        }
        .fade-in{animation:fadeIn .6s ease-out}
        @keyframes fadeIn{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
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
            <h3>Customer Information</h3>
            <div class="info-item">
                <span class="info-label">Customer ID:</span>
                <span class="info-value">${order.customerId}</span>
            </div>

            <c:set var="statusLower" value="${fn:toLowerCase(order.status)}" />
            <c:set var="statusLabel" value="${fn:replace(order.status, '_', ' ')}" />

            <div class="info-item">
                <span class="info-label">Status:</span>
                <span class="status-badge status-${statusLower}">${statusLabel}</span>
            </div>
        </div>

        <div class="info-card">
            <h3>Timeline</h3>
            <div class="info-item">
                <span class="info-label">Order Date:</span>
                <span class="info-value">${order.orderDate}</span>
            </div>
            <div class="info-item">
                <span class="info-label">Pickup Date:</span>
                <span class="info-value"><c:out value="${order.pickupDate}" default="—" /></span>
            </div>
            <div class="info-item">
                <span class="info-label">Delivery Date:</span>
                <span class="info-value"><c:out value="${order.deliveryDate}" default="—" /></span>
            </div>
        </div>

        <c:if test="${not empty order.instructions}">
            <div class="instructions-card">
                <h3>Special Instructions</h3>
                <div class="instructions-text">
                        ${order.instructions}
                </div>
            </div>
        </c:if>
    </div>

    <div class="items-section fade-in">
        <div class="items-header">
            <h3>Order Items</h3>
        </div>
        <table class="items-table">
            <thead>
            <tr>
                <th>Service Item ID</th>
                <th>Quantity</th>
                <th>Price</th>
            </tr>
            </thead>
            <tbody>
            <!-- If your property name is different (e.g. orderItems), change items="${order.items}" accordingly -->
            <c:forEach var="item" items="${order.items}">
                <tr>
                    <td>${item.serviceItem.serviceName}</td> <!-- ✅ fixed -->
                    <td>${item.quantity}</td>
                    <td class="price-cell">$${item.price}</td>
                </tr>
            </c:forEach>
            <c:if test="${empty order.items}">
                <tr>
                    <td colspan="3" style="color:#6b7280;padding:1rem 1.5rem">No items on this order.</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>

    <div class="actions fade-in">
        <a href="/orders/${order.orderId}/edit" class="btn btn-primary">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
                <path d="m18.5 2.5 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
            </svg>
            Edit Order
        </a>
        <a href="/orders" class="btn btn-secondary">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">
                <path d="m12 19-7-7 7-7"/>
                <path d="M19 12H5"/>
            </svg>
            Back to Orders
        </a>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // subtle card entrance
        document.querySelectorAll('.info-card, .items-section').forEach((card, i) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'all 0.6s ease';
            setTimeout(() => {
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, 120 + i * 120);
        });

        // small hover polish on rows
        document.querySelectorAll('.items-table tbody tr').forEach(row => {
            row.addEventListener('mouseenter', () => row.style.transform = 'scale(1.01)');
            row.addEventListener('mouseleave', () => row.style.transform = 'scale(1)');
            row.style.transition = 'transform .15s ease';
        });
    });
</script>
</body>
</html>
