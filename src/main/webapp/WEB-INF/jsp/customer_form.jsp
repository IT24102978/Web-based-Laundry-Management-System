<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add / Edit Customer Account – LMS PRO</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 p-8">
<div class="max-w-lg mx-auto bg-white p-6 rounded-xl shadow-md">
    <h1 class="text-2xl font-bold mb-4 text-sky-700">
        <c:choose>
            <c:when test="${empty customer.customerId}">Add Customer Account</c:when>
            <c:otherwise>Edit Customer Details</c:otherwise>
        </c:choose>
    </h1>

    <form action="${pageContext.request.contextPath}/customers/save" method="post" class="space-y-4">
        <input type="hidden" name="customerId" value="${customer.customerId}" />

        <!-- For editing, show linked username -->
        <c:if test="${not empty customer.customerId}">
            <div>
                <label class="block text-sm font-medium">Username</label>
                <input type="text" value="${customer.userAccount.username}" class="w-full border rounded p-2 bg-gray-100" readonly />
            </div>
        </c:if>

        <div>
            <label class="block text-sm font-medium">First Name</label>
            <input type="text" name="firstName" value="${customer.firstName}" class="w-full border rounded p-2" required />
        </div>

        <div>
            <label class="block text-sm font-medium">Last Name</label>
            <input type="text" name="lastName" value="${customer.lastName}" class="w-full border rounded p-2" required />
        </div>

        <div>
            <label class="block text-sm font-medium">Email <span style="color:red">*</span></label>
            <input
                    type="email"
                    name="email"
                    value="${customer.email}"
                    class="w-full border rounded p-2"
                    required
                    pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                    title="Please enter a valid email address (e.g. name@example.com)"
            />
        </div>

        <div>
            <label class="block text-sm font-medium">Contact Number <span style="color:red">*</span></label>
            <input
                    type="text"
                    name="contactNo"
                    value="${customer.contactNo}"
                    class="w-full border rounded p-2"
                    required
                    pattern="^\d{9,11}$"
                    minlength="9"
                    maxlength="11"
                    title="Enter a valid contact number (9–11 digits only)"
                    oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0,11);"
            />
        </div>


        <div>
            <label class="block text-sm font-medium">Street</label>
            <input type="text" name="street" value="${customer.street}" class="w-full border rounded p-2" />
        </div>

        <div>
            <label class="block text-sm font-medium">City</label>
            <input type="text" name="city" value="${customer.city}" class="w-full border rounded p-2" />
        </div>

        <div>
            <label class="block text-sm font-medium">Postal Code</label>
            <input type="text" name="postalCode" value="${customer.postalCode}" class="w-full border rounded p-2" />
        </div>

        <div class="flex justify-end gap-3">
            <a href="${pageContext.request.contextPath}/customers" class="text-gray-600 hover:text-gray-800">Cancel</a>
            <button type="submit" class="bg-sky-600 hover:bg-sky-700 text-white px-4 py-2 rounded-md">Save</button>
        </div>
    </form>
</div>
</body>
</html>
