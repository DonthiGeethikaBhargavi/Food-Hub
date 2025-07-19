package com.food.dao;

import java.util.List;

import com.food.model.Order;

public interface OrderDAO {
 void addOrder(Order order);
 Order getOrder(String orderId);
 void  updateOrder(Order order);
 void  deleteOrder(String orderId);
 List<Order> getAllOrdersByUser(int userId);
 List<Order> getAllOrders();
 List<Order> getOrdersByRestaurantId(int restaurantId);
 void updateOrderStatus(String orderId, String newStatus);

}
