<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>LMS PRO – Admin Portal</title>

    <!-- Tailwind via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        :root {
            --radius: 0.75rem;
        }

        .card {
            background: rgb(255 255 255);
            border-radius: var(--radius);
            padding: 2rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            backdrop-filter: blur(8px);
            text-align: center;
            border: 1px solid #e5e7eb;
        }

        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.08);
            border-color: #3b82f6;
        }

        .card-icon {
            font-size: 2.5rem;
            margin-bottom: 0.75rem;
        }

        .card-title {
            font-weight: 600;
            color: rgb(30 41 59);
            margin-bottom: 0.25rem;
        }

        .card-desc {
            font-size: 0.875rem;
            color: rgb(100 116 139);
        }

        .dark .card {
            background: rgb(31 41 55 / 0.9);
            border-color: rgb(55 65 81);
            color: rgb(226 232 240);
        }

        .fade-in {
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>

    <script>
        (function () {
            const saved = localStorage.getItem("theme");
            const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches;
            if ((saved === "dark") || (!saved && prefersDark)) {
                document.documentElement.classList.add("dark");
            }
        })();
    </script>
</head>

<body class="bg-white text-slate-800 dark:text-slate-100 min-h-screen flex flex-col">

<!-- Header -->
<header class="bg-white/80 dark:bg-slate-800 backdrop-blur border-b border-slate-200 dark:border-slate-700 shadow-sm sticky top-0 z-50">
    <nav class="max-w-7xl mx-auto flex justify-between items-center px-6 py-4">
        <a href="${pageContext.request.contextPath}/admin-dashboard" class="flex items-center gap-2 font-bold text-xl text-white dark:text-white">
            🧑‍💼 LMS PRO – Admin Portal
        </a>

        <div class="flex items-center gap-3">
            <button id="themeBtn" type="button" class="border rounded-full px-3 py-1 text-sm hover:bg-sky-100 dark:hover:bg-slate-800 transition">🌗</button>

            <c:if test="${not empty sessionScope.USER}">
                <span class="text-sm text-slate-600 dark:text-slate-300">
                    Welcome, <strong>${sessionScope.USER.username}</strong> 👋
                </span>
                <a href="<c:url value='/logout'/>" class="bg-red-500 hover:bg-red-600 text-white px-4 py-1 rounded-md text-sm font-semibold transition">Logout</a>
            </c:if>

            <c:if test="${empty sessionScope.USER}">
                <a href="<c:url value='/login'/>" class="text-sky-600 dark:text-sky-400 font-medium">Log in</a>
            </c:if>
        </div>
    </nav>
</header>

<!-- Main -->
<main class="flex-1 max-w-6xl mx-auto px-6 py-12 w-full fade-in">
    <h1 class="text-3xl font-bold dark:text-blue-900 mb-2">Admin Dashboard</h1>
    <p class="text-slate-500 dark:text-slate-400 mb-6">Manage all core operations of LMS PRO.</p>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-5 gap-6">
        <a href="${pageContext.request.contextPath}/orders" class="card">
            <div class="card-icon">🧺</div>
            <div class="card-title">Order Management</div>
            <div class="card-desc">Track and manage all orders.</div>
        </a>

        <a href="${pageContext.request.contextPath}/customers" class="card">
            <div class="card-icon">🧑‍🤝‍🧑</div>
            <div class="card-title">Customer Management</div>
            <div class="card-desc">Manage customer details.</div>
        </a>

        <a href="${pageContext.request.contextPath}/inventory" class="card">
            <div class="card-icon">📦</div>
            <div class="card-title">Inventory Management</div>
            <div class="card-desc">Monitor stock levels and availability.</div>
        </a>

        <a href="${pageContext.request.contextPath}/billing-management" class="card">
            <div class="card-icon">💰</div>
            <div class="card-title">Financial Management</div>
            <div class="card-desc">View financial reports and records.</div>
        </a>

        <!-- New: Employee Management -->
        <a href="${pageContext.request.contextPath}/employees" class="card">
            <div class="card-icon">🧑‍🏭</div>
            <div class="card-title">Employee Management</div>
            <div class="card-desc">Manage employee details and roles.</div>
        </a>

        <a href="${pageContext.request.contextPath}/admin/services" class="card">
            <div class="card-icon">🪙</div>
            <div class="card-title">Services Management</div>
            <div class="card-desc">Manage Services and Prices.</div>
        </a>

        <a href="${pageContext.request.contextPath}/admin/users" class="card">
            <div class="card-icon">👥</div>
            <div class="card-title">User Management</div>
            <div class="card-desc">Manage all users.</div>
        </a>

        <a href="${pageContext.request.contextPath}/order-cache" class="card">
            <div class="card-icon">🛠️</div>
            <div class="card-title">Order Cache Checker</div>
            <div class="card-desc">Update order cache.</div>
        </a>
    </div>
</main>

<!-- Footer -->
<footer class="bg-slate-800 text-white py-4 mt-12 shadow-inner">
    <div class="max-w-6xl mx-auto text-center text-sm opacity-90">
        © 2025 LMS PRO | All Rights Reserved
    </div>
</footer>

<script>
    document.getElementById('themeBtn').addEventListener('click', () => {
        const html = document.documentElement;
        const dark = html.classList.toggle('dark');
        localStorage.setItem('theme', dark ? 'dark' : 'light');
    });
</script>
</body>
</html>
