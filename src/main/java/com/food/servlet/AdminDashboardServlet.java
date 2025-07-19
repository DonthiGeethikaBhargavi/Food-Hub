package com.food.servlet;

import com.food.dao.OrderDAO;
import com.food.dao.RestaurantDAO;
import com.food.dao.UserDAO;
import com.food.daoImpl.OrderDAOImpl;
import com.food.daoImpl.RestaurantDAOImpl;
import com.food.daoImpl.UserDAOImpl;
import com.food.model.Order;
import com.food.model.Restaurant;
import com.food.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // DAO instances
    private final UserDAO userDAO = new UserDAOImpl();
    private final RestaurantDAO restDAO = new RestaurantDAOImpl();
    private final OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("user") : null;

        // ✅ Check for SystemAdmin role
        if (currentUser == null || !"SystemAdmin".equalsIgnoreCase(currentUser.getRole())) {
            res.sendRedirect("login.jsp");
            return;
        }

        try {
            // 🔄 Fetch all required data
            List<Restaurant> restaurants = restDAO.getAllRestaurants();
            List<User> restaurantAdmins = userDAO.getUsersByRole("RestaurantAdmin");
            List<Order> orders = orderDAO.getAllOrders();

            // 📊 Set summary data
            req.setAttribute("restaurants", restaurants);
            req.setAttribute("restaurantAdmins", restaurantAdmins);
            req.setAttribute("orders", orders);

            req.setAttribute("totalRestaurants", restaurants.size());
            req.setAttribute("totalAdmins", restaurantAdmins.size());
            req.setAttribute("totalOrders", orders.size());

            // Forward to admin JSP page
            req.getRequestDispatcher("admin-dashboard.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("error.jsp");
        }
    }
}
