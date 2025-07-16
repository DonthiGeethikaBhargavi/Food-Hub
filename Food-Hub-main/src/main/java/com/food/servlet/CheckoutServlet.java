package com.food.servlet;

import com.food.model.Cart;
import com.food.model.CartItem;
import com.food.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            session.setAttribute("notLoggedIn", true);
            response.sendRedirect("checkout.jsp");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        double grandTotal = 0;
        Map<Integer, CartItem> cartItems = cart.getItems();
        for (CartItem item : cartItems.values()) {
            grandTotal += item.getQuantity() * item.getPrice();
        }

        session.setAttribute("cartItems", cartItems);
        session.setAttribute("grandTotal", grandTotal);
        session.removeAttribute("notLoggedIn"); // Ensure the flag is cleared for logged-in users

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }
}
