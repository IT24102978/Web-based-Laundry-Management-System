<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LMS PRO - Customer Management</title>

    <!-- Tailwind via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        :root {
            --background: 255 255 255;
            --foreground: 15 23 42;
            --card: 248 250 252;
            --card-foreground: 30 41 59;
            --primary: 37 99 235;
            --primary-foreground: 255 255 255;
            --secondary: 226 232 240;
            --secondary-foreground: 71 85 105;
            --muted: 241 245 249;
            --muted-foreground: 100 116 139;
            --accent: 59 130 246;
            --accent-foreground: 255 255 255;
            --destructive: 239 68 68;
            --destructive-foreground: 255 255 255;
            --border: 226 232 240;
            --input: 255 255 255;
            --ring: rgba(37, 99, 235, .3);
            --radius: 0.75rem;
            --shadow: 0 1px 3px 0 rgb(0 0 0 / .1), 0 1px 2px -1px rgb(0 0 0 / .1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / .1), 0 4px 6px -4px rgb(0 0 0 / .1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / .1), 0 8px 10px -6px rgb(0 0 0 / .1);
        }

        .dark {
            --background: 23 23 28;
            --foreground: 245 247 250;
            --card: 33 37 41;
            --card-foreground: 245 247 250;
            --primary: 245 247 250;
            --primary-foreground: 33 37 41;
            --secondary: 46 52 64;
            --secondary-foreground: 245 247 250;
            --muted: 46 52 64;
            --muted-foreground: 173 181 189;
            --accent: 46 52 64;
            --border: 46 52 64;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: system-ui, -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            background: linear-gradient(135deg, rgb(var(--muted)) 0%, rgb(var(--secondary)) 100%);
            color: rgb(var(--foreground));
            line-height: 1.6;
            min-height: 100vh;
        }

        /* ========== ENHANCED HEADER ========== */
        .header {
            background: rgb(var(--background));
            border-bottom: 1px solid rgb(var(--border));
            position: sticky;
            top: 0;
            z-index: 50;
            backdrop-filter: blur(8px);
            box-shadow: var(--shadow-lg);
        }

        .header-nav {
            max-width: 1200px;
            margin: 0 auto;
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 2rem;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 1.5rem;
            font-weight: 700;
            color: rgb(var(--primary));
            text-decoration: none;
            transition: transform 0.2s;
        }

        .logo:hover {
            transform: translateY(-2px);
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            background: rgb(var(--primary));
            border-radius: var(--radius);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            box-shadow: var(--shadow);
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 2rem;
            flex: 1;
            justify-content: center;
        }

        .nav-link {
            color: rgb(var(--muted-foreground));
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
            font-size: 0.875rem;
        }

        .nav-link:hover {
            color: rgb(var(--foreground));
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            background: rgb(var(--muted));
            border-radius: var(--radius);
            font-size: 0.875rem;
            color: rgb(var(--foreground));
        }

        .theme-toggle {
            border: 1px solid rgb(var(--border));
            background: rgb(var(--secondary));
            color: rgb(var(--foreground));
            border-radius: 9999px;
            padding: 0.5rem 1rem;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 1rem;
        }

        .theme-toggle:hover {
            background: rgb(var(--accent));
            transform: scale(1.05);
        }

        /* ========== ENHANCED FOOTER ========== */
        .footer {
            background: rgb(var(--foreground));
            color: white;
            padding: 2rem 0;
            text-align: center;
            margin-top: 4rem;
            box-shadow: var(--shadow-xl);
        }

        .dark .footer {
            background: rgb(20 22 26);
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            font-size: 0.875rem;
        }

        .powered-by {
            opacity: 0.7;
            font-weight: 500;
        }

        /* ========== MAIN STYLES ========== */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .alert {
            background: rgb(var(--card));
            border: 1px solid rgb(var(--border));
            border-radius: var(--radius);
            padding: 1.25rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-lg);
            display: flex;
            align-items: center;
            gap: 1rem;
            backdrop-filter: blur(10px);
        }

        .alert.success {
            background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
            border-color: #22c55e;
            color: #166534;
        }

        .alert-icon {
            width: 1.5rem;
            height: 1.5rem;
            flex-shrink: 0;
        }

        .form-card {
            background: rgb(var(--card));
            border: 1px solid rgb(var(--border));
            border-radius: var(--radius);
            padding: 2.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-xl);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .form-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, rgb(var(--primary)) 0%, rgb(var(--accent)) 100%);
        }

        .form-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
        }

        .form-card h2 {
            font-size: 1.75rem;
            font-weight: 600;
            margin-bottom: 2rem;
            color: rgb(var(--primary));
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .form-group label {
            font-weight: 600;
            color: rgb(var(--foreground));
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        .form-control {
            padding: 1rem;
            border: 2px solid rgb(var(--border));
            border-radius: var(--radius);
            background: rgb(var(--input));
            color: rgb(var(--foreground));
            font-size: 0.875rem;
            transition: all 0.3s;
            box-shadow: var(--shadow);
        }

        .form-control:focus {
            outline: none;
            border-color: rgb(var(--primary));
            box-shadow: 0 0 0 4px var(--ring);
            transform: translateY(-2px);
        }

        .form-control.wide {
            grid-column: span 2;
        }

        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: var(--radius);
            font-weight: 600;
            font-size: 0.875rem;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            text-decoration: none;
            text-transform: uppercase;
            letter-spacing: 0.025em;
            box-shadow: var(--shadow-lg);
        }

        .btn-primary {
            background: linear-gradient(135deg, rgb(var(--primary)) 0%, rgb(var(--accent)) 100%);
            color: rgb(var(--primary-foreground));
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-xl);
            filter: brightness(1.1);
        }

        .btn-secondary {
            background: linear-gradient(135deg, rgb(var(--muted)) 0%, rgb(var(--secondary)) 100%);
            color: rgb(var(--secondary-foreground));
            border: 2px solid rgb(var(--border));
        }

        .btn-secondary:hover {
            background: rgb(var(--muted));
            transform: translateY(-2px);
        }

        .btn-danger {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: rgb(var(--destructive-foreground));
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
            transform: translateY(-2px);
        }

        .btn-sm {
            padding: 0.75rem 1.25rem;
            font-size: 0.75rem;
        }

        .btn-ghost {
            background: transparent;
            color: rgb(var(--foreground));
            box-shadow: none;
        }

        .btn-ghost:hover {
            background: rgb(var(--accent));
        }

        .table-card {
            background: rgb(var(--card));
            border: 1px solid rgb(var(--border));
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow-xl);
            backdrop-filter: blur(10px);
            position: relative;
            transition: transform 0.3s;
        }

        .table-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, rgb(var(--primary)) 0%, rgb(var(--accent)) 100%);
        }

        .table-card:hover {
            transform: translateY(-3px);
        }

        .table-header {
            padding: 2rem;
            border-bottom: 2px solid rgb(var(--border));
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: linear-gradient(135deg, rgb(var(--muted)) 0%, rgb(var(--secondary)) 100%);
        }

        .table-header h2 {
            font-size: 1.5rem;
            font-weight: 600;
            color: rgb(var(--primary));
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .table-container {
            overflow-x: auto;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th {
            background: rgb(var(--muted));
            padding: 1.25rem;
            text-align: left;
            font-weight: 700;
            font-size: 0.875rem;
            color: rgb(var(--foreground));
            border-bottom: 2px solid rgb(var(--border));
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        .table td {
            padding: 1.25rem;
            border-bottom: 1px solid rgb(var(--border));
            font-size: 0.875rem;
        }

        .table tbody tr {
            transition: all 0.2s;
        }

        .table tbody tr:hover {
            background: rgb(var(--secondary));
            transform: scale(1.01);
            box-shadow: var(--shadow);
        }

        .action-buttons {
            display: flex;
            gap: 0.75rem;
            align-items: center;
        }

        .action-link {
            color: rgb(var(--primary));
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: var(--radius);
            transition: all 0.3s;
            background: rgba(37, 99, 235, 0.1);
            border: 1px solid rgba(37, 99, 235, 0.2);
        }

        .action-link:hover {
            background: rgb(var(--primary));
            color: rgb(var(--primary-foreground));
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }

        .loading {
            display: inline-block;
            width: 1rem;
            height: 1rem;
            border: 2px solid rgb(var(--border));
            border-radius: 50%;
            border-top-color: rgb(var(--primary));
            animation: spin 1s ease-in-out infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .fade-in {
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* ========== RESPONSIVE ========== */
        @media (max-width: 768px) {
            .header-nav {
                flex-direction: column;
                gap: 1rem;
            }

            .nav-links {
                display: none;
            }

            .container {
                padding: 1rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .form-control.wide {
                grid-column: span 1;
            }

            .table-header {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }

            .action-buttons {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>

    <script>
        /* Theme initialization */
        (function () {
            const saved = localStorage.getItem("theme");
            const prefersDark = window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches;
            if ((saved === "dark") || (!saved && prefersDark)) {
                document.documentElement.classList.add("dark");
            }
        })();
    </script>
</head>
<body>

<!-- ========== ENHANCED HEADER ========== -->
<header class="header">
    <nav class="header-nav">
        <a href="/home" class="logo">
            <div class="logo-icon"></div>
            <span>LMS PRO - CUSTOMER MANAGEMENT</span>
        </a>

        <div class="header-actions">
            <button id="themeBtn" class="theme-toggle" type="button" aria-label="Toggle theme">🌗</button>

            <c:if test="${not empty sessionScope.USER}">
                <div class="user-info">
                    <span>Welcome 👋</span>
                    <span><strong>${sessionScope.USER.username}</strong></span>
                </div>
                <a href="<c:url value='/logout'/>" class="btn btn-danger btn-sm">Logout</a>
                <a href="<c:url value='/home'/>" class="btn btn-primary btn-sm">↩ HOME</a>
            </c:if>

            <c:if test="${empty sessionScope.USER}">
                <a href="<c:url value='/login'/>" class="btn btn-ghost btn-sm">Log in</a>
                <a href="<c:url value='/signup'/>" class="btn btn-primary btn-sm">Sign up</a>
            </c:if>
        </div>
    </nav>
</header>

<!-- ========== MAIN CONTENT ========== -->
<main class="container">
    <c:if test="${not empty msg}">
        <div class="alert success fade-in">
            <svg class="alert-icon" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
            </svg>
                ${msg}
        </div>
    </c:if>

    <!-- Add Customer Form -->
    <div class="form-card fade-in">
        <h2>
            <svg width="24" height="24" fill="currentColor" viewBox="0 0 20 20">
                <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z"/>
                <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1v-5a1 1 0 00-.293-.707l-2-2A1 1 0 0015 7h-1z"/>
            </svg>
            Add New Customer
        </h2>
        <a href="${pageContext.request.contextPath}/signup" class="btn btn-primary">
            <svg width="18" height="18" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd"/>
            </svg>
            Create New Customer
        </a>
    </div>

    <!-- Customers Table -->
    <div class="table-card fade-in">
        <div class="table-header">
            <h2>
                <svg width="24" height="24" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z"/>
                    <path fill-rule="evenodd" d="M4 5a2 2 0 012-2v1a1 1 0 001 1h6a1 1 0 001-1V3a2 2 0 012 2v6a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3z" clip-rule="evenodd"/>
                </svg>
                Customer Directory
            </h2>
            <div class="action-buttons">
                <button class="btn btn-secondary btn-sm" onclick="refreshTable()">
                    <svg width="16" height="16" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M4 2a1 1 0 011 1v2.101a7.002 7.002 0 0111.601 2.566 1 1 0 11-1.885.666A5.002 5.002 0 005.999 7H9a1 1 0 010 2H4a1 1 0 01-1-1V3a1 1 0 011-1zm.008 9.057a1 1 0 011.276.61A5.002 5.002 0 0014.001 13H11a1 1 0 110-2h5a1 1 0 011 1v5a1 1 0 11-2 0v-2.101a7.002 7.002 0 01-11.601-2.566 1 1 0 01.61-1.276z" clip-rule="evenodd"/>
                    </svg>
                    Refresh
                </button>
            </div>
        </div>

        <div class="table-container">
            <table class="table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Contact</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="c" items="${customers}">
                    <tr class="fade-in">
                        <td><strong>#${c.customerId}</strong></td>
                        <td>${c.userAccount.username}</td>
                        <td>${c.firstName} ${c.lastName}</td>
                        <td>${c.email}</td>
                        <td>${c.contactNo}</td>
                        <td>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/customers/edit/${c.customerId}" class="action-link">Edit</a>
                                <a href="${pageContext.request.contextPath}/customers/delete/${c.customerId}"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirmDelete('${c.customerId}');">
                                    Delete
                                </a>

                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty customers}">
                    <tr>
                        <td colspan="6" style="text-align:center;padding:3rem;color:rgb(var(--muted-foreground))">
                            <svg width="64" height="64" fill="currentColor" viewBox="0 0 20 20" style="margin-bottom:1rem;opacity:.5">
                                <path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v2h8v-2zM2 8a2 2 0 11-4 0 2 2 0 014 0zM18 15v2H9v-2a4 4 0 018 0z"/>
                            </svg>
                            <div style="font-size:1.125rem;font-weight:600">No customers found. Create your first customer above!</div>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</main>

<!-- ========== ENHANCED FOOTER ========== -->
<footer class="footer">
    <div class="footer-content">
        <span>&copy; 2025 EcoWash.</span>
        <span class="powered-by">Powered by LMS PRO</span>
    </div>
</footer>

<script>
    // Theme toggle
    document.getElementById('themeBtn')?.addEventListener('click', () => {
        const root = document.documentElement;
        const isDark = root.classList.toggle('dark');
        localStorage.setItem('theme', isDark ? 'dark' : 'light');
    });

    // Confirm delete
    function confirmDelete(id) {
        return confirm(`🗑️ Delete customer #${id}? This cannot be undone.`);
    }

    // Refresh table
    function refreshTable() {
        const btn = event.target.closest('button');
        const orig = btn.innerHTML;
        btn.innerHTML = '<div class="loading"></div> Refreshing...';
        btn.disabled = true;
        setTimeout(() => window.location.reload(), 500);
    }

    // Auto-dismiss alerts
    document.querySelectorAll('.alert').forEach(a => {
        setTimeout(() => {
            a.style.opacity = '0';
            a.style.transform = 'translateY(-10px)';
            setTimeout(() => a.remove(), 300);
        }, 5000);
    });

    // Stagger animations
    document.querySelectorAll('.form-card, .table-card').forEach((c, i) => {
        c.style.animationDelay = `${i * 0.1}s`;
    });

    // Header scroll effect
    window.addEventListener('scroll', () => {
        const header = document.querySelector('.header');
        if (window.scrollY > 100) {
            header.style.background = 'rgba(255, 255, 255, 0.95)';
        } else {
            header.style.background = 'rgb(var(--background))';
        }
    });
</script>

</body>
</html>