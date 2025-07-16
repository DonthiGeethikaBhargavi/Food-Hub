package com.food.servlet;

import com.food.daoImpl.OrderDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/UpdateOrderStatus")
public class OrderStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private OrderDAOImpl orderDAO = new OrderDAOImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        String newStatus = request.getParameter("status");

        if (orderId != null && newStatus != null) {
            orderDAO.updateOrderStatus(orderId, newStatus);
        }

        response.sendRedirect("OwnerDashboardServlet");
    }
}
