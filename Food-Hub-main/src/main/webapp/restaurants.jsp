<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Restaurant" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurants Serving This Dish-Food Hub</title>
    <link rel="icon" type="image/png" href="images/FoodHubLogo.jpg">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="restaurants.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">

</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">🍽️ Food Hub</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="Home">Home</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="container text-center">
        <h1 class="display-4">Find Your Perfect Dish</h1>
        <p class="lead">Explore restaurants serving your favorite meals</p>
    </div>
</section>

<!-- Restaurants List -->
<div class="container mt-5">
    <h2 class="text-center text-light fw-bold">Restaurants Serving This Dish</h2>
    <hr class="mb-4">

    <div class="row justify-content-center">
        <% 
        List<Restaurant> restaurantList = (List<Restaurant>) request.getAttribute("restaurantList");
        if (restaurantList != null && !restaurantList.isEmpty()) {
            for (Restaurant restaurant : restaurantList) { 
        %>
        <div class="col-lg-4 col-md-6 mb-4">
            <div class="restaurant-card">
                <a href="MenuServlet?restaurantId=<%= restaurant.getRestaurantId() %>">
                    <img src="<%= restaurant.getImagePath() %>" alt="<%= restaurant.getName() %>">
                </a>
                <div class="restaurant-info">
                    <h5 class="restaurant-name"><%= restaurant.getName() %></h5>
                    <p class="rating">⭐ <%= restaurant.getRating() %></p>
                    <a href="MenuServlet?restaurantId=<%= restaurant.getRestaurantId() %>" class="btn btn-outline-light">View Menu</a>
                </div>
            </div>
        </div>
        <% 
            } 
        } else { 
        %>
        <p class="text-center text-light">No restaurants found for this dish.</p>
        <% } %>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <p>&copy; 2025 Food Hub | All Rights Reserved</p>
</footer>

<!-- Bootstrap JS and jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
