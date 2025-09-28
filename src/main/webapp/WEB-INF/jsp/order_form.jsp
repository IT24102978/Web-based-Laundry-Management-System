<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>
        <c:choose>
            <c:when test="${mode=='edit'}">Edit Order</c:when>
            <c:otherwise>Create Order</c:otherwise>
        </c:choose>
    </title>
    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-blue-dark: #1d4ed8;
            --secondary-blue: #3b82f6;
            --light-blue: #dbeafe;
            --very-light-blue: #eff6ff;
            --white: #ffffff;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--very-light-blue), var(--light-blue));
            min-height: 100vh;
            color: var(--gray-800);
            margin: 0;
        }
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: var(--white);
            border-radius: 16px;
            box-shadow: var(--shadow-xl);
        }
        h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--primary-blue);
            text-align: center;
        }
        form {
            display: grid;
            gap: 1.5rem;
        }
        label {
            display: flex;
            flex-direction: column;
            font-weight: 600;
            color: var(--gray-700);
        }
        input, select, textarea {
            margin-top: 0.5rem;
            padding: 0.75rem;
            border: 1px solid var(--gray-200);
            border-radius: 8px;
            font-size: 1rem;
        }
        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 3px var(--light-blue);
        }
        .actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 1rem;
        }
        .btn {
            padding: 0.75rem 2rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: var(--white);
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, var(--primary-blue-dark), var(--primary-blue));
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }
        .btn-secondary {
            background: var(--white);
            color: var(--primary-blue);
            border: 2px solid var(--primary-blue);
        }
        .btn-secondary:hover {
            background: var(--very-light-blue);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="container fade-in">
    <h1>
        <c:choose>
            <c:when test="${mode=='edit'}">Edit Order #${order.orderId}</c:when>
            <c:otherwise>Create Order</c:otherwise>
        </c:choose>
    </h1>

    <c:choose>
    <c:when test="${mode=='edit'}">
    <form method="post" action="/orders/${order.orderId}">
        </c:when>
        <c:otherwise>
        <form method="post" action="/orders">
            </c:otherwise>
            </c:choose>

            <label>Customer ID:
                <input type="number" name="customerId" value="${order.customerId}" required/>
            </label>

            <label>Status:
                <select name="status" required>
                    <c:set var="s" value="${order.status}" />
                    <option value="RECEIVED"  ${s=='RECEIVED' ? 'selected' : ''}>RECEIVED</option>
                    <option value="IN_PROCESS" ${s=='IN_PROCESS' ? 'selected' : ''}>IN PROCESS</option>
                    <option value="READY"     ${s=='READY' ? 'selected' : ''}>READY</option>
                    <option value="DELIVERED" ${s=='DELIVERED' ? 'selected' : ''}>DELIVERED</option>
                    <option value="CANCELLED" ${s=='CANCELLED' ? 'selected' : ''}>CANCELLED</option>
                </select>
            </label>

            <label>Order Date:
                <input type="datetime-local" name="orderDate" value="${order.orderDate}" />
            </label>

            <label>Pickup Date:
                <input type="datetime-local" name="pickupDate" value="${order.pickupDate}" />
            </label>

            <label>Delivery Date:
                <input type="datetime-local" name="deliveryDate" value="${order.deliveryDate}" />
            </label>

            <label>Instructions:
                <textarea name="instructions" rows="3">${order.instructions}</textarea>
            </label>

            <div class="actions">
                <button type="submit" class="btn btn-primary">
                    <c:choose>
                        <c:when test="${mode=='edit'}">Save</c:when>
                        <c:otherwise>Create</c:otherwise>
                    </c:choose>
                </button>
                <a href="/orders" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
</div>
</body>
</html>
