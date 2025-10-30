<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>EcoWash - Eco-Friendly Laundry Service</title>

    <!-- Tailwind via CDN (no build step) -->
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        /* =========
           LIGHT THEME (from your first block, RGB triplets)
           ========= */
        :root {
            --background: 255 255 255;
            --foreground: 15 23 42;
            --primary: 59 130 246;
            --primary-foreground: 255 255 255;
            --secondary: 241 245 249;
            --muted: 248 250 252;
            --muted-foreground: 100 116 139;
            --accent: 219 234 254;
            --border: 226 232 240;
            --radius: 0.5rem;
        }

        /* =========
           DARK THEME (adapted from your OKLCH palette to RGB fallbacks for this page)
           Toggle with <html class="dark"> or button below.
           ========= */
        .dark {
            /* keep names consistent with the layout using rgb(var(--token)) */
            --background: 23 23 28;        /* approx oklch dark background */
            --foreground: 245 247 250;     /* light foreground */
            --primary: 245 247 250;        /* bright primary on dark */
            --primary-foreground: 33 37 41;
            --secondary: 46 52 64;
            --muted: 46 52 64;
            --muted-foreground: 173 181 189;
            --accent: 46 52 64;
            --border: 46 52 64;
        }

        /* -------- Base reset -------- */
        * { margin:0; padding:0; box-sizing:border-box; }

        body {
            font-family: system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, "Apple Color Emoji", "Segoe UI Emoji", sans-serif;
            background: rgb(var(--background));
            color: rgb(var(--foreground));
            line-height: 1.6;
        }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 1rem; }

        /* -------- Header -------- */
        .header {
            background: rgb(var(--background));
            border-bottom: 1px solid rgb(var(--border));
            position: sticky; top: 0; z-index: 50;
            backdrop-filter: blur(8px);
        }
        .nav { display:flex; align-items:center; justify-content:space-between; padding: 1rem 0; }
        .logo { display:flex; align-items:center; gap:.5rem; font-size:1.5rem; font-weight:700; color: rgb(var(--primary)); text-decoration:none; }
        .logo-icon { width:32px; height:32px; background: rgb(var(--primary)); border-radius:8px; display:flex; align-items:center; justify-content:center; color:white; font-weight:bold; }
        .nav-links { display:flex; align-items:center; gap:2rem; }
        .nav-link { color: rgb(var(--muted-foreground)); text-decoration:none; font-weight:500; transition: color .2s; }
        .nav-link:hover { color: rgb(var(--foreground)); }
        .auth-buttons { display:flex; align-items:center; gap:1rem; }

        .btn {
            padding: .5rem 1rem; border-radius: var(--radius); font-weight:500; text-decoration:none;
            transition: all .2s; cursor:pointer; border:none; font-size:.875rem;
        }
        .btn-ghost { background: transparent; color: rgb(var(--foreground)); }
        .btn-ghost:hover { background: rgb(var(--accent)); }
        .btn-primary { background: rgb(var(--primary)); color: rgb(var(--primary-foreground)); }
        .btn-primary:hover { background: rgb(37 99 235); transform: translateY(-1px); }
        .btn-outline { background:transparent; color: rgb(var(--primary)); border:2px solid rgb(var(--primary)); }
        .btn-outline:hover { background: rgb(var(--primary)); color: rgb(var(--primary-foreground)); }
        .btn-large { padding: .875rem 2rem; font-size:1rem; }

        /* Theme toggle pill */
        .theme-toggle {
            border: 1px solid rgb(var(--border));
            background: rgb(var(--secondary));
            color: rgb(var(--foreground));
            border-radius: 9999px;
        }
        .theme-toggle:hover { background: rgb(var(--accent)); }

        /* -------- Hero -------- */
        .hero { padding: 4rem 0 6rem; text-align:center; }
        .hero-content { max-width: 800px; margin: 0 auto; }
        .hero-title { font-size: clamp(2.5rem, 5vw, 4rem); font-weight:700; line-height:1.1; margin-bottom:1.5rem; color: rgb(var(--foreground)); }
        .hero-subtitle { font-size: 1.25rem; color: rgb(var(--muted-foreground)); margin-bottom:2rem; line-height:1.6; }
        .hero-buttons { display:flex; gap:1rem; justify-content:center; flex-wrap:wrap; margin-bottom:3rem; }

        .hero-visual {
            background: rgb(var(--primary));
            border-radius: 1rem;
            padding: 2rem; margin: 0 auto; max-width: 500px; position: relative; overflow: hidden;
        }
        .visual-card {
            background: white; border-radius: .75rem; padding: 1.5rem;
            box-shadow: 0 10px 25px rgba(0,0,0,.1); position: relative;
        }
        .dark .visual-card { background: rgb(33 37 41); color: rgb(var(--foreground)); }
        .visual-header { display:flex; align-items:center; justify-content:space-between; margin-bottom:1rem; }
        .visual-title { font-weight:600; color: rgb(var(--foreground)); }
        .status-badge { background: rgb(34 197 94); color:white; padding:.25rem .75rem; border-radius:9999px; font-size:.75rem; font-weight:500; }
        .progress-bar { background: rgb(var(--secondary)); height:8px; border-radius:4px; overflow:hidden; margin: 1rem 0; }
        .progress-fill { background: rgb(var(--primary)); height:100%; width:75%; border-radius:4px; animation: progress 2s ease-in-out infinite alternate; }

        @keyframes progress { 0% { width:60%; } 100% { width:85%; } }

        .stats { display:grid; grid-template-columns: repeat(3, 1fr); gap:1rem; margin-top:1rem; }
        .stat { text-align:center; }
        .stat-number { font-size:1.25rem; font-weight:700; color: rgb(var(--primary)); }
        .stat-label { font-size:.75rem; color: rgb(var(--muted-foreground)); }

        /* -------- Features -------- */
        .features { padding: 4rem 0; background: rgb(var(--muted)); }
        .dark .features { background: rgb(28 31 38); }
        .features-grid { display:grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap:2rem; margin-top:3rem; }
        .feature-card {
            background: white; padding:2rem; border-radius: calc(var(--radius) * 2);
            box-shadow: 0 4px 6px rgba(0,0,0,.05); transition: transform .2s, box-shadow .2s;
        }
        .dark .feature-card { background: rgb(33 37 41); color: rgb(var(--foreground)); }
        .feature-card:hover { transform: translateY(-4px); box-shadow: 0 10px 25px rgba(0,0,0,.1); }
        .feature-icon {
            width:48px; height:48px; background: rgb(var(--accent)); border-radius: var(--radius);
            display:flex; align-items:center; justify-content:center; margin-bottom:1rem; color: rgb(var(--primary)); font-size:1.5rem;
        }
        .feature-title { font-size:1.25rem; font-weight:600; margin-bottom:.5rem; }
        .feature-description { color: rgb(var(--muted-foreground)); line-height:1.6; }

        /* -------- Footer -------- */
        .footer { background: rgb(var(--foreground)); color:white; padding:2rem 0; text-align:center; }
        .dark .footer { background: rgb(20 22 26); }
        .footer-content { display:flex; align-items:center; justify-content:center; gap:.5rem; font-size:.875rem; }
        .powered-by { opacity:.7; }

        /* -------- Responsive -------- */
        @media (max-width: 768px) {
            .nav-links { display:none; }
            .hero-buttons { flex-direction:column; align-items:center; }
            .btn-large { width:100%; max-width:300px; }
        }
    </style>

    <script>
        /* Prefer system theme on first load */
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
<!-- Header -->
<header class="header">
    <div class="container">
        <nav class="nav">
            <a href="#" class="logo">
                <div class="logo-icon">E</div>
                EcoWash
            </a>

            <div class="nav-links">
                <a href="#services" class="nav-link">Services</a>
                <a href="#pricing" class="nav-link">Pricing</a>
                <a href="#about" class="nav-link">About</a>
                <a href="#contact" class="nav-link">Contact</a>
            </div>

            <div class="auth-buttons">
                <button id="themeBtn" class="btn theme-toggle" type="button" aria-label="Toggle theme">🌗</button>
                <a href="login" class="btn btn-ghost">Log in</a>
                <a href="signup" class="btn btn-primary">Sign up</a>
            </div>
        </nav>
    </div>
