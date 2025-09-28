<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Laundry Management - Orders</title>
    <style>
        :root {
            --background:#ffffff; --foreground:#1e293b; --card:#f8fafc; --card-foreground:#1e293b;
            --primary:#2563eb; --primary-foreground:#ffffff; --secondary:#e2e8f0; --secondary-foreground:#475569;
            --muted:#f1f5f9; --muted-foreground:#64748b; --accent:#3b82f6; --accent-foreground:#ffffff;
            --destructive:#ef4444; --destructive-foreground:#ffffff; --border:#e2e8f0; --input:#ffffff;
            --ring:rgba(37,99,235,.3); --radius:.75rem; --shadow:0 1px 3px 0 rgb(0 0 0 / .1), 0 1px 2px -1px rgb(0 0 0 / .1);
            --shadow-lg:0 10px 15px -3px rgb(0 0 0 / .1), 0 4px 6px -4px rgb(0 0 0 / .1);
            --shadow-xl:0 20px 25px -5px rgb(0 0 0 / .1), 0 8px 10px -6px rgb(0 0 0 / .1);
            --gradient-primary:linear-gradient(135deg,#2563eb 0%,#3b82f6 50%,#60a5fa 100%);
            --gradient-secondary:linear-gradient(135deg,#f8fafc 0%,#e2e8f0 100%);
        }
        *{margin:0;padding:0;box-sizing:border-box}
        body{font-family:'Segoe UI',Tahoma,Geneva,Verdana,sans-serif;background:linear-gradient(135deg,#f8fafc 0%,#e2e8f0 100%);color:var(--foreground);line-height:1.6;min-height:100vh}
        .header{background:var(--gradient-primary);color:var(--primary-foreground);padding:2.5rem 0;box-shadow:var(--shadow-xl);position:relative;overflow:hidden}
        .header::before{content:'';position:absolute;inset:0;background:url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="g" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="rgba(255,255,255,0.1)" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23g)"/></svg>');opacity:.3}
        .header-content{max-width:1200px;margin:0 auto;padding:0 2rem;display:flex;align-items:center;justify-content:space-between;position:relative;z-index:1}
        .header h1{font-size:2.5rem;font-weight:700;display:flex;align-items:center;gap:1rem;text-shadow:0 2px 4px rgba(0,0,0,.1)}
        .header-icon{width:3rem;height:3rem;background:rgba(255,255,255,.2);border-radius:var(--radius);display:flex;align-items:center;justify-content:center;backdrop-filter:blur(10px);border:1px solid rgba(255,255,255,.3);font-size:1.5rem}
        .breadcrumb{display:flex;align-items:center;gap:.75rem;font-size:1rem;opacity:.9;background:rgba(255,255,255,.1);padding:.5rem 1rem;border-radius:var(--radius);backdrop-filter:blur(10px)}
        .container{max-width:1200px;margin:0 auto;padding:2rem}
        .alert{background:var(--card);border:1px solid var(--border);border-radius:var(--radius);padding:1.25rem;margin-bottom:2rem;box-shadow:var(--shadow-lg);display:flex;align-items:center;gap:1rem;backdrop-filter:blur(10px)}
        .alert.success{background:linear-gradient(135deg,#f0fdf4 0%,#dcfce7 100%);border-color:#22c55e;color:#166534}
        .alert-icon{width:1.5rem;height:1.5rem;flex-shrink:0}
        .form-card{background:var(--card);border:1px solid var(--border);border-radius:var(--radius);padding:2.5rem;margin-bottom:2rem;box-shadow:var(--shadow-xl);backdrop-filter:blur(10px);position:relative;overflow:hidden}
        .form-card::before{content:'';position:absolute;top:0;left:0;right:0;height:4px;background:var(--gradient-primary)}
        .form-card h2{font-size:1.75rem;font-weight:600;margin-bottom:2rem;color:var(--primary);display:flex;align-items:center;gap:.75rem}
        .form-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:2rem;margin-bottom:2rem}
        .form-group{display:flex;flex-direction:column;gap:.75rem}
        .form-group label{font-weight:600;color:var(--foreground);font-size:.875rem;text-transform:uppercase;letter-spacing:.025em}
        .form-control{padding:1rem;border:2px solid var(--border);border-radius:var(--radius);background:var(--input);color:var(--foreground);font-size:.875rem;transition:.3s;box-shadow:var(--shadow)}
        .form-control:focus{outline:none;border-color:var(--primary);box-shadow:0 0 0 4px var(--ring);transform:translateY(-2px)}
        .form-control.wide{grid-column:span 2}
        .btn{padding:1rem 2rem;border:none;border-radius:var(--radius);font-weight:600;font-size:.875rem;cursor:pointer;transition:.3s;display:inline-flex;align-items:center;gap:.75rem;text-decoration:none;text-transform:uppercase;letter-spacing:.025em;box-shadow:var(--shadow-lg)}
        .btn-primary{background:var(--gradient-primary);color:var(--primary-foreground)}
        .btn-primary:hover{transform:translateY(-3px);box-shadow:var(--shadow-xl);filter:brightness(1.1)}
        .btn-secondary{background:var(--gradient-secondary);color:var(--secondary-foreground);border:2px solid var(--border)}
        .btn-secondary:hover{background:var(--muted);transform:translateY(-2px)}
        .btn-danger{background:linear-gradient(135deg,#ef4444 0%,#dc2626 100%);color:var(--destructive-foreground)}
        .btn-danger:hover{background:linear-gradient(135deg,#dc2626 0%,#b91c1c 100%);transform:translateY(-2px)}
        .btn-sm{padding:.75rem 1.25rem;font-size:.75rem}
        .table-card{background:var(--card);border:1px solid var(--border);border-radius:var(--radius);overflow:hidden;box-shadow:var(--shadow-xl);backdrop-filter:blur(10px);position:relative}
        .table-card::before{content:'';position:absolute;top:0;left:0;right:0;height:4px;background:var(--gradient-primary)}
        .table-header{padding:2rem;border-bottom:2px solid var(--border);display:flex;align-items:center;justify-content:space-between;background:var(--gradient-secondary)}
        .table-header h2{font-size:1.5rem;font-weight:600;color:var(--primary)}
        .table-container{overflow-x:auto}
        .table{width:100%;border-collapse:collapse}
        .table th{background:var(--muted);padding:1.25rem;text-align:left;font-weight:700;font-size:.875rem;color:var(--foreground);border-bottom:2px solid var(--border);text-transform:uppercase;letter-spacing:.025em}
        .table td{padding:1.25rem;border-bottom:1px solid var(--border);font-size:.875rem}
        .table tbody tr:hover{background:var(--secondary);transform:scale(1.01);box-shadow:var(--shadow)}
        .status-badge{padding:.5rem 1rem;border-radius:9999px;font-size:.75rem;font-weight:600;text-transform:uppercase;letter-spacing:.05em;box-shadow:var(--shadow)}
        .status-received{background:linear-gradient(135deg,#dbeafe 0%,#bfdbfe 100%);color:#1e40af}
        .status-in_process{background:linear-gradient(135deg,#fef3c7 0%,#fde68a 100%);color:#d97706}
        .status-ready{background:linear-gradient(135deg,#d1fae5 0%,#a7f3d0 100%);color:#059669}
        .status-delivered{background:linear-gradient(135deg,#dcfce7 0%,#bbf7d0 100%);color:#16a34a}
        .status-cancelled{background:linear-gradient(135deg,#fee2e2 0%,#fecaca 100%);color:#dc2626}
        .action-buttons{display:flex;gap:.75rem;align-items:center}
        .action-link{color:var(--primary);text-decoration:none;font-size:.875rem;font-weight:600;padding:.5rem 1rem;border-radius:var(--radius);transition:.3s;background:rgba(37,99,235,.1);border:1px solid rgba(37,99,235,.2)}
        .action-link:hover{background:var(--primary);color:var(--primary-foreground);transform:translateY(-2px);box-shadow:var(--shadow)}
        .footer{margin-top:3rem;padding:2rem 0;border-top:2px solid var(--border);text-align:center;background:var(--gradient-secondary)}
        @media (max-width:768px){.header-content{flex-direction:column;gap:1.5rem;text-align:center}.container{padding:1rem}.form-grid{grid-template-columns:1fr}.form-control.wide{grid-column:span 1}.table-header{flex-direction:column;gap:1rem;align-items:flex-start}.action-buttons{flex-direction:column;align-items:flex-start}}
        .loading{display:inline-block;width:1rem;height:1rem;border:2px solid var(--border);border-radius:50%;border-top-color:var(--primary);animation:spin 1s ease-in-out infinite}
        @keyframes spin{to{transform:rotate(360deg)}}
        .fade-in{animation:fadeIn .6s ease-out}
        @keyframes fadeIn{from{opacity:0;transform:translateY(20px)}to{opacity:1;transform:translateY(0)}}
        .form-card:hover{transform:translateY(-5px);box-shadow:var(--shadow-xl)}
        .table-card:hover{transform:translateY(-3px)}
        @keyframes pulse{0%,100%{opacity:1}50%{opacity:.8}}
        .btn-primary:active{animation:pulse .3s ease-in-out}
    </style>
</head>
<body>
<header class="header">
    <div class="header-content">
        <h1><div class="header-icon">🧺</div>LMS PRO - ORDER MANAGEMENT</h1>
        <nav class="breadcrumb">
            <a href="/home" style="color:inherit;text-decoration:none;">Home</a><span>›</span><span>Orders</span>
        </nav>
    </div>
</header>

<main class="container">
    <c:if test="${not empty msg}">
        <div class="alert success fade-in">
            <svg class="alert-icon" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/></svg>
                ${msg}
        </div>
    </c:if>

    <!-- Create Order Form -->
    <div class="form-card fade-in">
        <h2>
            <svg width="24" height="24" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd"/></svg>
            Create New Order
        </h2>
        <form action="/orders" method="post" id="orderForm">
            <div class="form-grid">
                <!-- Customer Username dropdown (posts 'customerUsername') -->
                <div class="form-group">
                    <label for="customerUsername">Customer Username *</label>
                    <select id="customerUsername" name="customerUsername" class="form-control" required>
                        <option value="">Select customer</option>
                        <c:forEach var="u" items="${customerUsernames}">
                            <option value="${u}">${u}</option>
                        </c:forEach>
                    </select>
                    <small style="color:var(--muted-foreground)"></small>
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
                <svg width="18" height="18" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd"/></svg>
                Create Order
            </button>
        </form>
    </div>

    <!-- Orders Table -->
    <div class="table-card fade-in">
        <div class="table-header">
            <h2>
                <svg width="24" height="24" fill="currentColor" viewBox="0 0 20 20"><path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/><path fill-rule="evenodd" d="M4 5a2 2 0 012-2v1a1 1 0 001 1h6a1 1 0 001-1V3a2 2 0 012 2v6a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/></svg>
                Order Management
            </h2>
            <div class="action-buttons">
                <button class="btn btn-secondary btn-sm" onclick="refreshTable()">
                    <svg width="16" height="16" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M4 2a1 1 0 011 1v2.101a7.002 7.002 0 0111.601 2.566 1 1 0 11-1.885.666A5.002 5.002 0 005.999 7H9a1 1 0 010 2H4a1 1 0 01-1-1V3a1 1 0 011-1zm.008 9.057a1 1 0 011.276.61A5.002 5.002 0 0014.001 13H11a1 1 0 110-2h5a1 1 0 011 1v5a1 1 0 11-2 0v-2.101a7.002 7.002 0 01-11.601-2.566 1 1 0 01.61-1.276z" clip-rule="evenodd"/></svg>
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
                        <td>
                            <c:choose>
                                <c:when test="${not empty idToUsername[o.customerId]}">
                                    ${idToUsername[o.customerId]}
                                </c:when>
                                <c:otherwise>
                                    Customer ${o.customerId}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="status-badge status-${o.status.name().toLowerCase()}">
                                    ${o.status.name().replace('_',' ')}
                            </span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty o.orderDate}">${o.orderDate}</c:when>
                                <c:otherwise><span style="color:var(--muted-foreground)">Not set</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty o.pickupDate}">${o.pickupDate}</c:when>
                                <c:otherwise><span style="color:var(--muted-foreground)">Not scheduled</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty o.deliveryDate}">${o.deliveryDate}</c:when>
                                <c:otherwise><span style="color:var(--muted-foreground)">Not scheduled</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <a href="/orders/${o.orderId}" class="action-link">View</a>
                                <a href="/orders/${o.orderId}/edit" class="action-link">Edit</a>
                                <form action="/orders/${o.orderId}/delete" method="post" style="display:inline" onsubmit="return confirmDelete('${o.orderId}');">
                                    <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                </form>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orders}">
                    <tr>
                        <td colspan="7" style="text-align:center;padding:3rem;color:var(--muted-foreground)">
                            <svg width="64" height="64" fill="currentColor" viewBox="0 0 20 20" style="margin-bottom:1rem;opacity:.5">
                                <path fill-rule="evenodd" d="M5 4a3 3 0 00-3 3v6a3 3 0 003 3h10a3 3 0 003-3V7a3 3 0 00-3-3H5zm-1 9v-1h5v2H5a1 1 0 01-1-1zm7 1h4a1 1 0 001-1v-1h-5v2zm0-4h5V8h-5v2zM9 8H4v2h5V8z" clip-rule="evenodd"/>
                            </svg>
                            <div style="font-size:1.125rem;font-weight:600">No orders found. Create your first order above!</div>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <footer class="footer">
        <p style="color:var(--muted-foreground)"><a href="/home" class="action-link">← Back to Home</a></p>
    </footer>
</main>

<script>
    document.addEventListener('DOMContentLoaded',function(){
        const form=document.getElementById('orderForm');
        const submitBtn=document.getElementById('submitBtn');

        // Default order date to now
        const orderDateInput=document.getElementById('orderDate');
        if(orderDateInput&&!orderDateInput.value){
            const now=new Date(); now.setMinutes(now.getMinutes()-now.getTimezoneOffset());
            orderDateInput.value=now.toISOString().slice(0,16);
        }

        form.addEventListener('submit',function(){
            submitBtn.disabled=true;
            submitBtn.innerHTML='<div class="loading"></div> Creating Order...';
            setTimeout(()=>{submitBtn.disabled=false;submitBtn.innerHTML=`<svg width="18" height="18" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd"/></svg> Create Order`;},3000);
        });

        document.querySelectorAll('.alert').forEach(a=>{
            setTimeout(()=>{a.style.opacity='0';a.style.transform='translateY(-10px)';setTimeout(()=>a.remove(),300)},5000);
        });
        document.querySelectorAll('.form-card,.table-card').forEach((c,i)=>c.style.animationDelay=`${i*.1}s`);
    });

    function confirmDelete(id){return confirm(`🗑️ Delete order #${id}? This cannot be undone.`);}
    function refreshTable(){
        const btn=event.target; const orig=btn.innerHTML;
        btn.innerHTML='<div class="loading"></div> Refreshing...'; btn.disabled=true;
        setTimeout(()=>window.location.reload(),500);
    }
</script>
</body>
</html>
