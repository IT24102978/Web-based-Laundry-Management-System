<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoWash - Create Account</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;600;700&family=Open+Sans:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root { --background:#ffffff; --foreground:#4b5563; --card:#f9fafb; --card-foreground:#4b5563; --popover:#ffffff; --popover-foreground:#4b5563; --primary:#0891b2; --primary-foreground:#ffffff; --secondary:#6366f1; --secondary-foreground:#ffffff; --muted:#f9fafb; --muted-foreground:#6b7280; --accent:#6366f1; --accent-foreground:#ffffff; --destructive:#ef4444; --destructive-foreground:#ffffff; --border:#e5e7eb; --input:#ffffff; --ring:#0891b2; --radius:.5rem; }
        .dark { --background:#1f2937; --foreground:#f9fafb; --card:#374151; --card-foreground:#f9fafb; --popover:#1f2937; --popover-foreground:#f9fafb; --primary:#06b6d4; --primary-foreground:#ffffff; --secondary:#6366f1; --secondary-foreground:#ffffff; --muted:#374151; --muted-foreground:#9ca3af; --accent:#6366f1; --accent-foreground:#ffffff; --destructive:#ef4444; --destructive-foreground:#ffffff; --border:#4b5563; --input:#374151; --ring:#06b6d4; }
        body { font-family:'Open Sans',sans-serif; background:linear-gradient(135deg,#f0f9ff 0%,#e0f2fe 100%); min-height:100vh; color:var(--foreground); }
        .heading-font { font-family:'Work Sans',sans-serif; }
        .login-card { background:var(--card); border:1px solid var(--border); border-radius:var(--radius); box-shadow:0 20px 25px -5px rgba(0,0,0,.1),0 10px 10px -5px rgba(0,0,0,.04); color:var(--card-foreground); }
        .input-field { background:var(--input); border:1px solid var(--border); border-radius:var(--radius); transition:.2s; }
        .input-field:focus { outline:none; border-color:var(--ring); box-shadow:0 0 0 3px rgba(8,145,178,.1); }
        .primary-btn { background:var(--primary); color:var(--primary-foreground); border-radius:var(--radius); transition:.2s; }
        .primary-btn:hover { background:#0e7490; transform:translateY(-1px); box-shadow:0 10px 15px -3px rgba(0,0,0,.1); }
        .link-btn { background:transparent; color:var(--primary); border:1px solid var(--border); border-radius:var(--radius); }
        .error-message { background:rgba(239,68,68,.1); color:var(--destructive); border:1px solid rgba(239,68,68,.2); border-radius:var(--radius); }
        .wash-cycle { animation:spin 20s linear infinite; } @keyframes spin { from{transform:rotate(0)} to{transform:rotate(360deg)} }
        .theme-toggle { position:absolute; top:1rem; right:1rem; background:var(--muted); border:1px solid var(--border); border-radius:var(--radius); padding:.5rem; cursor:pointer; }
        @media (max-width: 640px){ .login-card{ margin:1rem; padding:1.25rem; } }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4 relative">
<button class="theme-toggle" onclick="toggleTheme()" title="Toggle Dark Mode">
    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/></svg>
</button>

<div class="login-card w-full max-w-3xl p-10 relative z-10">
    <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-8 gap-4">
        <div class="text-center md:text-left">
            <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-cyan-500 to-blue-600 rounded-full mb-4 wash-cycle">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 9.172V5L8 4z"/>
                </svg>
            </div>
            <h1 class="heading-font text-3xl font-bold mb-1" style="color:var(--foreground)">EcoWash</h1>
            <p class="text-sm" style="color:var(--muted-foreground)">Create your account</p>
        </div>

        <div class="text-center md:text-right">
            <span class="text-sm" style="color:var(--muted-foreground)">Already a member?</span>
            <a href="/login" class="link-btn inline-flex items-center px-3 py-2 ml-2 text-sm font-semibold">
                Log in
            </a>
        </div>
    </div>

    <c:if test="${error}">
        <div class="error-message p-4 mb-6 text-sm font-medium flex items-center">
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 0 0118 0z"/>
            </svg>
            There was an error creating your account. Please try again.
        </div>
    </c:if>

    <form:form method="post" action="/signup" modelAttribute="form" class="space-y-6">

        <!-- NEW: Role + Username (read-only display) -->
        <div>
            <label class="block text-sm font-semibold mb-2" style="color:var(--foreground)">Username</label>
            <input type="text" value="<c:out value='${form.username}'/>" readonly
                   class="input-field w-full px-4 py-3 text-sm bg-gray-50 cursor-not-allowed select-none"/>
            <small class="text-xs" style="color:var(--muted-foreground)">Username is autogenerated!</small>
        </div>

        <!-- Name -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
                <label for="firstName" class="block text-sm font-semibold mb-2" style="color:var(--foreground)">First Name</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg class="h-5 w-5" style="color:var(--muted-foreground)" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                        </svg>
                    </div>
                    <form:input id="firstName" path="firstName" class="input-field w-full pl-10 pr-4 py-3 text-sm" placeholder="Enter your first name"/>
                </div>
            </div>
            <div>
                <label for="lastName" class="block text-sm font-semibold mb-2" style="color:var(--foreground)">Last Name</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg class="h-5 w-5" style="color:var(--muted-foreground)" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                        </svg>
                    </div>
                    <form:input id="lastName" path="lastName" class="input-field w-full pl-10 pr-4 py-3 text-sm" placeholder="Enter your last name"/>
                </div>
            </div>
        </div>

        <!-- Contact -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
                <label for="email" class="block text-sm font-semibold mb-2" style="color:var(--foreground)">Email</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg class="h-5 w-5" style="color:var(--muted-foreground)" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"/>
                        </svg>
                    </div>
                    <form:input id="email" path="email" class="input-field w-full pl-10 pr-4 py-3 text-sm" placeholder="Enter your email"/>
                </div>
            </div>
            <div>
                <label for="contactNo" class="block text-sm font-semibold mb-2" style="color:var(--foreground)">Contact No</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg class="h-5 w-5" style="color:var(--muted-foreground)" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5h12M9 3v2m3-2v2M3 9h12M3 13h12M3 17h12M9 21v-2m3 2v-2"/>
                        </svg>
                    </div>
                    <form:input id="contactNo" path="contactNo" class="input-field w-full pl-10 pr-4 py-3 text-sm" placeholder="Enter your contact number"/>
                </div>
            </div>
        </div>

        <!-- Address -->
        <div>
            <label for="street" class="block text-sm font-semibold mb-2" style="color:var(--foreground)">Street</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <svg class="h-5 w-5" style="color:var(--muted-foreground)" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                    </svg>
                </div>
                <form:input id="street" path="street" class="input-field w-full pl-10 pr-4 py-3 text-sm" placeholder="Enter your street"/>
            </div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
                <label for="city" class="block text-sm font-semibold mb-2" style="color:var(--foreground)">City</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg class="h-5 w-5" style="color:var(--muted-foreground)" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                        </svg>
                    </div>
                    <form:input id="city" path="city" class="input-field w-full pl-10 pr-4 py-3 text-sm" placeholder="Enter your city"/>
                </div>
            </div>
            <div>
                <label for="postalCode" class="block text-sm font-semibold mb-2" style="color:var(--foreground)">Postal Code</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <svg class="h-5 w-5" style="color:var(--muted-foreground)" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                        </svg>
                    </div>
                    <form:input id="postalCode" path="postalCode" class="input-field w-full pl-10 pr-4 py-3 text-sm" placeholder="Enter your postal code"/>
                </div>
            </div>
        </div>

        <!-- Password -->
        <div>
            <label for="password" class="block text-sm font-semibold mb-2" style="color:var(--foreground)">Password</label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <svg class="h-5 w-5" style="color:var(--muted-foreground)" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                    </svg>
                </div>
                <form:password id="password" path="password" class="input-field w-full pl-10 pr-4 py-3 text-sm" placeholder="Enter your password"/>
                <small class="text-xs" style="color:var(--muted-foreground)">Use a strong and unique password!</small>
            </div>
        </div>

        <!-- CTA -->
        <div class="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 sm:justify-end">
            <button type="submit" class="primary-btn py-3 px-5 text-sm font-semibold focus:outline-none focus:ring-2 focus:ring-offset-2" style="focus:ring-color:var(--ring)">
                <span class="flex items-center justify-center">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"/>
                    </svg>
                    Sign up
                </span>
            </button>
            <a href="/login" class="link-btn py-3 px-5 text-sm font-semibold text-center">Already a member? Log in</a>
        </div>
    </form:form>

    <div class="mt-8 text-center">
        <p class="text-xs" style="color:var(--muted-foreground)">© 2025 LMS PRO, All rights reserved.</p>
        <div class="mt-2 flex justify-center space-x-4 text-xs" style="color:var(--muted-foreground)">
            <a href="#" class="transition-colors" style="color:var(--muted-foreground)" onmouseover="this.style.color='var(--primary)'" onmouseout="this.style.color='var(--muted-foreground)'">Privacy Policy</a>
            <span>•</span>
            <a href="#" class="transition-colors" style="color:var(--muted-foreground)" onmouseover="this.style.color='var(--primary)'" onmouseout="this.style.color='var(--muted-foreground)'">Terms of Service</a>
            <span>•</span>
            <a href="#" class="transition-colors" style="color:var(--muted-foreground)" onmouseover="this.style.color='var(--primary)'" onmouseout="this.style.color='var(--muted-foreground)'">Support</a>
        </div>
    </div>
</div>

<script>
    function toggleTheme(){ document.documentElement.classList.toggle('dark');
        localStorage.setItem('theme', document.documentElement.classList.contains('dark') ? 'dark' : 'light'); }
    document.addEventListener('DOMContentLoaded', function(){
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme === 'dark') document.documentElement.classList.add('dark');
    });

    (function(){
        const formEl = document.querySelector('form');
        if(!formEl) return;
        formEl.addEventListener('submit', function(e){
            const requiredIds = ['firstName','lastName','email','contactNo','street','city','postalCode','password'];
            for(const id of requiredIds){
                const el = document.getElementById(id);
                if(!el || !el.value.trim()){
                    e.preventDefault();
                    alert('Please fill in all required fields.');
                    return false;
                }
            }
            const submitBtn = formEl.querySelector('button[type="submit"]');
            if(submitBtn){
                submitBtn.innerHTML = '<span class="flex items-center justify-center"><svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>Creating Account...</span>';
                submitBtn.disabled = true;
            }
        });
    })();
</script>
</body>
</html>
