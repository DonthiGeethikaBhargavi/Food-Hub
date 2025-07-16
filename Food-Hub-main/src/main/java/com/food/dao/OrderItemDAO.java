package com.food.dao;

import java.util.List;

import com.food.model.OrderItem;
public interface OrderItemDAO {
   void addOrderItem(OrderItem orderItem);
   OrderItem getOrderItem(int orderitemId);
   void updateOrderItem(OrderItem orderItem);
   void deleteOrderItem(int orderItemId);
   List<OrderItem> getOrderItemsByOrder(int orderId);
}
