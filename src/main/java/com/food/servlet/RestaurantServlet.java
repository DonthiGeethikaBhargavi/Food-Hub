package com.food.servlet;

import com.food.daoImpl.RestaurantDAOImpl;
import com.food.model.Restaurant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

@WebServlet("/RestaurantServlet")
public class RestaurantServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int menuId = Integer.parseInt(request.getParameter("menuId"));

        RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
        List<Restaurant> restaurantList = restaurantDAO.getRestaurantsByMenuItem(menuId);

        request.setAttribute("restaurantList", restaurantList);
        request.getRequestDispatcher("restaurants.jsp").forward(request, response);
    }
}
