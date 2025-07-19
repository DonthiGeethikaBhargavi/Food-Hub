package com.food.servlet;

import com.food.dao.MenuDAO;
import com.food.dao.OrderDAO;
import com.food.dao.RestaurantDAO;
import com.food.daoImpl.MenuDAOImpl;
import com.food.daoImpl.OrderDAOImpl;
import com.food.daoImpl.RestaurantDAOImpl;
import com.food.model.Menu;
import com.food.model.Order;
import com.food.model.Restaurant;
import com.food.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/OwnerDashboardServlet")
public class OwnerDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
    private MenuDAO menuDAO = new MenuDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl(); // ✅ Add this

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user != null && "RestaurantAdmin".equalsIgnoreCase(user.getRole())) {
            int restaurantId = user.getRestaurantId();

            // ✅ Fetch details
            Restaurant restaurant = restaurantDAO.getRestaurant(restaurantId);
            List<Menu> menuItems = menuDAO.getAllMenusByRestaurant(restaurantId);
            List<Order> orders = orderDAO.getOrdersByRestaurantId(restaurantId);

            // ✅ Null safety
            if (orders == null) {
                orders = new ArrayList<>();
            }

            // ✅ Set attributes
            request.setAttribute("restaurant", restaurant);
            request.setAttribute("menuItems", menuItems);
            request.setAttribute("orders", orders); // ✅ Fixes the NPE

            request.getRequestDispatcher("owner-dashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
