package com.food.model;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Integer, CartItem> items;

    public Cart() {
        items = new HashMap<>();
    }

    public void addItem(CartItem ci) {
        if (items.containsKey(ci.getMenuId())) {
            CartItem existingItem = items.get(ci.getMenuId());
            existingItem.setQuantity(existingItem.getQuantity() + ci.getQuantity());
        } else {
            items.put(ci.getMenuId(), ci);
        }
    }

    public void updateItem(int itemId, int quantity) {
        if (items.containsKey(itemId)) {
            if (quantity > 0) {
                items.get(itemId).setQuantity(quantity);
            } else {
                removeItem(itemId);
            }
        }
    }

    public void removeItem(int itemId) {
        items.remove(itemId);
    }

    public Map<Integer, CartItem> getItems() {
        return new HashMap<>(items); // Returning a copy to prevent external modification
    }

    public void clear() {
        items.clear();
    }

	


    
}
