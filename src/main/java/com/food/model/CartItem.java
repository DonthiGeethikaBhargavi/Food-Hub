package com.food.model;
import java.io.Serializable;
public class CartItem implements Serializable  {
	private static final long serialVersionUID = 1L;

	private int menuId;
	private int restaurantId;
	private String name;
	private int quantity;
	private double price;
	private String image;
	
	
	public CartItem() {
		// TODO Auto-generated constructor stub
	}
	
	public CartItem(int menuId, int restaurantId, String name, int quantity, double price, String image) {
		super();
		this.menuId = menuId;
		this.restaurantId = restaurantId;
		this.name = name;
		this.quantity = quantity;
		this.price = price;
		this.image = image;
	}

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}
	
	public int getRestaurantId() {
		return restaurantId;
	}


	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}


	public double getPrice() {
		return price;
	}


	public void setPrice(double price) {
		this.price = price;
	}

	public String getImage() {
		return image;
	}


	public void setImage(String image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return "CartItem [menuId=" + menuId + ", restaurantId=" + restaurantId + ", name=" + name
				+ ", quantity=" + quantity + ", price=" + price + ", image=" + image + "]";
	}


	

		
	
}