package com.food.daoImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.food.dao.RestaurantDAO;
import com.food.model.Restaurant;
import com.food.utility.DBConnection;

public class RestaurantDAOImpl implements RestaurantDAO {

    @Override
    public void addRestaurant(Restaurant restaurant) {
        String sql = "INSERT INTO Restaurant (Name, Address, Rating, CuisineType, IsActive, AdminUserId, ImagePath, EstimatedDeliveryTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, restaurant.getName());
            stmt.setString(2, restaurant.getAddress());
            stmt.setDouble(3, restaurant.getRating());
            stmt.setString(4, restaurant.getCuisineType());
            stmt.setBoolean(5, restaurant.isActive());
            stmt.setInt(6, restaurant.getAdminUserId());
            stmt.setString(7, restaurant.getImagePath());
            stmt.setInt(8, restaurant.getEstimateddeliveryTime());
            stmt.executeUpdate();
            System.out.println("Restaurant added successfully!");
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Restaurant getRestaurant(int restaurantId) {
        String sql = "SELECT * FROM Restaurant WHERE RestaurantId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, restaurantId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Restaurant(
                        rs.getInt("RestaurantId"),
                        rs.getString("Name"),
                        rs.getString("Address"),
                        rs.getDouble("Rating"),
                        rs.getString("CuisineType"),
                        rs.getBoolean("IsActive"),
                        rs.getInt("AdminUserId"),
                        rs.getString("ImagePath"),
                        rs.getInt("EstimatedDeliveryTime")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateRestaurant(Restaurant restaurant) {
        String sql = "UPDATE Restaurant SET Name = ?, Address = ?, Rating = ?, CuisineType = ?, IsActive = ?, AdminUserId = ?, ImagePath = ?, EstimatedDeliveryTime = ? WHERE RestaurantId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, restaurant.getName());
            stmt.setString(2, restaurant.getAddress());
            stmt.setDouble(3, restaurant.getRating());
            stmt.setString(4, restaurant.getCuisineType());
            stmt.setBoolean(5, restaurant.isActive());
            stmt.setInt(6, restaurant.getAdminUserId());
            stmt.setString(7, restaurant.getImagePath());
            stmt.setInt(8, restaurant.getEstimateddeliveryTime());
            stmt.setInt(9, restaurant.getRestaurantId());
            stmt.executeUpdate();
            System.out.println("Restaurant updated successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteRestaurant(int restaurantId) {
        String sql = "DELETE FROM Restaurant WHERE RestaurantId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, restaurantId);
            stmt.executeUpdate();
            System.out.println("Restaurant deleted successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String sql = "SELECT * FROM Restaurant";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                restaurants.add(new Restaurant(
                        rs.getInt("RestaurantId"),
                        rs.getString("Name"),
                        rs.getString("Address"),
                        rs.getDouble("Rating"),
                        rs.getString("CuisineType"),
                        rs.getBoolean("IsActive"),
                        rs.getInt("AdminUserId"),
                        rs.getString("ImagePath"),
                        rs.getInt("EstimatedDeliveryTime")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }
    @Override
    public List<Restaurant> getRestaurantsByMenuItem(int menuId) {
        List<Restaurant> restaurants = new ArrayList<>();
        
        String sql = "SELECT DISTINCT r.* FROM Restaurant r " +
                     "JOIN Menu m ON r.RestaurantId = m.RestaurantId " +
                     "WHERE m.MenuId = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, menuId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Restaurant restaurant = new Restaurant(
                    rs.getInt("RestaurantId"),
                    rs.getString("Name"),
                    rs.getString("Address"),
                    rs.getDouble("Rating"),
                    rs.getString("CuisineType"),
                    rs.getBoolean("IsActive"),
                    rs.getInt("AdminUserId"),
                    rs.getString("ImagePath"),
                    rs.getInt("EstimatedDeliveryTime")
                );
                restaurants.add(restaurant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return restaurants;
    }
}
