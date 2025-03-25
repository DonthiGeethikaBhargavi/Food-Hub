package com.food.dao;

import com.food.model.Cart;
import java.util.List;

public interface CartDAO {
    void addToCart(Cart cart);
    List<Cart> getCartItems(int userId);
    void updateCartItem(int cartId, int quantity);
    void removeCartItem(int cartId);
    void clearCart(int userId);
}
