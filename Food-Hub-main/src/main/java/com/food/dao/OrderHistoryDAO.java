package com.food.dao;

import com.food.model.OrderHistory;
import java.util.List;

public interface OrderHistoryDAO {

    // Retrieve order histories by User ID
    List<OrderHistory> getOrderHistoriesByUser(int userId);

    // Retrieve all order histories
    List<OrderHistory> getAllOrderHistories();

    // Retrieve a specific order history by its ID
    OrderHistory getOrderHistoryById(int orderHistoryId);

    // Add a new order history entry
    boolean addOrderHistory(OrderHistory order);

    // Update order status (e.g., Delivered, Cancelled, Returned)
    boolean updateOrderStatus(int orderHistoryId, String status);

    // Delete an order history entry
    boolean deleteOrderHistory(int orderHistoryId);
}
