<%@ page import="java.util.List" %>
<%@ page import="com.food.model.User" %>
<%@ page import="com.food.model.Menu" %>
<%@ page import="com.food.model.Order" %>
<%@ page import="com.food.model.Restaurant" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"RestaurantAdmin".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
    List<Menu> menuItems = (List<Menu>) request.getAttribute("menuItems");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Owner Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: url('images/restaurant-bg.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #333;
            padding-top: 70px;
        }
        .navbar {
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
        .dashboard {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            padding: 30px;
            margin-top: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
        h2, h3, h4 {
            font-weight: 700;
        }
        .table {
            background-color: #fff;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #ced4da;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"><i class="fas fa-utensils"></i> Owner Dashboard</a>
            <div class="d-flex">
                <span class="navbar-text text-white me-3">
                    Logged in as <strong><%= user.getName() %></strong>
                </span>
                <form action="LogoutServlet" method="post">
                    <button class="btn btn-outline-light btn-sm"><i class="fas fa-sign-out-alt"></i> Logout</button>
                </form>
            </div>
        </div>
    </nav>

    <div class="container dashboard">
        <h2 class="mb-4"><i class="fas fa-store"></i> Welcome, <%= user.getName() %> (Owner of <%= restaurant.getName() %>)</h2>

        <h4 class="text-primary"><i class="fas fa-utensils"></i> Menu Items</h4>
        <table class="table table-striped">
            <thead class="table-dark">
                <tr><th>ID</th><th>Name</th><th>Price</th><th>Category</th></tr>
            </thead>
            <tbody>
                <% for(Menu item : menuItems) { %>
                <tr>
                    <td><%= item.getMenuId() %></td>
                    <td><%= item.getItemName() %></td>
                    <td>₹<%= item.getPrice() %></td>
                    <td><%= item.getDescription() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <h4 class="text-success mt-5"><i class="fas fa-receipt"></i> Recent Orders</h4>
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr><th>Order ID</th><th>Date</th><th>Status</th></tr>
            </thead>
            <tbody>
                <% for(Order order : orders) { %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getOrderDate() %></td>
                    <td>
                        <form action="<%=request.getContextPath()%>/UpdateOrderStatus" method="post">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                            <select name="status" onchange="this.form.submit()" class="form-select">
                                <option value="Pending" <%= "Pending".equals(order.getStatus()) ? "selected" : "" %>>Pending</option>
                                <option value="In Progress" <%= "In Progress".equals(order.getStatus()) ? "selected" : "" %>>In Progress</option>
                                <option value="Delivered" <%= "Delivered".equals(order.getStatus()) ? "selected" : "" %>>Delivered</option>
                                <option value="Cancelled" <%= "Cancelled".equals(order.getStatus()) ? "selected" : "" %>>Cancelled</option>
                            </select>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <h3 class="mt-5"><i class="fas fa-plus-circle"></i> Add New Menu Item</h3>
        <form action="<%=request.getContextPath()%>/MenuServlet" method="post" enctype="multipart/form-data" class="row g-2 mb-5">

            <input type="hidden" name="action" value="add">
            <input type="hidden" name="restaurantId" value="<%= restaurant.getRestaurantId() %>">

            <div class="col-md-4">
                <input type="text" name="itemName" placeholder="Item Name" class="form-control" required />
            </div>
            <div class="col-md-4">
                <input type="text" name="description" placeholder="Description" class="form-control" required />
            </div>
            <div class="col-md-2">
                <input type="number" name="price" step="0.01" placeholder="Price" class="form-control" required />
            </div>
            <div class="col-md-4">
    <input type="file" name="image" class="form-control" accept="image/*" />
</div>
            
            <div class="col-md-2">
                <button type="submit" class="btn btn-success w-100"><i class="fas fa-plus"></i> Add</button>
            </div>
        </form>

        <hr/>

        <h3><i class="fas fa-edit"></i> Edit Menu Items</h3>
        <table class="table table-bordered">
            <thead class="table-dark">
    <tr>
        <th>Item Name</th>
        <th>Description</th>
        <th>Price (₹)</th>
        <th>Image</th> <!-- 🆕 New column -->
        <th>Actions</th>
    </tr>
</thead>

            <tbody>
                <% if (menuItems != null && !menuItems.isEmpty()) {
                    for (Menu m : menuItems) {
                %>
                <tr>
 <tr>
<form action="<%=request.getContextPath()%>/MenuServlet" method="post" enctype="multipart/form-data">
    <input type="hidden" name="restaurantId" value="<%= restaurant.getRestaurantId() %>">
    <input type="hidden" name="menuId" value="<%= m.getMenuId() %>">
    
    <td>
        <input type="text" name="itemName" value="<%= m.getItemName() %>" required class="form-control" />
    </td>
    <td>
        <input type="text" name="description" value="<%= m.getDescription() %>" required class="form-control" />
    </td>
    <td>
        <input type="number" step="0.01" name="price" value="<%= m.getPrice() %>" required class="form-control" />
    </td>
    
    <!-- Optional: Image preview and file input -->
    <td>
        <% if (m.getImagePath() != null && !m.getImagePath().isEmpty()) { %>
            <img src="<%=request.getContextPath()%>/<%= m.getImagePath() %>" width="60" height="50" class="mb-1"/><br/>
        <% } %>
        <input type="file" name="image" accept="image/*" class="form-control form-control-sm" />
    </td>

    <td>
        <button name="action" value="update" class="btn btn-sm btn-primary">
            <i class="fas fa-sync-alt me-1"></i> Update
        </button>
        <button name="action" value="delete" class="btn btn-sm btn-danger"
                onclick="return confirm('Delete this item?');">
            <i class="fas fa-trash me-1"></i> Delete
        </button>
    </td>
</form>
</tr>

                <% } } else { %>
                <tr><td colspan="4">No menu items found.</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
