package com.food.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;

import com.food.daoImpl.MenuDAOImpl;
import com.food.daoImpl.RestaurantDAOImpl;
import com.food.model.Menu;
import com.food.model.Restaurant;
import com.food.model.User;

@WebServlet("/Home")
public class Home extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            MenuDAOImpl menuDAO = new MenuDAOImpl();
            RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();

            List<Menu> menuList = menuDAO.getAllMenu();
            List<Restaurant> restaurantList = restaurantDAO.getAllRestaurants();

            request.setAttribute("menuList", menuList);
            request.setAttribute("restaurantList", restaurantList);

            HttpSession session = request.getSession(false);
            RequestDispatcher dispatcher;
            if (session == null || session.getAttribute("user") == null) {
                dispatcher = request.getRequestDispatcher("index.jsp");
            } else {
                dispatcher = request.getRequestDispatcher("home.jsp");
            }
            dispatcher.forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Failed to load data.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
