<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Form</title>
    <script>
        function addRow(){
            const tbody = document.getElementById('items-body');
            const idx = tbody.children.length;
            const tr = document.createElement('tr');
            tr.innerHTML = `
        <td><input type="number" name="items[${idx}].serviceItemId" required></td>
        <td><input type="number" name="items[${idx}].quantity" value="1" min="1" required></td>
        <td><input type="number" name="items[${idx}].price" step="0.01" value="0.00" required></td>
        <td><button type="button" onclick="this.closest('tr').remove()">Remove</button></td>
      `;
            tbody.appendChild(tr);
        }
    </script>
</head>
<body>
<h2>${order.orderId == null ? 'Create Order' : 'Edit Order #' += order.orderId}</h2>

<form method="post" action="${pageContext.request.contextPath}/orders">
    <c:if test="${order.orderId != null}">
        <input type="hidden" name="orderId" value="${order.orderId}"/>
    </c:if>

    <label>Customer ID:
        <input type="number" name="customerId" value="${order.customerId}" required/>
    </label>
    <br/>

    <label>Status:
        <select name="status">
            <c:forEach var="s" items="${statuses}">
                <option value="${s}" <c:if test="${order.status == s}">selected</c:if>>${s}</option>
            </c:forEach>
        </select>
    </label>
    <br/>

    <label>Pickup Date:
        <input type="datetime-local" name="pickupDate"
               value="${order.pickupDate != null ? order.pickupDate : ''}"/>
    </label>
    <br/>

    <label>Delivery Date:
        <input type="datetime-local" name="deliveryDate"
               value="${order.deliveryDate != null ? order.deliveryDate : ''}"/>
    </label>
    <br/>

    <label>Instructions:
        <br/>
        <textarea name="instructions" rows="3" cols="60">${order.instructions}</textarea>
    </label>

    <h3>Items</h3>
    <button type="button" onclick="addRow()">+ Add Item</button>
    <table border="1" cellspacing="0" cellpadding="4" style="margin-top:6px;">
        <thead>
        <tr><th>Service Item ID</th><th>Qty</th><th>Price</th><th></th></tr>
        </thead>
        <tbody id="items-body">
        <c:forEach var="it" items="${order.items}" varStatus="st">
            <tr>
                <td><input type="number" name="items[${st.index}].serviceItemId" value="${it.serviceItemId}" required/></td>
                <td><input type="number" name="items[${st.index}].quantity" value="${it.quantity}" min="1" required/></td>
                <td><input type="number" name="items[${st.index}].price" step="0.01" value="${it.price}" required/></td>
                <td><button type="button" onclick="this.closest('tr').remove()">Remove</button></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div style="margin-top:10px;">
        <button type="submit">Save</button>
        <a href="${pageContext.request.contextPath}/orders">Cancel</a>
    </div>
</form>
</body>
</html>
