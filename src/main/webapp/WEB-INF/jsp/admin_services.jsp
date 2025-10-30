<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Services</title>
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
                    <a href="/admin/users" class="px-4 py-2 text-gray-700 hover:bg-blue-50 rounded-lg font-medium">Users</a>
                    <a href="/admin/services" class="px-4 py-2 bg-blue-600 text-white rounded-lg font-medium">Services</a>
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
        <div class="w-16 h-16 bg-cyan-100 rounded-lg flex items-center justify-center">
            <svg class="w-10 h-10 text-cyan-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"/>
            </svg>
        </div>
        <div>
            <h1 class="text-2xl font-bold text-blue-600">Manage Services</h1>
            <p class="text-sm text-gray-600">Configure laundry services and pricing</p>
        </div>
    </div>

    <!-- Flash Message -->
    <c:if test="${not empty msg}">
        <div class="mb-6 p-4 bg-green-50 border border-green-200 text-green-700 rounded-lg">${msg}</div>
    </c:if>

    <!-- Add New Service Form -->
    <div class="bg-white rounded-lg shadow-sm border border-blue-100 p-6 mb-8">
        <h2 class="text-lg font-semibold text-gray-800 mb-4">Add New Service</h2>
        <!-- Updated form to use service name dropdown and validate description -->
        <form method="post" action="/admin/services" onsubmit="return validateServiceForm('create')">
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Service Name</label>
                    <select id="serviceName" name="serviceName" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                        <option value="">Select a service</option>
                        <option value="Wash & Fold">Wash & Fold</option>
                        <option value="Dry Cleaning">Dry Cleaning</option>
                        <option value="Iron Only">Iron Only</option>
                        <option value="Wash & Iron">Wash & Iron</option>
                        <option value="Stain Removal">Stain Removal</option>
                        <option value="Custom Service">Custom Service</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                    <input type="text" id="description" name="description" placeholder="Service details"
                           class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                    <p class="mt-1 text-xs text-gray-500">Cannot be only numbers</p>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Unit Price</label>
                    <input type="number" step="0.01" id="unitPrice" name="unitPrice" placeholder="0.00"
                           class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required />
                    <p class="mt-1 text-xs text-gray-500">Must be greater than 0</p>
                </div>
                <div class="flex items-end">
                    <button type="submit" class="w-full px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">Add Service</button>
                </div>
            </div>
        </form>
    </div>

    <!-- Services Table -->
    <div class="bg-white rounded-lg shadow-sm border border-blue-100 overflow-hidden">
        <div class="px-6 py-4 border-b border-gray-200">
            <h2 class="text-lg font-semibold text-gray-800">All Services</h2>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-blue-50">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">ID</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Service Name</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Description</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Unit Price</th>
                    <th class="px-6 py-3 text-center text-xs font-medium text-gray-700 uppercase tracking-wider">Actions</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <c:forEach var="s" items="${services}">
                    <tr class="hover:bg-blue-50 transition-colors">
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${s.serviceItemId}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${s.serviceName}</td>
                        <td class="px-6 py-4 text-sm text-gray-600">${s.description}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-blue-600">$${s.unitPrice}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-center space-x-2">
                            <button onclick="openEditModal(${s.serviceItemId}, '${s.serviceName}', '${s.description}', ${s.unitPrice})" class="px-3 py-1 bg-cyan-500 text-white text-sm rounded-lg hover:bg-cyan-600 transition-colors">Edit</button>
                            <form method="post" action="/admin/services/${s.serviceItemId}/delete" class="inline">
                                <button type="submit" onclick="return confirm('Are you sure you want to delete this service?')"
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

<!-- Edit Service Modal -->
<div id="editModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg shadow-xl p-8 max-w-md w-full mx-4">
        <div class="flex items-center justify-between mb-6">
            <h2 class="text-2xl font-bold text-blue-600">Edit Service</h2>
            <button onclick="closeEditModal()" class="text-gray-500 hover:text-gray-700">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>
        </div>

        <form id="editForm" method="post" onsubmit="return validateServiceForm('edit')">
            <input type="hidden" id="editServiceId" name="serviceItemId" />

            <!-- Updated to use service name dropdown -->
            <div class="mb-4">
                <label class="block text-sm font-medium text-gray-700 mb-1">Service Name</label>
                <select id="editServiceName" name="serviceName" class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                    <option value="Wash & Fold">Wash & Fold</option>
                    <option value="Dry Cleaning">Dry Cleaning</option>
                    <option value="Iron Only">Iron Only</option>
                    <option value="Wash & Iron">Wash & Iron</option>
                    <option value="Stain Removal">Stain Removal</option>
                    <option value="Custom Service">Custom Service</option>
                </select>
            </div>

            <div class="mb-4">
                <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                <input type="text" id="editDescription" name="description" placeholder="Service details"
                       class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" />
                <p class="mt-1 text-xs text-gray-500">Cannot be only numbers</p>
            </div>

            <div class="mb-6">
                <label class="block text-sm font-medium text-gray-700 mb-1">Unit Price</label>
                <input type="number" step="0.01" id="editUnitPrice" name="unitPrice" placeholder="0.00"
                       class="w-full border border-gray-300 rounded-lg px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500" required />
                <p class="mt-1 text-xs text-gray-500">Must be greater than 0</p>
            </div>

            <div class="flex space-x-3">
                <button type="button" onclick="closeEditModal()" class="flex-1 px-4 py-2 bg-gray-300 text-gray-700 rounded-lg hover:bg-gray-400 transition-colors">Cancel</button>
                <button type="submit" class="flex-1 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors">Update Service</button>
            </div>
        </form>
    </div>
</div>

<script>
    function validateServiceForm(formType) {
        let serviceName, description, unitPrice;

        if (formType === 'create') {
            serviceName = document.getElementById('serviceName').value.trim();
            description = document.getElementById('description').value.trim();
            unitPrice = parseFloat(document.getElementById('unitPrice').value);
        } else {
            serviceName = document.getElementById('editServiceName').value.trim();
            description = document.getElementById('editDescription').value.trim();
            unitPrice = parseFloat(document.getElementById('editUnitPrice').value);
        }

        if (!serviceName) {
            alert('Service name is required');
            return false;
        }

        if (description && /^\d+$/.test(description)) {
            alert('Description cannot contain only numbers');
            return false;
        }

        if (isNaN(unitPrice) || unitPrice <= 0) {
            alert('Unit price must be greater than 0');
            return false;
        }

        return true;
    }

    function openEditModal(serviceId, serviceName, description, unitPrice) {
        document.getElementById('editServiceId').value = serviceId;
        document.getElementById('editServiceName').value = serviceName;
        document.getElementById('editDescription').value = description || '';
        document.getElementById('editUnitPrice').value = unitPrice;
        document.getElementById('editForm').action = '/admin/services/' + serviceId;
        document.getElementById('editModal').classList.remove('hidden');
    }

    function closeEditModal() {
        document.getElementById('editModal').classList.add('hidden');
    }
</script>

</body>
</html>
