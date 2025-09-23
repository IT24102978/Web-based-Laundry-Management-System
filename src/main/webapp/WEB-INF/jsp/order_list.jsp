<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Orders</title>
</head>
<body>
<h1>Orders</h1>

<p><a href="/orders/new">Create Order</a></p>

<table border="1" cellpadding="6" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Customer</th>
        <th>Status</th>
        <th>Order Date</th>
        <th>Pickup</th>
        <th>Delivery</th>
        <th>Actions</th>
    </tr>

    <c:forEach items="${orders}" var="o">
        <tr>
            <td>${o.orderId}</td>
            <td>${o.customerId}</td>
            <td>${o.status}</td>
            <td>${o.orderDate}</td>
            <td>${o.pickupDate}</td>
            <td>${o.deliveryDate}</td>
            <td>
                <a href="/orders/${o.orderId}">View</a> |
                <a href="/orders/${o.orderId}/edit">Edit</a> |
                <form action="/orders/${o.orderId}/delete" method="post" style="display:inline;">
                    <button type="submit" onclick="return confirm('Delete this order?')">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>

    <c:if test="${empty orders}">
        <tr><td colspan="7">No orders found.</td></tr>
    </c:if>
</table>

</body>
</html>
