<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body{font-family:sans-serif;margin:40px}
        .card{max-width:360px;margin:auto;padding:24px;border:1px solid #ddd;border-radius:12px}
        .error{color:#b00020;margin-bottom:12px}
        input{width:100%;padding:10px;margin:8px 0}
        button{padding:10px 14px;cursor:pointer}
    </style>
</head>
<body>
<div class="card">
    <h2>Sign in</h2>
    <c:if test="${error}">
        <div class="error">Invalid username or password</div>
    </c:if>
    <form method="post" action="${pageContext.request.contextPath}/login">
        <label>Username</label>
        <input name="username" required autofocus />
        <label>Password</label>
        <input name="password" type="password" required />
        <button type="submit">Login</button>
    </form>
</div>
</body>
</html>
