<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Employee Account – LMS PRO</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 p-8">
<div class="max-w-lg mx-auto bg-white p-6 rounded-xl shadow-md">
    <h1 class="text-2xl font-bold mb-4 text-sky-700">Add Employee Account</h1>

    <form action="${pageContext.request.contextPath}/employees/create-account" method="post" class="space-y-4">
        <!-- Username (auto-generated) -->
        <div>
            <label class="block text-sm font-medium">Username</label>
            <input type="text" name="username" value="${username}" readonly
                   class="w-full border rounded p-2 bg-gray-100" />
        </div>

        <!-- Password -->
        <div>
            <label class="block text-sm font-medium">Password</label>
            <input type="password" name="password" class="w-full border rounded p-2" required />
        </div>

        <!-- Employee Name -->
        <div>
            <label class="block text-sm font-medium">Full Name</label>
            <input type="text" name="name" class="w-full border rounded p-2" required />
        </div>

        <!-- Contact No -->
        <div>
            <label class="block text-sm font-medium">Contact Number <span style="color:red">*</span></label>
            <input
                    type="text"
                    name="contactNo"
                    class="w-full border rounded p-2"
                    required
                    pattern="^\d{9,11}$"
                    minlength="9"
                    maxlength="11"
                    title="Enter a valid contact number (9 to 11 digits only)"
                    oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0,11);"
            />
        </div>


        <!-- Role Title -->
        <div>
            <label class="block text-sm font-medium">Role / Title</label>
            <input type="text" name="roleTitle" class="w-full border rounded p-2" />
        </div>

        <!-- Salary -->
        <div>
            <label class="block text-sm font-medium">Salary (LKR)</label>
            <input type="number" step="0.01" name="salary" class="w-full border rounded p-2" />
        </div>

        <!-- Manager ID (Yes/No dropdown) -->
        <div>
            <label class="block text-sm font-medium">Manager <span style="color:red">*</span></label>
            <select name="manager.employeeId" class="w-full border rounded p-2" required>
                <option value="" disabled selected>-- Select a Manager --</option>
                <c:forEach var="m" items="${managers}">
                    <option value="${m.employeeId}">${m.name}</option>
                </c:forEach>
            </select>
        </div>


        <!-- Hired Date -->
        <div>
            <label class="block text-sm font-medium">Hired Date</label>
            <input type="date" name="hiredDate" class="w-full border rounded p-2" />
        </div>

        <!-- Buttons -->
        <div class="flex justify-end gap-3 mt-4">
            <a href="${pageContext.request.contextPath}/employees"
               class="text-gray-600 hover:text-gray-800">Cancel</a>
            <button type="submit"
                    class="bg-sky-600 hover:bg-sky-700 text-white px-4 py-2 rounded-md">
                Create Account
            </button>
        </div>
    </form>
</div>
</body>
</html>
