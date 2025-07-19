package com.food.daoImpl;
import java.sql.Timestamp;
import com.food.dao.OrderHistoryDAO;
import com.food.model.OrderHistory;
import com.food.utility.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderHistoryDAOImpl implements OrderHistoryDAO {

    private static final String GET_ORDERS_BY_USER = "SELECT OrderHistoryID, UserID, OrderID, RestaurantName, MenuItems, OrderDate, TotalAmount, Status FROM OrderHistory WHERE UserID = ?";
    
    private static final String GET_ALL_ORDERS = "SELECT * FROM OrderHistory";

    private static final String GET_ORDER_BY_ID = "SELECT * FROM OrderHistory WHERE OrderHistoryID = ?";

    private static final String INSERT_ORDER_HISTORY = "INSERT INTO OrderHistory (UserID, OrderID, RestaurantName, MenuItems, OrderDate, TotalAmount, Status,RestaurantID) VALUES (?, ?, ?, ?, ?, ?, ?,?)";

    private static final String UPDATE_ORDER_STATUS = "UPDATE OrderHistory SET Status = ? WHERE OrderHistoryID = ?";

    private static final String DELETE_ORDER_HISTORY = "DELETE FROM OrderHistory WHERE OrderHistoryID = ?";


    @Override
    public List<OrderHistory> getOrderHistoriesByUser(int userId) {
        List<OrderHistory> orderHistories = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(GET_ORDERS_BY_USER)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                orderHistories.add(mapResultSetToOrderHistory(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderHistories;
    }

    @Override
    public List<OrderHistory> getAllOrderHistories() {
        List<OrderHistory> orderHistories = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(GET_ALL_ORDERS);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                orderHistories.add(mapResultSetToOrderHistory(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderHistories;
    }

    @Override
    public OrderHistory getOrderHistoryById(int orderHistoryId) {
        OrderHistory orderHistory = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(GET_ORDER_BY_ID)) {

            pstmt.setInt(1, orderHistoryId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                orderHistory = mapResultSetToOrderHistory(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderHistory;
    }

    @Override
    public boolean addOrderHistory(OrderHistory order) {
        boolean added = false;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(INSERT_ORDER_HISTORY)) {

            pstmt.setInt(1, order.getUserId());
            pstmt.setString(2, order.getOrderId());
            pstmt.setString(3, order.getRestaurantName());
            pstmt.setString(4, order.getMenuItems());
         // Convert java.util.Date to java.sql.Timestamp
            pstmt.setTimestamp(5, new Timestamp(order.getOrderDate().getTime()));
            pstmt.setDouble(6, order.getTotalAmount());
            pstmt.setString(7, order.getStatus());
            pstmt.setInt(8, order.getRestaurantId());

            int rowsInserted = pstmt.executeUpdate();
            added = rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return added;
    }

    @Override
    public boolean updateOrderStatus(int orderHistoryId, String status) {
        boolean updated = false;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(UPDATE_ORDER_STATUS)) {

            pstmt.setString(1, status);
            pstmt.setInt(2, orderHistoryId);

            int rowsUpdated = pstmt.executeUpdate();
            updated = rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updated;
    }

    @Override
    public boolean deleteOrderHistory(int orderHistoryId) {
        boolean deleted = false;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(DELETE_ORDER_HISTORY)) {

            pstmt.setInt(1, orderHistoryId);

            int rowsDeleted = pstmt.executeUpdate();
            deleted = rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return deleted;
    }

    private OrderHistory mapResultSetToOrderHistory(ResultSet rs) throws SQLException {
        OrderHistory order = new OrderHistory();
        order.setOrderHistoryId(rs.getInt("OrderHistoryID"));
        order.setUserId(rs.getInt("UserID"));
        order.setOrderId(rs.getString("OrderID"));
        order.setRestaurantName(rs.getString("RestaurantName"));
        order.setMenuItems(rs.getString("MenuItems"));
        order.setOrderDate(rs.getTimestamp("OrderDate"));
        order.setTotalAmount(rs.getDouble("TotalAmount"));
        order.setStatus(rs.getString("Status"));
        return order;
    }
}
