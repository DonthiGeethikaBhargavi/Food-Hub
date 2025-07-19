<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.food.model.OrderHistory, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History - Food Hub</title>
    <link rel="icon" type="image/png" href="images/FoodHubLogo.jpg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #f8f9fc;
            font-family: 'Poppins', sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .header {
            background-color: #ff6b6b;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .logo {
            position: absolute;
            left: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .logo img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: 2px solid white;
            animation: fadeInRotate 1s ease-in-out;
        }
        @keyframes fadeInRotate {
            from {
                opacity: 0;
                transform: rotate(-20deg) scale(0.8);
            }
            to {
                opacity: 1;
                transform: rotate(0deg) scale(1);
            }
        }
        .table-container {
            flex: 1;
            margin: 30px auto;
            width: 90%;
            max-width: 1000px;
            opacity: 0;
            transform: translateY(20px);
            animation: fadeIn 1s ease-out forwards;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .table {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .table-hover tbody tr {
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.5s ease-out, transform 0.5s ease-out;
        }
        .table-hover tbody tr:hover {
            background-color: #ffe5d9;
            transition: 0.3s;
        }
        .table th {
            background-color: #ff6b6b !important;
            color: white;
            font-size: 16px;
            text-transform: uppercase;
        }
        .badge-success {
            background-color: #28a745;
        }
        .badge-cancelled {
            background-color: #e63946;
        }
        .badge-returned {
            background-color: #ffbe0b;
            color: black;
        }
        .empty-message {
            font-size: 18px;
            font-weight: bold;
            color: #6c757d;
        }
        .btn-back {
            display: block;
            width: 220px;
            margin: 20px auto;
            background-color: #ff6b6b;
            color: white;
            font-size: 18px;
            border-radius: 8px;
            transition: 0.3s;
            padding: 10px;
            text-align: center;
            text-decoration: none;
        }
        .btn-back:hover {
            background-color: #d64040;
            color: white;
        }
        .footer {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 15px;
            margin-top: auto;
        }
        @media (max-width: 768px) {
            .table-container {
                width: 95%;
            }
            .logo {
                left: 10px;
            }
            .logo img {
                width: 40px;
                height: 40px;
            }
        }
    </style>

    <script>
        $(document).ready(function () {
            $(".table-hover tbody tr").each(function (index) {
                $(this).delay(200 * index).queue(function (next) {
                    $(this).css({
                        "opacity": "1",
                        "transform": "translateY(0)"
                    });
                    next();
                });
            });
        });
    </script>

</head>
<body>

    <!-- Header -->
    <div class="header">
        <div class="logo">
            <img src="images/FoodHubLogo.jpg" alt="Food Hub Logo">
            <span>Food Hub</span>
        </div>
        <i class="fas fa-history"></i> Order History
    </div>

    <div class="table-container">
        <h2 class="text-center mb-4">
            <i class="fas fa-shopping-basket"></i> Your Orders
        </h2>
        
        <div class="table-responsive">
            <table class="table table-hover text-center">
                <thead>
                    <tr>
                        <th><i class="fas fa-receipt"></i> Order ID</th>
                        <th><i class="fas fa-calendar-alt"></i> Order Date</th>
                        <th><i class="fas fa-store"></i> Restaurant</th>
                        <th><i class="fas fa-utensils"></i> Menu</th>
                        <th><i class="fas fa-wallet"></i> Total Amount</th>
                        <th><i class="fas fa-info-circle"></i> Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    List<OrderHistory> orderHistories = (List<OrderHistory>) request.getAttribute("orderHistories");
                    if (orderHistories != null && !orderHistories.isEmpty()) {
                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
                        for (OrderHistory order : orderHistories) { 
                            String formattedDate = dateFormat.format(order.getOrderDate());
                            String statusClass = "badge-success";
                            String statusIcon = "<i class='fas fa-check-circle'></i> Delivered";
                            
                            if ("Cancelled".equalsIgnoreCase(order.getStatus())) {
                                statusClass = "badge-cancelled";
                                statusIcon = "<i class='fas fa-times-circle'></i> Cancelled";
                            } else if ("Returned".equalsIgnoreCase(order.getStatus())) {
                                statusClass = "badge-returned";
                                statusIcon = "<i class='fas fa-undo-alt'></i> Returned";
                            }
                    %>
                    <tr>
                        <td><%= order.getOrderId() %></td>
                        <td><%= formattedDate %></td>
                        <td><%= order.getRestaurantName() %></td>
                        <td><%= order.getMenuItems() %></td>
                        <td>₹<%= order.getTotalAmount() %></td>
                        <td><span class="badge <%= statusClass %>"><%= statusIcon %></span></td>
                    </tr>
                    <%   }
                    } else { %>
                    <tr>
                        <td colspan="6" class="text-center empty-message">
                            <i class="fas fa-exclamation-circle"></i> No orders found.
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <a href="Home" class="btn btn-back">
            <i class="fas fa-arrow-left"></i> Back to Home
        </a>
    </div>

    <div class="footer">
        <p>&copy; 2025 Food Hub. All Rights Reserved.</p>
    </div>

</body>
</html>
