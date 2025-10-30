<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-cyan-50 to-blue-50 min-h-screen">

<!-- Navigation Bar -->
<nav class="bg-white shadow-md border-b-2 border-blue-500">
    <div class="max-w-7xl mx-auto px-6">
        <div class="flex items-center justify-between h-16">
            <div class="flex items-center space-x-3">
                <div class="w-10 h-10 bg-gradient-to-br from-cyan-500 to-blue-600 rounded-full flex items-center justify-center">
                    <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 9.172V5L8 4z"/>
                    </svg>
                </div>
                <span class="text-xl font-bold text-blue-600">Laundry Manager</span>
            </div>

            <div class="flex items-center space-x-4">
                <span class="text-sm text-gray-600">Welcome, <span class="font-semibold text-blue-600">${sessionScope.USER.username}</span></span>
                <div class="flex space-x-1">
                    <a href="/admin" class="px-4 py-2 text-gray-700 hover:bg-blue-50 rounded-lg font-medium">Dashboard</a>
                    <a href="/admin/users" class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium">Users</a>
                    <a href="/admin/services" class="px-4 py-2 text-gray-700 hover:bg-blue-50 rounded-lg font-medium">Services</a>
                    <a href="/" class="px-4 py-2 text-red-600 hover:bg-red-50 rounded-lg font-medium">Logout</a>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="max-w-7xl mx-auto px-6 py-8">

    <!-- Page Header -->
    <div class="bg-white rounded-lg shadow-sm border border-blue-100 p-6 mb-6 flex items-center space-x-4">
        <div class="w-16 h-16 bg-blue-100 rounded-lg flex items-center justify-center">
            <svg class="w-10 h-10 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"/>
            </svg>
        </div>
        <div>
            <h1 class="text-2xl font-bold text-blue-600">Manage Users</h1>
            <p class="text-sm text-gray-600">Add, edit, and remove user accounts</p>
        </div>
    </div>

    <!-- Flash Message -->
    <c:if test="${not empty msg}">
        <div class="mb-6 p-4 bg-green-50 border border-green-200 text-green-700 rounded-lg">${msg}</div>
    </c:if>

    <!-- Add New User Form -->
    <div class="bg-white rounded-lg shadow-sm border border-blue-100 p-6 mb-8">
        <h2 class="text-lg font-semibold text-gray-800 mb-4">Add New User</h2>
        <form method="post" action="/admin/users" onsubmit="return validateUserForm('create')">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Role</label>
                    <select id="role" name="role" onchange="updateUsernamePrefix()" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                        <option value="ADMIN">Admin</option>
                        <option value="EMPLOYEE">Employee</option>
                        <option value="CUSTOMER">Customer</option>
                    </select>
                    <p class="mt-1 text-xs text-gray-500">Select user role first</p>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                    <input type="text" id="username" name="username" placeholder="Enter username"
                           class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required />
                    <p class="mt-1 text-xs text-gray-500" id="usernameHint">Must start with A</p>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                    <input type="password" id="password" name="passwordHash" placeholder="Enter password"
                           class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" minlength="3" required />
                    <p class="mt-1 text-xs text-gray-500">At least 3 characters</p>
                </div>
                <div class="flex items-end">
                    <button type="submit" class="w-full px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">ADD</button>
                </div>
            </div>
        </form>
    </div>

    <!-- Users Table -->
    <div class="bg-white rounded-lg shadow-sm border border-blue-100 overflow-hidden">
        <div class="px-6 py-4 border-b border-gray-200">
            <h2 class="text-lg font-semibold text-gray-800">All Users</h2>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-blue-50">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">ID</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Username</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Role</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Status</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Created At</th>
                    <th class="px-6 py-3 text-center text-xs font-medium text-gray-700 uppercase tracking-wider">Actions</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <c:forEach var="u" items="${users}">
                    <tr class="hover:bg-blue-50 transition-colors">
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${u.userId}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${u.username}</td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-2 py-1 text-xs font-semibold rounded-full ${u.role == 'ADMIN' ? 'bg-purple-100 text-purple-800' : u.role == 'EMPLOYEE' ? 'bg-blue-100 text-blue-800' : 'bg-gray-100 text-gray-800'}">
                                    ${u.role}
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-2 py-1 text-xs font-semibold rounded-full ${u.active ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                    ${u.active ? 'Active' : 'Inactive'}
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${u.createdAt}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-center space-x-2">
                            <button onclick="openEditModal(${u.userId}, '${u.username}', '${u.role}', ${u.active})" class="px-3 py-1 bg-cyan-500 text-white text-sm rounded-lg hover:bg-cyan-600 transition-colors">Edit</button>
                            <form method="post" action="/admin/users/${u.userId}/delete" class="inline">
                                <button type="submit" onclick="return confirm('Are you sure you want to delete this user?')"
                                        class="px-3 py-1 bg-red-500 text-white text-sm rounded-lg hover:bg-red-600 transition-colors">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- Edit User Modal -->
<div id="editModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg shadow-xl p-8 max-w-md w-full mx-4">
        <div class="flex items-center justify-between mb-6">
            <h2 class="text-2xl font-bold text-blue-600">Edit User</h2>
            <button onclick="closeEditModal()" class="text-gray-500 hover:text-gray-700">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>
        </div>

        <form id="editForm" method="post" onsubmit="return validateUserForm('edit')">
            <input type="hidden" id="editUserId" name="userId" />

            <div class="mb-4">
                <label class="block text-sm font-medium text-gray-700 mb-1">Role</label>
                <select id="editRole" name="role" onchange="updateEditUsernamePrefix()" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                    <option value="ADMIN">Admin</option>
                    <option value="EMPLOYEE">Employee</option>
                    <option value="CUSTOMER">Customer</option>
                </select>
                <p class="mt-1 text-xs text-gray-500">Select user role</p>
            </div>

            <div class="mb-4">
                <label class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                <input type="text" id="editUsername" name="username" placeholder="Enter username"
                       class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required />
                <p class="mt-1 text-xs text-gray-500" id="editUsernameHint">Must start with correct prefix</p>
            </div>

            <!-- Added checkbox to optionally update password -->
            <div class="mb-4">
                <label class="flex items-center space-x-2">
                    <input type="checkbox" id="updatePasswordCheckbox" onchange="togglePasswordField()" class="w-4 h-4 border border-gray-300 rounded focus:ring-2 focus:ring-blue-500" />
                    <span class="text-sm font-medium text-gray-700">Update Password</span>
                </label>
                <p class="mt-1 text-xs text-gray-500">Check to change password</p>
            </div>

            <div class="mb-4" id="passwordFieldContainer" style="display: none;">
                <label class="block text-sm font-medium text-gray-700 mb-1">New Password</label>
                <input type="password" id="editPassword" name="passwordHash" placeholder="Enter new password"
                       class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" minlength="3" />
                <p class="mt-1 text-xs text-gray-500">At least 3 characters</p>
            </div>

            <!-- Added checkbox to set user active or inactive -->
            <div class="mb-6 hidden">
                <label class="flex items-center space-x-2">
                    <input type="checkbox" id="editActive" name="active"
                           class="w-4 h-4 border border-gray-300 rounded focus:ring-2 focus:ring-blue-500" />
                    <span class="text-sm font-medium text-gray-700">Active User</span>
                </label>
                <p class="mt-1 text-xs text-gray-500">Check to make user active</p>
            </div>

            <div class="flex space-x-3">
                <button type="button" onclick="closeEditModal()" class="flex-1 px-4 py-2 bg-gray-300 text-gray-700 rounded-lg hover:bg-gray-400 transition-colors">Cancel</button>
                <button type="submit" class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">Update User</button>
            </div>
        </form>
    </div>
</div>

<script>
    function updateUsernamePrefix() {
        const role = document.getElementById('role').value;
        const usernameInput = document.getElementById('username');
        const hint = document.getElementById('usernameHint');

        if (role === 'ADMIN') {
            usernameInput.value = 'A';
            hint.textContent = 'Must start with A';
        } else if (role === 'CUSTOMER') {
            usernameInput.value = 'C';
            hint.textContent = 'Must start with C';
        } else if (role === 'EMPLOYEE') {
            usernameInput.value = 'E';
            hint.textContent = 'Must start with E';
        }
        usernameInput.focus();
    }

    function updateEditUsernamePrefix() {
        const role = document.getElementById('editRole').value;
        const hint = document.getElementById('editUsernameHint');

        if (role === 'ADMIN') {
            hint.textContent = 'Must start with A';
        } else if (role === 'CUSTOMER') {
            hint.textContent = 'Must start with C';
        } else if (role === 'EMPLOYEE') {
            hint.textContent = 'Must start with E';
        }
    }

    function togglePasswordField() {
        const checkbox = document.getElementById('updatePasswordCheckbox');
        const passwordContainer = document.getElementById('passwordFieldContainer');
        const passwordInput = document.getElementById('editPassword');

        if (checkbox.checked) {
            passwordContainer.style.display = 'block';
            passwordInput.required = true;
        } else {
            passwordContainer.style.display = 'none';
            passwordInput.required = false;
            passwordInput.value = '';
        }
    }

    function validateUserForm(formType) {
        let role, username, password;

        if (formType === 'create') {
            role = document.getElementById('role').value;
            username = document.getElementById('username').value.trim();
            password = document.getElementById('password').value.trim();
        } else {
            role = document.getElementById('editRole').value;
            username = document.getElementById('editUsername').value.trim();

            const updatePassword = document.getElementById('updatePasswordCheckbox').checked;
            if (updatePassword) {
                password = document.getElementById('editPassword').value.trim();
                if (password.length < 3) {
                    alert('Password must have at least 3 characters');
                    return false;
                }
            }
        }

        // Validate password length for create form
        if (formType === 'create' && password.length < 3) {
            alert('Password must have at least 3 characters');
            return false;
        }

        // Validate username prefix based on role
        const firstChar = username.charAt(0).toUpperCase();
        if (role === 'ADMIN' && firstChar !== 'A') {
            alert('Admin username must start with A');
            return false;
        }
        if (role === 'CUSTOMER' && firstChar !== 'C') {
            alert('Customer username must start with C');
            return false;
        }
        if (role === 'EMPLOYEE' && firstChar !== 'E') {
            alert('Employee username must start with E');
            return false;
        }

        return true;
    }

    function openEditModal(userId, username, role, active) {
        document.getElementById('editUserId').value = userId;
        document.getElementById('editUsername').value = username;
        document.getElementById('editRole').value = role;
        document.getElementById('editPassword').value = '';
        document.getElementById('updatePasswordCheckbox').checked = false;
        document.getElementById('editActive').checked = active;
        document.getElementById('passwordFieldContainer').style.display = 'none';
        document.getElementById('editForm').action = '/admin/users/' + userId;
        updateEditUsernamePrefix();
        document.getElementById('editModal').classList.remove('hidden');
    }

    function closeEditModal() {
        document.getElementById('editModal').classList.add('hidden');
    }

    window.onload = function() {
        updateUsernamePrefix();
    };
</script>

</body>
</html>
