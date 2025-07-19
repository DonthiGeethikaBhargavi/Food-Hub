package com.food.servlet;

import com.food.dao.OrderHistoryDAO;
import com.food.daoImpl.OrderHistoryDAOImpl;
import com.food.model.OrderHistory;
import com.food.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get order history for the logged-in user
        OrderHistoryDAO orderHistoryDAO = new OrderHistoryDAOImpl();
        List<OrderHistory> orderHistories = orderHistoryDAO.getOrderHistoriesByUser(user.getUserId());

        // Set the order history data in the request scope
        request.setAttribute("orderHistories", orderHistories);
        request.getRequestDispatcher("orderHistory.jsp").forward(request, response);
    }
}
