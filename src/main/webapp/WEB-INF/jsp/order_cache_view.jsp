<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order Cache Singleton Demo</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans leading-normal tracking-normal">

<div class="max-w-5xl mx-auto mt-10 bg-white shadow-md rounded-lg p-8">
    <h1 class="text-2xl font-bold mb-4 text-blue-600">Order Cache View (Admin Only)</h1>

    <c:if test="${not empty message}">
        <div class="p-4 mb-4 text-green-800 bg-green-100 rounded-lg">${message}</div>
    </c:if>

    <div class="flex justify-between items-center mb-6">
        <p class="text-gray-700">
            <strong>Last fetched at:</strong> ${cacheTime}
        </p>
        <a href="${pageContext.request.contextPath}/order-cache/refresh"
           class="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition">
            🔄 Refresh Cache
        </a>
    </div>

    <table class="min-w-full border border-gray-300 rounded-lg overflow-hidden">
        <thead class="bg-blue-100">
        <tr>
            <th class="py-2 px-4 text-left border-b">Order ID</th>
            <th class="py-2 px-4 text-left border-b">Customer ID</th>
            <th class="py-2 px-4 text-left border-b">Status</th>
            <th class="py-2 px-4 text-left border-b">Order Date</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="o" items="${orders}">
            <tr class="hover:bg-gray-50">
                <td class="py-2 px-4 border-b">${o.orderId}</td>
                <td class="py-2 px-4 border-b">${o.customerId}</td>
                <td class="py-2 px-4 border-b">${o.status}</td>
                <td class="py-2 px-4 border-b">${o.orderDate}</td>
            </tr>
        </c:forEach>

        <c:if test="${empty orders}">
            <tr>
                <td colspan="4" class="text-center py-4 text-gray-500">No orders found in cache.</td>
            </tr>
        </c:if>
        </tbody>
    </table>

    <div class="mt-6 text-sm text-gray-500">
        <p>
            <strong>REFRESH</strong> the cache to view the new orders.
            <code> It takes 1-5 seconds to update the cache </code><br> <strong> <<< Developed by PGNO 204 >>>></strong>
        </p>
    </div>
</div>

</body>
</html>
