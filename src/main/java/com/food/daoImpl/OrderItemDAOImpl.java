package com.food.daoImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.food.dao.OrderItemDAO;
import com.food.model.OrderItem;
import com.food.utility.DBConnection;

public class OrderItemDAOImpl implements OrderItemDAO {

    @Override
    public void addOrderItem(OrderItem orderItem) {
        String sql = "INSERT INTO OrderItem (OrderId, MenuId, Quantity, TotalPrice) VALUES (?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, orderItem.getOrderId());
            stmt.setInt(2, orderItem.getMenuId());
            stmt.setInt(3, orderItem.getQuantity());
            stmt.setDouble(4, orderItem.getTotalPrice());
            stmt.executeUpdate();
            System.out.println("Order item added successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public OrderItem getOrderItem(int orderItemId) {
        String sql = "SELECT * FROM OrderItem WHERE OrderItemId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderItemId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new OrderItem(
                        rs.getInt("OrderItemId"),
                        rs.getString("OrderId"),
                        rs.getInt("MenuId"),
                        rs.getInt("Quantity"),
                        rs.getDouble("TotalPrice")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateOrderItem(OrderItem orderItem) {
        String sql = "UPDATE OrderItem SET OrderId = ?, MenuId = ?, Quantity = ?, TotalPrice = ? WHERE OrderItemId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, orderItem.getOrderId());
            stmt.setInt(2, orderItem.getMenuId());
            stmt.setInt(3, orderItem.getQuantity());
            stmt.setDouble(4, orderItem.getTotalPrice());
            stmt.setInt(5, orderItem.getOrderItemId());
            stmt.executeUpdate();
            System.out.println("Order item updated successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteOrderItem(int orderItemId) {
        String sql = "DELETE FROM OrderItem WHERE OrderItemId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderItemId);
            stmt.executeUpdate();
            System.out.println("Order item deleted successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<OrderItem> getOrderItemsByOrder(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT * FROM OrderItem WHERE OrderId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                orderItems.add(new OrderItem(
                        rs.getInt("OrderItemId"),
                        rs.getString("OrderId"),
                        rs.getInt("MenuId"),
                        rs.getInt("Quantity"),
                        rs.getDouble("TotalPrice")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItems;
    }
}
