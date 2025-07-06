<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,com.food.utility.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up - Food Hub</title>
    <link rel="icon" type="image/png" href="images/FoodHubLogo.jpg">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="signup.css">
</head>
<body>

<!-- Header -->
<header class="header">
    <div class="logo-container">
        <img src="images/FoodHubLogo.jpg" alt="Food Hub Logo">
        <span>Food Hub</span>
    </div>
    <nav>
        <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" href="Home">Home</a></li>
        </ul>
    </nav>
</header>

<!-- Signup Form -->
<div class="signup-wrapper">
    <div class="signup-container">
        <h2><i class="fa fa-user-plus"></i> Sign Up</h2>

        <%-- Display error message if signup fails --%>
        <% String errorMessage = (String) request.getAttribute("error"); %>
        <% if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
        <% } %>

        <form action="signup" method="post">
            <div class="mb-3">
                <label for="name" class="form-label"><i class="fa fa-user"></i> Full Name</label>
                <input type="text" id="name" name="name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="username" class="form-label"><i class="fa fa-user"></i> Username</label>
                <input type="text" id="username" name="username" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label"><i class="fa fa-envelope"></i> Email</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label"><i class="fa fa-lock"></i> Password</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="phone" class="form-label"><i class="fa fa-phone"></i> Phone Number</label>
                <input type="text" id="phone" name="phone" class="form-control" required>
            </div>

            <div class="mb-3">
                <label for="address" class="form-label"><i class="fa fa-map-marker-alt"></i> Address</label>
                <textarea id="address" name="address" class="form-control" rows="2" required></textarea>
            </div>

            <button type="submit" class="btn btn-primary btn-signup"><i class="fa fa-user-plus"></i> Join</button>
        </form>

        <div class="text-center mt-3">
            <p>Already have an account? <a href="login.jsp" class="btn btn-login"><i class="fa fa-sign-in-alt"></i> Login</a></p>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    &copy; 2025 <span>Food Hub</span>. All Rights Reserved.
</footer>

<!-- Bootstrap & jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
