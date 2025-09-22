<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head><title>Order #${order.orderId}</title></head>
<body>
<h1>Order #${order.orderId}</h1>

<p><b>Customer:</b> ${order.customerId}</p>
<p><b>Status:</b> ${order.status}</p>

<p><b>Order Date:</b>
    <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/>
</p>

<p><b>Pickup:</b>
    <c:if test="${order.pickupDate != null}">
        <fmt:formatDate value="${order.pickupDate}" pattern="yyyy-MM-dd HH:mm"/>
    </c:if>
</p>

<p><b>Delivery:</b>
    <c:if test="${order.deliveryDate != null}">
        <fmt:formatDate value="${order.deliveryDate}" pattern="yyyy-MM-dd HH:mm"/>
    </c:if>
</p>

<p><b>Instructions:</b> <c:out value="${order.instructions}"/></p>

<h3>Items</h3>
<table border="1" cellpadding="6">
    <tr>
        <th>Service Item ID</th>
        <th>Qty</th>
        <th>Price</th>
    </tr>
    <c:forEach items="${order.items}" var="it">
        <tr>
            <td>${it.serviceItemId}</td>
            <td>${it.quantity}</td>
            <td>${it.price}</td>
        </tr>
    </c:forEach>
    <c:if test="${empty order.items}">
        <tr><td colspan="3">No items</td></tr>
    </c:if>
</table>

<p>
    <a href="/orders/${order.orderId}/edit">Edit</a> |
    <a href="/orders">Back</a>
</p>
</body>
</html>
