<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${empty employee.employeeId}">Add Employee</c:when><c:otherwise>Edit Employee</c:otherwise></c:choose> – LMS PRO</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary: #0ea5e9;
            --primary-dark: #0284c7;
            --primary-light: #e0f2fe;
            --secondary: #8b5cf6;
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
            --bg-light: #f8fafc;
            --bg-white: #ffffff;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --border: #e2e8f0;
            --shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        html.dark {
            --bg-light: #0f172a;
            --bg-white: #1e293b;
            --text-primary: #f1f5f9;
            --text-secondary: #cbd5e1;
            --border: #334155;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background-color: var(--bg-light);
            color: var(--text-primary);
            transition: background-color 0.3s ease;
        }

        .header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 1.5rem 2rem;
            box-shadow: var(--shadow-lg);
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .theme-toggle {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            cursor: pointer;
            font-size: 0.875rem;
            transition: all 0.3s ease;
        }

        .theme-toggle:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .form-card {
            background: var(--bg-white);
            border-radius: 1rem;
            box-shadow: var(--shadow-lg);
            padding: 2rem;
            border: 1px solid var(--border);
        }

        .form-header {
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid var(--primary-light);
        }

        .form-header h1 {
            font-size: 1.875rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .form-header p {
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--text-primary);
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--border);
            border-radius: 0.5rem;
            font-size: 1rem;
            background-color: var(--bg-white);
            color: var(--text-primary);
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .form-group input:disabled,
        .form-group input[readonly] {
            background-color: var(--bg-light);
            color: var(--text-secondary);
            cursor: not-allowed;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        @media (max-width: 640px) {
            .form-row {
                grid-template-columns: 1fr;
            }
        }

        .readonly-field {
            background-color: var(--bg-light);
            border: 1px solid var(--border);
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--border);
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 600;
            font-size: 0.875rem;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            box-shadow: 0 4px 12px rgba(14, 165, 233, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(14, 165, 233, 0.4);
        }

        .btn-secondary {
            background: transparent;
            color: var(--text-secondary);
            border: 1px solid var(--border);
        }

        .btn-secondary:hover {
            background: var(--bg-light);
            color: var(--text-primary);
        }

        .footer {
            text-align: center;
            padding: 2rem;
            color: var(--text-secondary);
            font-size: 0.875rem;
            margin-top: 3rem;
        }

        html.dark .header {
            background: linear-gradient(135deg, #0284c7 0%, #7c3aed 100%);
        }
    </style>
</head>
<body>
<!-- Header -->
<div class="header">
    <div class="header-left">
        <div class="logo">LMS PRO</div>
    </div>
    <button class="theme-toggle" onclick="toggleTheme()">🌙 Dark Mode</button>
</div>

<!-- Main Container -->
<div class="container">
    <div class="form-card">
        <!-- Form Header -->
        <div class="form-header">
            <h1>
                <c:choose>
                    <c:when test="${empty employee.employeeId}">Add New Employee</c:when>
                    <c:otherwise>Edit Employee</c:otherwise>
                </c:choose>
            </h1>
            <p>
                <c:choose>
                    <c:when test="${empty employee.employeeId}">Create a new employee record in the system</c:when>
                    <c:otherwise>Update employee information</c:otherwise>
                </c:choose>
            </p>
        </div>

        <!-- Form -->
        <form action="${pageContext.request.contextPath}/employees/save" method="post">
            <input type="hidden" name="employeeId" value="${employee.employeeId}" />

            <!-- Name and Contact Row -->
            <div class="form-row">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" value="${employee.name}" required />
                </div>
                <div class="form-group">
                    <label for="contactNo">Contact Number</label>
                    <input type="text" id="contactNo" name="contactNo" value="${employee.contactNo}" />
                </div>
            </div>

            <!-- Role and Salary Row -->
            <div class="form-row">
                <div class="form-group">
                    <label for="roleTitle">Role / Title</label>
                    <input type="text" id="roleTitle" name="roleTitle" value="${employee.roleTitle}" required />
                </div>
                <div class="form-group">
                    <label for="salary">Salary (LKR)</label>
                    <input type="number" id="salary" name="salary" step="0.01" value="${employee.salary}" />
                </div>
            </div>

            <!-- Hired Date -->
            <div class="form-group">
                <label for="hiredDate">Hired Date</label>
                <input type="date" id="hiredDate" name="hiredDate" value="${employee.hiredDate}" />
            </div>

            <!-- Manager Selection -->
            <div class="form-group">
                <label for="manager">Manager</label>
                <select id="manager" name="manager.employeeId">
                    <option value="">No Manager</option>
                    <c:forEach var="m" items="${managers}">
                        <option value="${m.employeeId}"
                                <c:if test="${employee.manager != null && employee.manager.employeeId == m.employeeId}">selected</c:if>>
                                ${m.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <!-- Linked Account (Display Only) -->
            <c:if test="${employee.userAccount != null}">
                <div class="form-group">
                    <label>Linked User Account</label>
                    <div class="readonly-field">${employee.userAccount.username}</div>
                </div>
            </c:if>

            <!-- Form Actions -->
            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/employees" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary">Save Employee</button>
            </div>
        </form>
    </div>
</div>

<!-- Footer -->
<div class="footer">
    <p>&copy; 2025 LMS PRO. All rights reserved.</p>
</div>

<script>
    // Theme Toggle
    function toggleTheme() {
        const html = document.documentElement;
        const isDark = html.classList.contains('dark');

        if (isDark) {
            html.classList.remove('dark');
            localStorage.setItem('theme', 'light');
            document.querySelector('.theme-toggle').textContent = '🌙 Dark Mode';
        } else {
            html.classList.add('dark');
            localStorage.setItem('theme', 'dark');
            document.querySelector('.theme-toggle').textContent = '☀️ Light Mode';
        }
    }

    // Load theme preference on page load
    window.addEventListener('DOMContentLoaded', function() {
        const theme = localStorage.getItem('theme') || 'light';
        if (theme === 'dark') {
            document.documentElement.classList.add('dark');
            document.querySelector('.theme-toggle').textContent = '☀️ Light Mode';
        }
    });
</script>
</body>
</html>