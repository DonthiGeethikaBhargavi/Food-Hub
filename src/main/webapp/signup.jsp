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
<div class="header d-flex justify-content-between align-items-center px-3">
    <div class="d-flex align-items-center">
        <img src="images/FoodHubLogo.jpg" alt="Food Hub Logo">
        <span class="ms-2">Food Hub</span>
    </div>
    <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="Home">Home</a></li>
    </ul>
</div>

    <!-- Signup Form -->
    <div class="signup-container">
        <h2>
            <img src="https://cdn-icons-png.flaticon.com/128/1046/1046784.png" alt="food icon">
            Welcome to Food Hub
            <img src="https://cdn-icons-png.flaticon.com/128/3595/3595458.png" alt="Pizza" class="header-img">
            <img src="https://cdn-icons-png.flaticon.com/128/3075/3075977.png" alt="Milkshake" class="header-img">
        </h2>
        <form action="signup" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Full Name</label>
                <input type="text" id="name" name="name" class="form-control" placeholder="Enter your full name" required>
            </div>
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" class="form-control" placeholder="Choose a username" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Create a password" required>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">Phone Number</label>
                <input type="text" id="phone" name="phone" class="form-control" placeholder="Enter your phone number" required>
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <textarea id="address" name="address" class="form-control" placeholder="Enter your address" rows="2" required></textarea>
            </div>
            <button type="submit" class="btn btn-signup w-100">Join the Feast</button>
        </form>
        <p class="link-text">Already have an account? <a href="login.jsp" class="btn btn-login">Log In</a></p>
    </div>

    <!-- Footer -->
    <div class="footer">
        &copy; 2025 Food Hub | All Rights Reserved
    </div>

</body>
</html>
