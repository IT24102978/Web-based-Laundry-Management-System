<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head><title>Orders</title></head>
<body>
<h2>Orders</h2>
<p><a href="${pageContext.request.contextPath}/orders/new">+ New Order</a></p>

<table border="1" cellspacing="0" cellpadding="6">
    <thead>
    <tr>
        <th>ID</th><th>Customer</th><th>Status</th><th>Order Date</th><th>Items</th><th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="o" items="${orders}">
        <tr>
            <td>${o.orderId}</td>
            <td>${o.customerId}</td>
            <td>${o.status}</td>
            <td>${o.orderDate}</td>
            <td>${fn:length(o.items)}</td>
            <td>
                <a href="${pageContext.request.contextPath}/orders/${o.orderId}">View</a>
                |
                <a href="${pageContext.request.contextPath}/orders/${o.orderId}/edit">Edit</a>
                |
                <form action="${pageContext.request.contextPath}/orders/${o.orderId}/delete" method="post" style="display:inline">
                    <button type="submit" onclick="return confirm('Delete this order?')">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
