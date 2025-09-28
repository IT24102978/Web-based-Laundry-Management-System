<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoWash - Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;600;700&family=Open+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --background: #ffffff;
            --foreground: #4b5563;
            --card: #f9fafb;
            --card-foreground: #4b5563;
            --popover: #ffffff;
            --popover-foreground: #4b5563;
            --primary: #0891b2;
            --primary-foreground: #ffffff;
            --secondary: #6366f1;
            --secondary-foreground: #ffffff;
            --muted: #f9fafb;
            --muted-foreground: #6b7280;
            --accent: #6366f1;
            --accent-foreground: #ffffff;
            --destructive: #ef4444;
            --destructive-foreground: #ffffff;
            --border: #e5e7eb;
            --input: #ffffff;
            --ring: #0891b2;
            --radius: 0.5rem;
            --sidebar: #ffffff;
            --sidebar-foreground: #4b5563;
            --sidebar-primary: #f9fafb;
            --sidebar-primary-foreground: #4b5563;
            --sidebar-accent: #6366f1;
            --sidebar-accent-foreground: #ffffff;
            --sidebar-border: #e5e7eb;
            --sidebar-ring: #0891b2;
        }

        .dark {
            --background: #1f2937;
            --foreground: #f9fafb;
            --card: #374151;
            --card-foreground: #f9fafb;
            --popover: #1f2937;
            --popover-foreground: #f9fafb;
            --primary: #06b6d4;
            --primary-foreground: #ffffff;
            --secondary: #6366f1;
            --secondary-foreground: #ffffff;
            --muted: #374151;
            --muted-foreground: #9ca3af;
            --accent: #6366f1;
            --accent-foreground: #ffffff;
            --destructive: #ef4444;
            --destructive-foreground: #ffffff;
            --border: #4b5563;
            --input: #374151;
            --ring: #06b6d4;
            --sidebar: #1f2937;
            --sidebar-foreground: #f9fafb;
            --sidebar-primary: #374151;
            --sidebar-primary-foreground: #f9fafb;
            --sidebar-accent: #6366f1;
            --sidebar-accent-foreground: #ffffff;
            --sidebar-border: #4b5563;
            --sidebar-ring: #06b6d4;
        }

        body {
            font-family: 'Open Sans', sans-serif;
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            min-height: 100vh;
            background-color: var(--background);
            color: var(--foreground);
        }

        .heading-font {
            font-family: 'Work Sans', sans-serif;
        }

        .login-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            color: var(--card-foreground);
        }

        .input-field {
            background: var(--input);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            color: var(--foreground);
            transition: all 0.2s ease-in-out;
        }

        .input-field:focus {
            outline: none;
            border-color: var(--ring);
            box-shadow: 0 0 0 3px rgba(8, 145, 178, 0.1);
        }

        .primary-btn {
            background: var(--primary);
            color: var(--primary-foreground);
            border-radius: var(--radius);
            transition: all 0.2s ease-in-out;
        }

        .primary-btn:hover {
            background: #0e7490;
            transform: translateY(-1px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }

        .error-message {
            background: rgba(239, 68, 68, 0.1);
            color: var(--destructive);
            border: 1px solid rgba(239, 68, 68, 0.2);
            border-radius: var(--radius);
        }

        .laundry-icon {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .floating-bubbles {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            pointer-events: none;
        }

        .bubble {
            position: absolute;
            background: rgba(8, 145, 178, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .bubble:nth-child(1) { left: 10%; width: 80px; height: 80px; animation-delay: 0s; }
        .bubble:nth-child(2) { left: 20%; width: 120px; height: 120px; animation-delay: 2s; }
        .bubble:nth-child(3) { left: 35%; width: 60px; height: 60px; animation-delay: 4s; }
        .bubble:nth-child(4) { left: 50%; width: 100px; height: 100px; animation-delay: 1s; }
        .bubble:nth-child(5) { left: 70%; width: 90px; height: 90px; animation-delay: 3s; }
        .bubble:nth-child(6) { left: 85%; width: 70px; height: 70px; animation-delay: 5s; }

        @keyframes float {
            0%, 100% { transform: translateY(100vh) rotate(0deg); opacity: 0; }
            10%, 90% { opacity: 1; }
            50% { transform: translateY(-100px) rotate(180deg); }
        }

        .wash-cycle {
            animation: spin 20s linear infinite;
        }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .theme-toggle {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: var(--muted);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 0.5rem;
            cursor: pointer;
            transition: all 0.2s ease-in-out;
        }

        .theme-toggle:hover {
            background: var(--accent);
            color: var(--accent-foreground);
        }

        @media (max-width: 640px) {
            .login-card {
                margin: 1rem;
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4 relative">
<button class="theme-toggle" onclick="toggleTheme()" title="Toggle Dark Mode">
    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/>
    </svg>
</button>

<div class="floating-bubbles">
    <div class="bubble"></div>
    <div class="bubble"></div>
    <div class="bubble"></div>
    <div class="bubble"></div>
    <div class="bubble"></div>
    <div class="bubble"></div>
</div>

<div class="login-card w-full max-w-md p-8 relative z-10">
    <div class="text-center mb-8">
        <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-cyan-500 to-blue-600 rounded-full mb-4 wash-cycle">
            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 9.172V5L8 4z"/>
            </svg>
        </div>
        <h1 class="heading-font text-3xl font-bold mb-2" style="color: var(--foreground)">EcoWash</h1>
        <p class="text-sm" style="color: var(--muted-foreground)">Powered by LMS PRO</p>
    </div>

    <c:if test="${error}">
        <div class="error-message p-4 mb-6 text-sm font-medium flex items-center">
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 0 0118 0z"/>
            </svg>
            Invalid username or password. Please try again.
        </div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/login" class="space-y-6">
        <div>
            <label for="username" class="block text-sm font-semibold mb-2" style="color: var(--foreground)">
                Username
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <svg class="h-5 w-5" style="color: var(--muted-foreground)" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                </div>
                <input
                        id="username"
                        name="username"
                        type="text"
                        required
                        autofocus
                        class="input-field w-full pl-10 pr-4 py-3 text-sm"
                        placeholder="Enter your username"
                />
            </div>
        </div>

        <div>
            <label for="password" class="block text-sm font-semibold mb-2" style="color: var(--foreground)">
                Password
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <svg class="h-5 w-5" style="color: var(--muted-foreground)" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                    </svg>
                </div>
                <input
                        id="password"
                        name="password"
                        type="password"
                        required
                        class="input-field w-full pl-10 pr-4 py-3 text-sm"
                        placeholder="Enter your password"
                />
            </div>
        </div>

        <div class="flex items-center justify-between">
            <div class="flex items-center">
                <input
                        id="remember-me"
                        name="remember-me"
                        type="checkbox"
                        class="h-4 w-4 text-cyan-600 focus:ring-cyan-500 border-gray-300 rounded"
                />
                <label for="remember-me" class="ml-2 block text-sm" style="color: var(--foreground)">
                    Remember me
                </label>
            </div>
            <div class="text-sm">
                <a href="#" class="font-medium transition-colors" style="color: var(--primary)" onmouseover="this.style.color='var(--secondary)'" onmouseout="this.style.color='var(--primary)'">
                    Forgot password?
                </a>
            </div>
        </div>

        <button
                type="submit"
                class="primary-btn w-full py-3 px-4 text-sm font-semibold focus:outline-none focus:ring-2 focus:ring-offset-2"
                style="focus:ring-color: var(--ring)"
        >
                <span class="flex items-center justify-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 16l-4-4m0 0l4-4m-4 4h14m-5 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h7a3 3 0 013 3v1"/>
                    </svg>
                    Login to EcoWash
                </span>
        </button>

        <a href="${pageContext.request.contextPath}/signup"
           class="primary-btn w-full py-3 px-4 text-sm font-semibold focus:outline-none focus:ring-2 focus:ring-offset-2 block text-center"
           style="focus:ring-color: var(--ring)">
    <span class="flex items-center justify-center">
        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M12 4v16m8-8H4"/>
        </svg>
        Not a member? Sign up
    </span>
        </a>
    </form>

    <div class="mt-8 text-center">
        <p class="text-xs" style="color: var(--muted-foreground)">
            © 2025 EcoWash / LMS PRO. All rights reserved.
        </p>
        <div class="mt-2 flex justify-center space-x-4 text-xs" style="color: var(--muted-foreground)">
            <a href="#" class="transition-colors" style="color: var(--muted-foreground)" onmouseover="this.style.color='var(--primary)'" onmouseout="this.style.color='var(--muted-foreground)'">Privacy Policy</a>
            <span>•</span>
            <a href="#" class="transition-colors" style="color: var(--muted-foreground)" onmouseover="this.style.color='var(--primary)'" onmouseout="this.style.color='var(--muted-foreground)'">Terms of Service</a>
            <span>•</span>
            <a href="#" class="transition-colors" style="color: var(--muted-foreground)" onmouseover="this.style.color='var(--primary)'" onmouseout="this.style.color='var(--muted-foreground)'">Support</a>
        </div>
    </div>
</div>

<script>
    function toggleTheme() {
        document.documentElement.classList.toggle('dark');
        localStorage.setItem('theme', document.documentElement.classList.contains('dark') ? 'dark' : 'light');
    }

    document.addEventListener('DOMContentLoaded', function() {
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme === 'dark') {
            document.documentElement.classList.add('dark');
        }
    });

    document.querySelector('form').addEventListener('submit', function(e) {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value.trim();

        if (!username || !password) {
            e.preventDefault();
            alert('Please fill in all required fields.');
            return false;
        }

        const submitBtn = this.querySelector('button[type="submit"]');
        submitBtn.innerHTML = '<span class="flex items-center justify-center"><svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>Signing In...</span>';
        submitBtn.disabled = true;
    });
</script>
</body>
</html>
