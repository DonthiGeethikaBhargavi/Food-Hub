package com.food.servlet;

import com.food.dao.OrderDAO;
import com.food.dao.OrderItemDAO;
import com.food.dao.OrderHistoryDAO;
import com.food.daoImpl.OrderDAOImpl;
import com.food.daoImpl.OrderItemDAOImpl;
import com.food.daoImpl.OrderHistoryDAOImpl;
import com.food.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/OrderConfirmationServlet")
public class OrderConfirmationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Restaurant restaurant = (Restaurant) session.getAttribute("restaurant");
        Double totalAmount = (Double) session.getAttribute("grandTotal");
        String paymentMode = request.getParameter("paymentMode");

        Cart cart = (Cart) session.getAttribute("cart");

        if (user == null || restaurant == null || totalAmount == null || paymentMode == null || cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        // Convert `Map<Integer, CartItem>` to `List<CartItem>`
        List<CartItem> cartItems = new ArrayList<>(cart.getItems().values());

        try {
            // Step 1: Create Order
            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setRestaurantId(restaurant.getRestaurantId());
            order.setOrderDate(new Date());
            order.setTotalAmount(totalAmount);
            order.setStatus("Pending");
            order.setPaymentMode(paymentMode);

            OrderDAO orderDAO = new OrderDAOImpl();
            orderDAO.addOrder(order);

            // Step 2: Retrieve the Generated Order ID
            String orderId = order.getOrderId();

            // Step 3: Add Order Items
            OrderItemDAO orderItemDAO = new OrderItemDAOImpl();
            for (CartItem cartItem : cartItems) {
                OrderItem orderItem = new OrderItem();
                orderItem.setOrderId(orderId);
                orderItem.setMenuId(cartItem.getMenuId());
                orderItem.setQuantity(cartItem.getQuantity());
                orderItem.setTotalPrice(cartItem.getPrice());

                orderItemDAO.addOrderItem(orderItem);
            }

            // Step 4: Prepare Ordered Menu Items String
            String menuItems = cartItems.stream()
                    .map(cartItem -> cartItem.getName() + " (x" + cartItem.getQuantity() + ")")
                    .collect(Collectors.joining(", "));

            // Step 5: Add Order History with Restaurant ID, Name & Menu Items
            OrderHistory orderHistory = new OrderHistory();
            orderHistory.setUserId(user.getUserId());
            orderHistory.setOrderId(orderId);
            orderHistory.setOrderDate(new Date());
            orderHistory.setTotalAmount(totalAmount);
            orderHistory.setStatus("Delivered");
            orderHistory.setRestaurantId(restaurant.getRestaurantId());  // Store Restaurant ID
            orderHistory.setRestaurantName(restaurant.getName()); // Store Restaurant Name
            orderHistory.setMenuItems(menuItems); // Store ordered menu items

            OrderHistoryDAO orderHistoryDAO = new OrderHistoryDAOImpl();
            orderHistoryDAO.addOrderHistory(orderHistory);

            // Step 6: Cleanup Session Data
            session.setAttribute("order", order);
            session.setAttribute("restaurantName", restaurant.getName());
            session.setAttribute("cartItems", cartItems);
            session.removeAttribute("cart");
            session.removeAttribute("grandTotal");
            session.removeAttribute("restaurantList");

            response.sendRedirect("orderConfirmation.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
