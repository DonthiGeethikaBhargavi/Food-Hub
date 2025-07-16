<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Menu, com.food.model.Restaurant" %>
<%@ page import="com.food.daoImpl.MenuDAOImpl, com.food.daoImpl.RestaurantDAOImpl" %>
<%@ page import="com.food.model.User" %>
<%
    // Fetching username from session
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = user.getUsername(); 
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Food Hub</title>
    <link rel="icon" type="image/png" href="images/FoodHubLogo.jpg">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="styles.css">
    <link rel="stylesheet" type="text/css" href="home.css">
</head>
<body>

<!-- Header -->
<header class="fixed-top bg-white shadow-sm">
    <div class="container d-flex flex-wrap justify-content-between align-items-center py-3">
        <div class="logo-container">
            <img src="images/FoodHubLogo.jpg" class="logo" alt="Food Hub Logo">
            <h1 class="logo-text">Food Hub</h1>
        </div>
        
        
        <nav class="navbar navbar-expand-lg">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link text-dark fw-semibold" href="#menu">Menu</a></li>
                    <li class="nav-item"><a class="nav-link text-dark fw-semibold" href="#restaurants">Restaurants</a></li>
                    <li class="nav-item"><a class="nav-link text-dark fw-semibold" href="cart.jsp"><i class="fas fa-shopping-cart"></i> View Cart</a></li>
                    <li class="nav-item"><a class="nav-link text-dark fw-semibold" href="OrderHistoryServlet"><i class="fas fa-history"></i> Order History</a></li>
                    <li class="nav-item"><a class="btn btn-outline-danger btn-sm logout-btn" href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Log Out</a></li>
                </ul>
            </div>
        </nav>
    </div>
</header>

<!-- Spacer to prevent header overlap -->
<div class="header-spacing"></div>

<!-- Welcome Section -->
<div class="welcome-box">
    <h2>Hi, <%= username %>! 👋</h2>
    <p>Welcome to <img src="images/FoodHubLogo.jpg" alt="Food Hub Logo" class="welcome-logo"> Food Hub, your go-to destination for delicious food!</p>
    <div class="welcome-icons">
        <img src="https://cdn-icons-png.flaticon.com/128/3595/3595458.png" alt="Food Icon">
        <img src="https://cdn-icons-png.flaticon.com/128/1046/1046786.png" alt="Pizza Icon">
        <img src="https://cdn-icons-png.flaticon.com/128/7451/7451569.png" alt="Orange Juice Icon">
        <img src="https://cdn-icons-png.flaticon.com/128/2718/2718224.png" alt="Burger Icon">
        <img src="https://cdn-icons-png.flaticon.com/128/924/924514.png" alt="Coffee Icon">
         <img src="https://cdn-icons-png.flaticon.com/128/1046/1046784.png" alt="food icon">    
    </div>
</div>

<!-- Menu Section -->
<section id="menu" class="container my-5 section-spacing">
    <h2 class="text-center text-primary fw-bold">Menu</h2>
    <div class="row justify-content-center">
        <% List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
           if (menuList != null && !menuList.isEmpty()) {
               for (Menu menu : menuList) { %>
                   <div class="col-lg-3 col-md-4 col-sm-6 p-3">
                       <div class="card shadow-sm text-center hover-effect">
                           <a href="RestaurantServlet?menuId=<%= menu.getMenuId() %>">
                               <img class="fixed-menu-img card-img-top" src="<%= menu.getImagePath() %>" alt="<%= menu.getItemName() %>">
                           </a>
                           <div class="card-body">
                               <p class="fw-semibold"><%= menu.getItemName() %></p>
                           </div>
                       </div>
                   </div>
        <%     }
           } else { %>
           <p class="text-center text-muted">No menu items available.</p>
        <% } %>
    </div>
</section>

<!-- Restaurants Section -->
<section id="restaurants" class="container my-5 section-spacing">
    <h2 class="text-center text-primary fw-bold">Restaurants</h2>
    <div class="row justify-content-center">
        <% List<Restaurant> restaurantList = (List<Restaurant>) request.getAttribute("restaurantList");
           if (restaurantList != null && !restaurantList.isEmpty()) {
               for (Restaurant restaurant : restaurantList) { %>
                   <div class="col-lg-4 col-md-6 col-sm-12 p-3">
                       <div class="card shadow-sm text-center hover-effect">
                           <a href="MenuServlet?restaurantId=<%= restaurant.getRestaurantId() %>">
                               <img class="fixed-restaurant-img card-img-top" src="<%= restaurant.getImagePath() %>" alt="<%= restaurant.getName() %>">
                           </a>
                           <div class="card-body">
                               <p class="fw-bold text-dark"><%= restaurant.getName() %> ⭐ <%= restaurant.getRating() %></p>
                               <p class="text-muted"><%= restaurant.getCuisineType() %></p>
                           </div>
                       </div>
                   </div>
        <%     }
           } else { %>
           <p class="text-center text-muted">No restaurants available.</p>
        <% } %>
    </div>
</section>

<!-- Footer -->
<footer class="footer-section bg-dark text-white text-center py-4">
    <div class="container">
        <p>&copy; 2025 Food Hub | <a href="#" class="text-light">Contact Us</a> | <a href="#" class="text-light">Privacy Policy</a> | <a href="#" class="text-light">Terms of Service</a></p>
    </div>
</footer>

<!-- Bootstrap JS & jQuery -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</body>
</html>

