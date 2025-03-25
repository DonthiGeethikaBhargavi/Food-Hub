<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Food Hub</title>
    <link rel="icon" type="image/png" href="images/FoodHubLogo.jpg">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Font for Food Hub -->
    <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="login.css">
</head>
<body>

<!-- Header -->
<div class="header d-flex justify-content-between align-items-center px-3">
    <div class="d-flex align-items-center">
        <img src="images/FoodHubLogo.jpg" alt="Food Hub Logo">
        <span class="ms-2">Food Hub</span>
    </div>
    <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="Home">Home</a></li>
    </ul>
</div>



<!-- Login Form -->
<div class="login-container">
    <h2><i class="fa fa-user-circle"></i> Login</h2>

    <%-- Display error message if login fails --%>
    <% String errorMessage = (String) request.getAttribute("error"); %>
    <% if (errorMessage != null) { %>
        <div class="alert alert-danger"><%= errorMessage %></div>
    <% } %>

    <form action="LoginServlet" method="post">
        <div class="mb-3">
            <label for="username" class="form-label"><i class="fa fa-user"></i> Username</label>
            <input type="text" id="username" name="username" class="form-control" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label"><i class="fa fa-lock"></i> Password</label>
            <input type="password" id="password" name="password" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary btn-login"><i class="fa fa-sign-in-alt"></i> Login</button>
    </form>

    <div class="text-center mt-3">
        <p>Don't have an account? <a href="signup.jsp" class="btn btn-signup">Signup</a></p>
    </div>
</div>

<!-- Footer -->
<div class="footer">
    &copy; 2025 <span>Food Hub</span>. All Rights Reserved.
</div>

<!-- Bootstrap & jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