</header>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <div class="hero-content">
            <h1 class="hero-title">Fresh, clean laundry with zero environmental impact</h1>
            <p class="hero-subtitle">
                Experience premium laundry service that's gentle on your clothes and kind to the planet.
                Book pickup and delivery with forms designed to be refreshingly simple.
            </p>

            <div class="hero-buttons">
                <a href="/signup" class="btn btn-primary btn-large">Get started—it's free</a>
                <a href="#services" class="btn btn-outline btn-large">View services</a>
            </div>

            <div class="hero-visual">
                <div class="visual-card">
                    <div class="visual-header">
                        <span class="visual-title">Your Order Status</span>
                        <span class="status-badge">In Progress</span>
                    </div>
                    <div class="progress-bar">
                        <div class="progress-fill"></div>
                    </div>
                    <div class="stats">
                        <div class="stat">
                            <div class="stat-number">24h</div>
                            <div class="stat-label">Turnaround</div>
                        </div>
                        <div class="stat">
                            <div class="stat-number">100%</div>
                            <div class="stat-label">Eco-Friendly</div>
                        </div>
                        <div class="stat">
                            <div class="stat-number">5★</div>
                            <div class="stat-label">Rating</div>
                        </div>
                    </div>
                </div>
            </div>

        </div> <!-- /hero-content -->
    </div>
