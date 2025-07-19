<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.food.model.Menu, com.food.model.Restaurant, com.food.model.Cart" %>

<%
    Restaurant restaurant = (Restaurant) session.getAttribute("restaurant");
    List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
    Cart cart = (Cart) session.getAttribute("cart"); // Fetch the cart object

    if (restaurant == null) {
        response.sendRedirect("Home");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= restaurant.getName() %> - Menu(Food Hub)</title>
    <link rel="icon" type="image/png" href="images/FoodHubLogo.jpg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="menu.css">
</head>
<body>
<jsp:include page="header.jsp" />
<div class="container mt-4">
    <h2 class="text-center text-success fw-bold">🍽️ Menu for <%= restaurant.getName() %></h2>

    <div class="menu-list">
        <% if (menuList != null && !menuList.isEmpty()) { %>
            <% for (Menu menu : menuList) { %>
                <div class="menu-item d-flex align-items-center">
                    <img src="<%= menu.getImagePath() %>" alt="Food Image">

                    <div class="menu-details">
                        <h4 class="text-primary fw-bold"><%= menu.getItemName() %></h4>
                        <p class="text-muted"><%= menu.getDescription() %></p>
                        <p class="fw-bold text-danger price">₹<%= menu.getPrice() %></p>

                        <form action="CartServlet" method="post" class="d-flex align-items-center">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="menuId" value="<%= menu.getMenuId() %>">
                            <input type="hidden" name="restaurantId" value="<%= restaurant.getRestaurantId() %>">
                            <input type="number" name="quantity" class="form-controlform-control-sm quantity " min="1" value="1">
                            <button type="submit" class="btn btn-success ms-2">
                                <i class="fas fa-cart-plus"></i> Add to Cart
                            </button>
                        </form>
                    </div>
                </div>
            <% } %>
        <% } else { %>
            <p class="text-center text-danger">No menu items available.</p>
        <% } %>
    </div>
</div>

<!-- View Cart Button -->
<% if (cart != null && !cart.getItems().isEmpty()) { %>
    <a href="cart.jsp" id="view-cart" class="btn btn-warning view-cart"><i class="fas fa-shopping-cart"></i> View Cart</a>
<% } %>
 <jsp:include page="footer.jsp" />
<script src="menu.js"></script>
</body>
</html>