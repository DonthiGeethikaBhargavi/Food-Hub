// OrderDAOImpl.java
package com.food.daoImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.food.dao.OrderDAO;
import com.food.model.Order;
import com.food.utility.DBConnection;
import com.food.utility.OrderIdGenerator;
import java.sql.Timestamp;
public class OrderDAOImpl implements OrderDAO {

    @Override
    public void addOrder(Order order) {
        String sql = "INSERT INTO OrderTable (OrderId, UserId, RestaurantId, OrderDate, TotalAmount, Status, PaymentMode) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            // Generate Unique Order ID
            String orderId = OrderIdGenerator.generateOrderId(order.getUserId(), order.getRestaurantId());
            order.setOrderId(orderId);

            stmt.setString(1, orderId);
            stmt.setInt(2, order.getUserId());
            stmt.setInt(3, order.getRestaurantId());
            stmt.setTimestamp(4, new java.sql.Timestamp(order.getOrderDate().getTime()));
            stmt.setDouble(5, order.getTotalAmount());
            stmt.setString(6, order.getStatus());
            stmt.setString(7, order.getPaymentMode());

            stmt.executeUpdate();
            System.out.println("Order added successfully! Order ID: " + order.getOrderId());

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Order getOrder(String orderId) {
        String sql = "SELECT * FROM OrderTable WHERE OrderId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, orderId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Order(
                        rs.getString("OrderId"),
                        rs.getInt("UserId"),
                        rs.getInt("RestaurantId"),
                        rs.getDate("OrderDate"),
                        rs.getDouble("TotalAmount"),
                        rs.getString("Status"),
                        rs.getString("PaymentMode")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateOrder(Order order) {
        String sql = "UPDATE OrderTable SET UserId = ?, RestaurantId = ?, OrderDate = ?, TotalAmount = ?, Status = ?, PaymentMode = ? WHERE OrderId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, order.getUserId());
            stmt.setInt(2, order.getRestaurantId());
            stmt.setDate(3, new java.sql.Date(order.getOrderDate().getTime()));
            stmt.setDouble(4, order.getTotalAmount());
            stmt.setString(5, order.getStatus());
            stmt.setString(6, order.getPaymentMode());
            stmt.setString(7, order.getOrderId());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Order updated successfully!");
            } else {
                System.out.println("Order update failed! Order not found.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrder(String orderId) {
        String sql = "DELETE FROM OrderTable WHERE OrderId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, orderId);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Order deleted successfully!");
            } else {
                System.out.println("Order deletion failed! Order not found.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Order> getAllOrdersByUser(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM OrderTable WHERE UserId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                orders.add(new Order(
                        rs.getString("OrderId"),
                        rs.getInt("UserId"),
                        rs.getInt("RestaurantId"),
                        rs.getDate("OrderDate"),
                        rs.getDouble("TotalAmount"),
                        rs.getString("Status"),
                        rs.getString("PaymentMode")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM OrderTable";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                orders.add(new Order(
                        rs.getString("OrderId"),
                        rs.getInt("UserId"),
                        rs.getInt("RestaurantId"),
                        rs.getDate("OrderDate"),
                        rs.getDouble("TotalAmount"),
                        rs.getString("Status"),
                        rs.getString("PaymentMode")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
    private static final String GET_ORDERS_BY_RESTAURANT_ID =
            "SELECT OrderId, UserId, RestaurantId, OrderDate, TotalAmount, Status, PaymentMode " +
            "FROM ordertable WHERE RestaurantId = ? ORDER BY OrderDate DESC";

        @Override
        public List<Order> getOrdersByRestaurantId(int restaurantId) {
            List<Order> orders = new ArrayList<>();

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(GET_ORDERS_BY_RESTAURANT_ID)) {

                stmt.setInt(1, restaurantId);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getString("OrderId"));
                    order.setUserId(rs.getInt("UserId"));
                    order.setRestaurantId(rs.getInt("RestaurantId"));
                    order.setOrderDate(rs.getTimestamp("OrderDate"));
                    order.setTotalAmount(rs.getDouble("TotalAmount"));
                    order.setStatus(rs.getString("Status"));
                    order.setPaymentMode(rs.getString("PaymentMode"));

                    orders.add(order);
                }

            } catch (SQLException e) {
                e.printStackTrace(); // Consider using a logger instead
            }

            return orders;
        }
        @Override
        public void updateOrderStatus(String orderId, String newStatus) {
            String sql = "UPDATE ordertable SET status = ? WHERE orderId = ?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, newStatus);
                stmt.setString(2, orderId);
                stmt.executeUpdate();

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    
}