</section>

<!-- Features Section -->
<section id="services" class="features">
    <div class="container">
        <div style="text-align:center; margin-bottom:2rem;">
            <h2 style="font-size:2.5rem; font-weight:700; margin-bottom:1rem;">Why choose EcoWash?</h2>
            <p style="font-size:1.125rem; color: rgb(var(--muted-foreground)); max-width:600px; margin:0 auto;">
                We combine cutting-edge eco-friendly technology with premium care to deliver exceptional results.
            </p>
        </div>

        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">🌱</div>
                <h3 class="feature-title">100% Eco-Friendly</h3>
                <p class="feature-description">Biodegradable detergents, energy-efficient machines, and sustainable practices that protect our planet.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🚚</div>
                <h3 class="feature-title">Free Pickup & Delivery</h3>
                <p class="feature-description">Schedule convenient pickup and delivery times that work with your busy lifestyle. No extra fees.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">⚡</div>
                <h3 class="feature-title">24-Hour Service</h3>
                <p class="feature-description">Fast turnaround without compromising quality. Your clothes cleaned and returned within 24 hours.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">👕</div>
                <h3 class="feature-title">Premium Care</h3>
                <p class="feature-description">Specialized treatment for delicate fabrics, stain removal expertise, and gentle handling of all garments.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📱</div>
                <h3 class="feature-title">Smart Tracking</h3>
                <p class="feature-description">Real-time updates on your order status, from pickup to delivery. Stay informed every step of the way.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">💰</div>
                <h3 class="feature-title">Transparent Pricing</h3>
                <p class="feature-description">No hidden fees, no surprises. Clear, upfront pricing with flexible subscription options available.</p>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="footer-content">
            <span>&copy; 2025 EcoWash.</span>
            <span class="powered-by">Powered by LMS PRO</span>
        </div>
    </div>
</footer>

<script>
    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const href = this.getAttribute('href');
            if (!href || href === '#') return;
            e.preventDefault();
            const target = document.querySelector(href);
            if (target) target.scrollIntoView({ behavior: 'smooth', block: 'start' });
        });
    });

    // Add scroll effect to header
    window.addEventListener('scroll', () => {
        const header = document.querySelector('.header');
        header.style.background = (window.scrollY > 100)
            ? 'rgba(255, 255, 255, 0.95)'
            : 'rgb(var(--background))';
    });

    // Animate stats on scroll
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) entry.target.style.animation = 'progress 2s ease-in-out infinite alternate';
        });
    }, { threshold: 0.5, rootMargin: '0px 0px -100px 0px' });

    document.querySelectorAll('.progress-fill').forEach(el => observer.observe(el));

    // Theme toggle
    document.getElementById('themeBtn')?.addEventListener('click', () => {
        const root = document.documentElement;
        const isDark = root.classList.toggle('dark');
        localStorage.setItem('theme', isDark ? 'dark' : 'light');
    });
</script>
</body>
</html>
