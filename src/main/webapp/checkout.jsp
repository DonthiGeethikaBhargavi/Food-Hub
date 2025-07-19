<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.food.model.CartItem" %>
<%@ page import="com.food.model.User" %>

<%
    HttpSession sessionObj = request.getSession();
    User user = (User) sessionObj.getAttribute("user");
    Double grandTotal = (Double) sessionObj.getAttribute("grandTotal");
    if (grandTotal == null) {
        grandTotal = 0.0;
    }
    Map<Integer, CartItem> cartItems = (Map<Integer, CartItem>) sessionObj.getAttribute("cartItems");

    Boolean notLoggedIn = (Boolean) sessionObj.getAttribute("notLoggedIn");
    if (notLoggedIn == null) {
        notLoggedIn = false;
    } else {
        sessionObj.removeAttribute("notLoggedIn"); // Remove attribute after checking
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Checkout - Food Hub</title>
    <link rel="icon" type="image/png" href="images/FoodHubLogo.jpg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
<jsp:include page="header.jsp" />
    <div class="container mt-5">
        <h2 class="text-center mb-4">Checkout</h2>

        <div class="row">
            <!-- Order Summary -->
            <div class="col-md-6">
                <div class="card shadow-lg">
                    <div class="card-body">
                        <h4 class="card-title text-center">Order Summary</h4>
                        <table class="table table-bordered">
                            <thead class="table-dark">
                                <tr>
                                    <th>Item Name</th>
                                    <th>Quantity</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (cartItems != null && !cartItems.isEmpty()) {
                                        for (CartItem item : cartItems.values()) {
                                %>
                                <tr>
                                    <td><%= item.getName() %></td>
                                    <td><%= item.getQuantity() %></td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="2" class="text-center text-danger">No items in cart</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                        <h5 class="text-end">Total: ₹<span class="text-success fw-bold"><%= grandTotal %></span></h5>
                    </div>
                </div>
            </div>

            <!-- Delivery Details Form -->
            <div class="col-md-6">
                <div class="card shadow-lg">
                    <div class="card-body">
                        <h4 class="card-title text-center">Delivery Details</h4>
                        <form id="checkout-form" action="OrderConfirmationServlet" method="POST">
                            
                            <div class="mb-3">
                                <label for="name" class="form-label">Full Name:</label>
                                <input type="text" id="name" name="name" class="form-control" placeholder="Enter your full name" required>
                            </div>

                            <div class="mb-3">
                                <label for="address" class="form-label">Delivery Address:</label>
                                <textarea id="address" name="address" class="form-control" placeholder="Enter your delivery address" required></textarea>
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone Number:</label>
                                <input type="tel" id="phone" name="phone" class="form-control" placeholder="Enter your phone number" required>
                            </div>

                            <div class="mb-3">
                                <label for="payment-mode" class="form-label">Payment Mode:</label>
                                <select id="payment-mode" name="paymentMode" class="form-select" required>
                                    <option value="Cash">Cash on Delivery (COD)</option>
                                    <option value="UPI">UPI</option>
                                    <option value="Debit Card">Debit Card</option>
                                    <option value="Credit Card">Credit Card</option>
                                </select>
                            </div>

                            <div class="text-center">
                                <button type="submit" id="place-order-btn" class="btn btn-success btn-lg">Place Order</button>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Popup Modal for Unauthorized Users -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content shadow-lg">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="loginModalLabel">Access Denied</h5>
                </div>
                <div class="modal-body text-center">
                    <p class="fs-4 text-danger fw-bold">You need to be logged in to place an order.</p>
                    <p class="fs-6 text-muted">Redirecting to Home...</p>
                    <div class="spinner-border text-danger mt-2" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
<jsp:include page="footer.jsp" />
    <script>
    var notLoggedIn = <%= notLoggedIn %>;
</script>
<script src="checkout.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
