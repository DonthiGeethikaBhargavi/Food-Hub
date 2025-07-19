package com.food.daoImpl;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.food.dao.MenuDAO;
import com.food.model.Menu;
import com.food.utility.DBConnection;

public class MenuDAOImpl implements MenuDAO {

    @Override
    public void addMenu(Menu menu) {
        String sql = "INSERT INTO Menu (RestaurantId, ItemName, Description, Price,  IsAvailable, ImagePath) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, menu.getRestaurantId());
            stmt.setString(2, menu.getItemName());
            stmt.setString(3, menu.getDescription());
            stmt.setDouble(4, menu.getPrice());   
            stmt.setBoolean(5, menu.isAvailable());
            stmt.setString(6, menu.getImagePath());
            stmt.executeUpdate();

            ResultSet generatedKeys = stmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                menu.setMenuId(generatedKeys.getInt(1));
            }
            System.out.println("Menu item added successfully! Menu ID: " + menu.getMenuId());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public Menu getMenu(int menuId) {
        String sql = "SELECT * FROM Menu WHERE MenuId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, menuId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Menu(
                        rs.getInt("MenuId"),
                        rs.getInt("RestaurantId"),
                        rs.getString("ItemName"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getBoolean("IsAvailable"),
                        rs.getString("ImagePath")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateMenu(Menu menu) {
        String sql = "UPDATE Menu SET ItemName = ?, Description = ?, Price = ?, IsAvailable = ?, ImagePath = ? WHERE MenuId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
			/* stmt.setInt(1, menu.getRestaurantId()); */
            stmt.setString(1, menu.getItemName());
            stmt.setString(2, menu.getDescription());
            stmt.setDouble(3, menu.getPrice());
            stmt.setBoolean(4, menu.isAvailable());
            stmt.setString(5, menu.getImagePath());
            stmt.setInt(6, menu.getMenuId());
            stmt.executeUpdate();
            System.out.println("Menu item updated successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteMenu(int menuId) {
        String sql = "DELETE FROM Menu WHERE MenuId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, menuId);
            stmt.executeUpdate();
            System.out.println("Menu item deleted successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Menu> getAllMenusByRestaurant(int restaurantId) {
        List<Menu> menus = new ArrayList<>();
        String sql = "SELECT * FROM Menu WHERE RestaurantId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, restaurantId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                menus.add(new Menu(
                        rs.getInt("MenuId"),
                        rs.getInt("RestaurantId"),
                        rs.getString("ItemName"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getBoolean("IsAvailable"),
                        rs.getString("ImagePath")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menus;
    }

    @Override
    public List<Menu> getAllMenu() {
        List<Menu> menus = new ArrayList<>();
        String sql = "SELECT * FROM Menu";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                menus.add(new Menu(
                        rs.getInt("MenuId"),
                        rs.getInt("RestaurantId"),
                        rs.getString("ItemName"),
                        rs.getString("Description"),
                        rs.getDouble("Price"),
                        rs.getBoolean("IsAvailable"),
                        rs.getString("ImagePath")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menus;
    }
}