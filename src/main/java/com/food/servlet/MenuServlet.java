package com.food.servlet;

import com.food.daoImpl.MenuDAOImpl;
import com.food.daoImpl.RestaurantDAOImpl;
import com.food.model.Menu;
import com.food.model.Restaurant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            // Ensure restaurantId is provided and valid
            String restaurantIdParam = request.getParameter("restaurantId");
            if (restaurantIdParam == null || restaurantIdParam.isEmpty()) {
                response.sendRedirect("Home"); // Redirect to Home if no ID
                return;
            }

            int restaurantId = Integer.parseInt(restaurantIdParam);

            // Fetch restaurant details
            RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
            Restaurant restaurant = restaurantDAO.getRestaurant(restaurantId);

            // Check if restaurant exists
            if (restaurant == null) {
                response.sendRedirect("error.jsp"); // Redirect if restaurant not found
                return;
            }

            // Store restaurant in session to persist when navigating
            session.setAttribute("restaurant", restaurant);

            // Fetch menu items for the restaurant
            MenuDAOImpl menuDAO = new MenuDAOImpl();
            List<Menu> menuList = menuDAO.getAllMenusByRestaurant(restaurantId);

            // Set attributes to pass to JSP
            request.setAttribute("menuList", menuList);

            // Forward to menu.jsp
            request.getRequestDispatcher("menu.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("Home"); // Redirect to Home if ID is invalid
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect on general error
        }
    }
}
