<%@ page import="com.food.model.Order" %>
<%@ page import="com.food.model.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    Order order = (Order) session.getAttribute("order");
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
    String restaurantName = (String) session.getAttribute("restaurantName");

    if (order == null || cartItems == null || restaurantName == null) {
        response.sendRedirect("error.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed - Food Hub</title>
    <link rel="icon" type="image/png" href="images/FoodHubLogo.jpg">
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="orderConfirmation.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
    <div class="confirmation-container">
        <div class="logo">
            <span>Food Hub</span>
            <img src="images/FoodHubLogo.jpg" alt="Food Hub Logo">
        </div>
        <div class="success-icon"><i class="fas fa-check-circle"></i></div>
        <h2 class="mt-3">Order Confirmed!</h2>
        <p>Enjoy your delicious meal from <strong><%= restaurantName %></strong>!</p>

        <div class="food-images">
            <img src="images/pizza.jpg" alt="Pizza">
            <img src="images/burger.jpg" alt="Burger">
            <img src="images/salad.jpg" alt="Salad">
        </div>

        <button class="btn btn-details btn-custom" id="toggleOrderDetails">View Order Details</button>

        <div class="order-summary" id="orderDetails">
            <h3 class="mt-3">Order Summary</h3>
            <p><strong>Order ID:</strong> <%= order.getOrderId() %></p>
            <p><strong>Total Amount:</strong> ₹<%= order.getTotalAmount() %></p>

            <table class="table table-bordered order-items">
                <thead>
                    <tr><th>Item</th><th>Qty</th><th>Price</th><th>Total</th></tr>
                </thead>
                <tbody>
                    <% for (CartItem item : cartItems) { %>
                    <tr>
                        <td><%= item.getName() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>₹<%= item.getPrice() %></td>
                        <td>₹<%= item.getQuantity() * item.getPrice() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <a href="Home" class="btn btn-home btn-custom">Back to Home</a>
    </div>
    <script src="OrderConfirmation.js"></script>
</body>
</html>
