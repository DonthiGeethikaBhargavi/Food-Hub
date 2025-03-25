package com.food.model;

public class Restaurant {
 private int restaurantId;
 private String name;
 private String address;
 private double rating;
 private String cuisineType;
 private boolean isActive;
 private int adminUserId;
 private String imagePath;
 private int estimateddeliveryTime;

 public Restaurant() {
	// TODO Auto-generated constructor stub
}

public Restaurant(int restaurantId, String name, String address, double rating, String cuisineType, boolean isActive,
		int adminUserId, String imagePath, int estimateddeliveryTime) {
	super();
	this.restaurantId = restaurantId;
	this.name = name;
	this.address = address;
	this.rating = rating;
	this.cuisineType = cuisineType;
	this.isActive = isActive;
	this.adminUserId = adminUserId;
	this.imagePath = imagePath;
	this.estimateddeliveryTime = estimateddeliveryTime;
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

public String getAddress() {
	return address;
}

public void setAddress(String address) {
	this.address = address;
}

public double getRating() {
	return rating;
}

public void setRating(double rating) {
	this.rating = rating;
}

public String getCuisineType() {
	return cuisineType;
}

public void setCuisineType(String cuisineType) {
	this.cuisineType = cuisineType;
}

public boolean isActive() {
	return isActive;
}

public void setActive(boolean isActive) {
	this.isActive = isActive;
}

public int getAdminUserId() {
	return adminUserId;
}

public void setAdminUserId(int adminUserId) {
	this.adminUserId = adminUserId;
}

public String getImagePath() {
	return imagePath;
}

public void setImagePath(String imagePath) {
	this.imagePath = imagePath;
}

public int getEstimateddeliveryTime() {
	return estimateddeliveryTime;
}

public void setEstimateddeliveryTime(int estimateddeliveryTime) {
	this.estimateddeliveryTime = estimateddeliveryTime;
}
 
}
