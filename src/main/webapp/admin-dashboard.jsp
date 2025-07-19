<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.food.model.User, com.food.model.Restaurant, com.food.model.Order" %>
<%
System.out.println("🧠 Session User = " + session.getAttribute("user"));
User adminUser = (User) session.getAttribute("user");

if (adminUser == null) {
    System.out.println("❌ Session user is null!");
    response.sendRedirect("login.jsp");
    return;
} else {
    System.out.println("✅ Role = " + adminUser.getRole());
}

if (!"SystemAdmin".equalsIgnoreCase(adminUser.getRole())) {
    System.out.println("❌ Role mismatch: " + adminUser.getRole());
    response.sendRedirect("login.jsp");
    return;
}
List<User> restaurantAdmins = (List<User>) request.getAttribute("restaurantAdmins");
    List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
    List<Order> orders = (List<Order>) request.getAttribute("orders");

    int totalRestaurants = (int) request.getAttribute("totalRestaurants");
    int totalAdmins = (int) request.getAttribute("totalAdmins");
    int totalOrders = (int) request.getAttribute("totalOrders");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
    html, body {
    height: 100%;
    margin: 0;
}
section {
    scroll-margin-top: 80px; /* Push section heading down when navigated via anchor */
}

html {
  scroll-behavior: smooth;
  /* scroll-padding-top: 100px;  *//* equal to or slightly more than navbar height */
}

        body {
            background: #f4f8fb;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
    flex-direction: column;
    min-height: 100vh;
    overflow: hidden;
            
        }
        h2 {
            font-weight: 600;
        }
        .summary-card {
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
            color: white;
        }
        .form-control:focus {
            box-shadow: none;
            border-color: #007bff;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }
        .btn-sm {
            font-size: 0.8rem;
        }
        .main-wrapper {
    flex: 1;
    display: flex;
    height: calc(100vh - 56px); /* minus navbar height */
    overflow: hidden;
}

.sidebar {
    width: 220px;
    background-color: #343a40;
    color: white;
    padding: 1rem;
    overflow-y: auto;
}

.main-content {
    flex-grow: 1;
    overflow-y: auto;
    padding: 2rem;
    padding-top: 80px; /* ✅ Push content below navbar */
    background-color: #f4f8fb;
}
@media (max-width: 768px) {
    .main-content {
        padding-top: 100px;
    }
}


    </style>
</head>
<body>
<!-- Top Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="fas fa-utensils me-2"></i>Admin Panel</a>

        <ul class="navbar-nav ms-auto">
            <li class="nav-item dropdown me-3">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                    <i class="fas fa-user-circle me-1"></i><%= adminUser.getName() %>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                    <li><a class="dropdown-item" href="#">👤 Profile</a></li>
                    <!-- <li><a class="dropdown-item" href="#">⚙️ Settings</a></li> -->
                    <li><hr class="dropdown-divider"></li>
                    <li>
                        <form action="LogoutServlet" method="post" class="d-inline">
                            <button class="dropdown-item text-danger"><i class="fas fa-sign-out-alt me-2"></i>Logout</button>
                        </form>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<div class="main-wrapper">

    <!-- Sidebar -->
    <div class="sidebar">

        <h5 class="text-white mb-4"><i class="fas fa-bars me-2"></i>Dashboard</h5>
        <ul class="nav flex-column">
            <li class="nav-item"><a href="#summary" class="nav-link text-white"><i class="fas fa-chart-bar me-2"></i>Summary</a></li>
            <li class="nav-item"><a href="#addAdmin" class="nav-link text-white"><i class="fas fa-user-plus me-2"></i>Add Admin</a></li>
            <li class="nav-item"><a href="#manageAdmins" class="nav-link text-white"><i class="fas fa-users-cog me-2"></i>Manage Admins</a></li>
            <li class="nav-item"><a href="#orders" class="nav-link text-white"><i class="fas fa-receipt me-2"></i>Orders</a></li>
        </ul>
    </div>

    <!-- Main Content -->
    <div class="main-content">


        <!-- 🧮 Summary Section -->
        <section id="summary" class="mb-4">
            <h3>Dashboard Summary</h3>
            <div class="row">
                <div class="col-md-4 mb-3">
                    <div class="bg-primary text-white p-3 rounded text-center">
                        <h5>Total Restaurants</h5>
                        <h2><%= totalRestaurants %></h2>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="bg-success text-white p-3 rounded text-center">
                        <h5>Restaurant Admins</h5>
                        <h2><%= totalAdmins %></h2>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="bg-warning text-dark p-3 rounded text-center">
                        <h5>Total Orders</h5>
                        <h2><%= totalOrders %></h2>
                    </div>
                </div>
            </div>
        </section>

        <!-- ➕ Add Admin -->
        <section id="addAdmin" class="mb-5">
            <h4>Add Restaurant Admin</h4>
            <form action="AdminManagementServlet" method="post" class="row g-2">
                <input type="hidden" name="action" value="addAdmin">
                <div class="col-md-2"><input type="text" name="name" class="form-control" placeholder="Name" required></div>
                <div class="col-md-2"><input type="text" name="username" class="form-control" placeholder="Username" required></div>
                <div class="col-md-2"><input type="password" name="password" class="form-control" placeholder="Password" required></div>
                <div class="col-md-2"><input type="email" name="email" class="form-control" placeholder="Email" required></div>
                <div class="col-md-2"><input type="text" name="phone" class="form-control" placeholder="Phone"></div>
                <div class="col-md-1"><input type="text" name="restaurantId" class="form-control" placeholder="Rest ID" required></div>
                <div class="col-md-1"><button class="btn btn-success w-100">Add</button></div>
            </form>
        </section>

        <!-- 🛠 Manage Admins -->
        <section id="manageAdmins" class="mb-5">
            <h4>Manage Restaurant Admins</h4>
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead class="table-dark">
                        <tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Restaurant ID</th><th>Actions</th></tr>
                    </thead>
                    <tbody>
                    <% for (User u : restaurantAdmins) { %>
                        <tr>
                            <form action="AdminManagementServlet" method="post">
                                <td><%= u.getUserId() %><input type="hidden" name="userId" value="<%= u.getUserId() %>"></td>
                                <td><input name="name" class="form-control" value="<%= u.getName() %>" required></td>
                                <td><input name="email" class="form-control" value="<%= u.getEmail() %>" required></td>
                                <td><input name="phone" class="form-control" value="<%= u.getPhone() %>"></td>
                                <td><input name="restaurantId" class="form-control" value="<%= u.getRestaurantId() %>" required></td>
                                <td>
                                    <button class="btn btn-primary btn-sm" name="action" value="editAdmin">Update</button>
                                    <button class="btn btn-danger btn-sm" name="action" value="deleteAdmin"
                                            onclick="return confirm('Are you sure?')">Delete</button>
                                </td>
                            </form>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </section>

        <!-- 📦 Orders -->
        <section id="orders">
            <h4>Orders Overview</h4>
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead class="table-dark">
                        <tr><th>Order ID</th><th>User ID</th><th>Restaurant ID</th><th>Date</th><th>Total</th><th>Status</th><th>Payment</th></tr>
                    </thead>
                    <tbody>
                        <% for (Order o : orders) { %>
                        <tr>
                            <td><%= o.getOrderId() %></td>
                            <td><%= o.getUserId() %></td>
                            <td><%= o.getRestaurantId() %></td>
                            <td><%= o.getOrderDate() %></td>
                            <td>₹<%= o.getTotalAmount() %></td>
                            <td><%= o.getStatus() %></td>
                            <td><%= o.getPaymentMode() %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </section>

    </div> <!-- End Main Content -->
</div> <!-- End Flex -->


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>