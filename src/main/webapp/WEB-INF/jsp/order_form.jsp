<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title><c:choose><c:when test="${mode=='edit'}">Edit</c:when><c:otherwise>Create</c:otherwise></c:choose> Order</title>
</head>
<body>
<h2>
    <c:choose>
        <c:when test="${mode=='edit'}">Edit Order #${order.orderId}</c:when>
        <c:otherwise>Create Order</c:otherwise>
    </c:choose>
</h2>

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
        </label><br/><br/>

        <label>Status:
            <select name="status" required>
                <c:set var="s" value="${order.status}"/>
                <option value="RECEIVED"  ${s=='RECEIVED' ? 'selected':''}>RECEIVED</option>
                <option value="IN_PROCESS" ${s=='IN_PROCESS' ? 'selected':''}>IN_PROCESS</option>
                <option value="READY"     ${s=='READY' ? 'selected':''}>READY</option>
                <option value="DELIVERED" ${s=='DELIVERED' ? 'selected':''}>DELIVERED</option>
                <option value="CANCELLED" ${s=='CANCELLED' ? 'selected':''}>CANCELLED</option>
            </select>
        </label><br/><br/>

        <label>Order Date:
            <input type="datetime-local" name="orderDate" value="${order.orderDate}"/>
        </label><br/><br/>

        <label>Pickup:
            <input type="datetime-local" name="pickupDate" value="${order.pickupDate}"/>
        </label><br/><br/>

        <label>Delivery:
            <input type="datetime-local" name="deliveryDate" value="${order.deliveryDate}"/>
        </label><br/><br/>

        <label>Instructions:
            <input type="text" name="instructions" size="60" value="${order.instructions}"/>
        </label><br/><br/>

        <button type="submit">
            <c:choose><c:when test="${mode=='edit'}">Save</c:when><c:otherwise>Create</c:otherwise></c:choose>
        </button>
        &nbsp; <a href="/orders">Cancel</a>
    </form>

</body>
</html>
