<%@ page import="java.util.Map" %>
<%@ page import="com.food.model.CartItem" %>
<%@ page import="com.food.model.Cart" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="com.food.model.Restaurant" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<%
    HttpSession sessionObj = request.getSession();
    Cart cart = (Cart) sessionObj.getAttribute("cart");

    if (cart == null) {
        cart = new Cart();
        sessionObj.setAttribute("cart", cart);
    }

    Map<Integer, CartItem> cartItems = cart.getItems();
    Restaurant restaurant = (Restaurant) sessionObj.getAttribute("restaurant");
    int restaurantId = (restaurant != null) ? restaurant.getRestaurantId() : -1;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cart - Food Hub</title>
    <link rel="icon" type="image/png" href="images/FoodHubLogo.jpg">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="cart.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous"></script> 
</head>
<body>

<jsp:include page="header.jsp" />

<div class="container mt-5">
    <h2 class="text-center mb-4">
        <i class="fas fa-shopping-cart"></i> Your Cart
    </h2>

    <% String error = request.getParameter("error"); %>

    <% if (cartItems.isEmpty()) { %>
        <script>
            $(document).ready(function(){
                $("#emptyCartModal").modal("show");
            });
        </script>
    <% } %>

    <div class="table-responsive">
        <% if (!cartItems.isEmpty()) { %>
            <table class="table table-striped text-center align-middle">
                <thead class="table-dark">
                    <tr>
                        <th><i class="fas fa-image"></i> Image</th>
                        <th><i class="fas fa-utensils"></i> Item Name</th>
                        <th><i class="fas fa-tag"></i> Price</th>
                        <th><i class="fas fa-sort-numeric-up"></i> Quantity</th>
                        <th><i class="fas fa-calculator"></i> Total</th>
                        <th><i class="fas fa-trash-alt"></i> Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% double grandTotal = 0;
                        for (CartItem item : cartItems.values()) { 
                            double itemTotal = item.getQuantity() * item.getPrice();
                            grandTotal += itemTotal;
                    %>
                    <tr>
                        <td><img src="<%= item.getImage() %>" alt="Item Image" class="cart-item-img"></td>
                        <td><%= item.getName() %></td>
                        <td>₹<%= item.getPrice() %></td>
                        <td>
                            <form action="CartServlet" method="post" class="d-inline">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
                                <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
                                <input type="number" name="quantity" class="form-control d-inline w-50 text-center" 
                                       value="<%= item.getQuantity() %>" min="1" required>
                                <button type="submit" class="btn btn-sm btn-primary">
                                    <i class="fas fa-sync-alt"></i> Update
                                </button>
                            </form>
                        </td>
                        <td>₹<%= itemTotal %></td>
                        <td>
                            <form action="CartServlet" method="post" class="d-inline">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
                                <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash"></i> Remove
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <h4 class="text-end mt-3">Grand Total: ₹<%= grandTotal %></h4>

            <div class="d-flex justify-content-between mt-4">
                <a href="<%= (error != null && error.equals("different_restaurant")) ? "#" : "MenuServlet?restaurantId=" + restaurantId %>" 
                    class="btn btn-secondary" id="addMoreBtn">
                    <i class="fas fa-plus"></i> Add More
                  </a>

                <form action="CartServlet" method="post" class="d-inline">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" class="btn btn-warning"><i class="fas fa-trash-alt"></i> Clear Cart</button>
                </form>
                <form action="CheckoutServlet" method="post">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-shopping-cart"></i> Proceed to Checkout
                    </button>
                </form>
            </div>
        <% } %>
    </div>
</div>

<jsp:include page="footer.jsp" />

<!-- Empty Cart Modal -->
<div class="modal fade" id="emptyCartModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-warning">
                <h5 class="modal-title"><i class="fas fa-exclamation-circle"></i> Empty Cart</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center">
                <p>Your cart is empty. Please add items to continue.</p>
                <a href="Home" class="btn btn-primary">
                    <i class="fas fa-home"></i> Go Back to Home
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Different Restaurant Modal -->
<% if ("different_restaurant".equals(error)) { %>
    <script>
        $(document).ready(function(){
            $("#differentRestaurantModal").modal("show");
        });
    </script>
<% } %>
<div class="modal fade" id="differentRestaurantModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title"><i class="fas fa-exclamation-triangle"></i> Cart Conflict</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center">
                <p>Your cart contains items from another restaurant. Do you want to clear the cart and add the new item?</p>
            </div>
            <div class="modal-footer">
                <a href="CartServlet?action=clear&restaurantId=<%= restaurantId %>" class="btn btn-danger">
                    <i class="fas fa-trash"></i> Clear Cart & Add
                </a>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times"></i> Cancel
                </button>
            </div>
        </div>
    </div>
</div>
<script>
$(document).ready(function () {
    let errorType = "<%= error %>";
    if (errorType === "different_restaurant") {
        $("#addMoreBtn").click(function (event) {
            event.preventDefault(); // Prevent default navigation
            $("#differentRestaurantModal").modal("show");
        });
    }
});

</script>
</body>
</html>
