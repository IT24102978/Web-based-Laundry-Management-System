<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>View Order</title></head>
<body>
<h2>Order #${order.orderId}</h2>

<p><strong>Customer:</strong> ${order.customerId}</p>
<p><strong>Status:</strong> ${order.status}</p>
<p><strong>Order Date:</strong> ${order.orderDate}</p>
<p><strong>Pickup:</strong> ${order.pickupDate}</p>
<p><strong>Delivery:</strong> ${order.deliveryDate}</p>
<p><strong>Instructions:</strong> ${order.instructions}</p>

<h3>Items</h3>
<table border="1">
    <tr>
        <th>Service Item ID</th>
        <th>Qty</th>
        <th>Price</th>
    </tr>
    <c:forEach var="item" items="${order.items}">
        <tr>
            <td>${item.serviceItemId}</td>
            <td>${item.quantity}</td>
            <td>${item.price}</td>
        </tr>
    </c:forEach>
</table>

<a href="/orders/${order.orderId}/edit">Edit</a> |
<a href="/orders">Back</a>
</body>
</html>
