package com.food.daoImpl;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.food.dao.UserDAO;
import com.food.model.User;
import com.food.utility.DBConnection;

public class UserDAOImpl implements UserDAO {
    private static final String INSERT_USER_QUERY = "INSERT INTO User (name, Username, Password, Email, Phone, Address, Role) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String GET_USER_QUERY = "SELECT * FROM User WHERE UserId = ?";
    private static final String UPDATE_USER_QUERY = "UPDATE User SET name = ?, Password = ?, Phone = ?, Address = ?, Role = ? WHERE UserId = ?";
    private static final String DELETE_USER_QUERY = "DELETE FROM User WHERE UserId = ?";
    private static final String GET_ALL_USERS_QUERY = "SELECT * FROM User";
    private static final String VALIDATE_USER_QUERY = "SELECT Password FROM User WHERE Username = ?";

    @Override
    public void addUser(User user) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(INSERT_USER_QUERY)) {

            String hashedPassword = hashPassword(user.getPassword()); // Hash password before saving

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, hashedPassword);
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getAddress());
            stmt.setString(7, user.getRole());
            System.out.println("🔐 Hashed password saved: " + hashedPassword);

            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error adding user: " + e.getMessage());
        }
    }

    @Override
    public boolean validateUser(String username, String password) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(VALIDATE_USER_QUERY)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String storedHashedPassword = rs.getString("Password");
                    System.out.println("🔑 Username: " + username);
                  System.out.println("Entered Password: " + password);
                 System.out.println("Hashed Entered Password: " + hashPassword(password));
                 System.out.println("Stored Hashed Password from DB: " + storedHashedPassword);

                    return storedHashedPassword.equals(hashPassword(password)); // Compare hashed passwords
                }
            }
        } catch (SQLException e) {
            System.err.println("Error validating user: " + e.getMessage());
        }
        return false;
    }

    @Override
    public User getUser(int userId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(GET_USER_QUERY)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	return mapRowToUser(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving user: " + e.getMessage());
        }
        return null;
    }

    @Override
    public void updateUser(User user) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(UPDATE_USER_QUERY)) {

            String hashedPassword = hashPassword(user.getPassword());

            stmt.setString(1, user.getName());
            stmt.setString(2, hashedPassword);
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getRole());
            stmt.setInt(6, user.getUserId());

            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
        }
    }

    @Override
    public void deleteUser(int userId) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(DELETE_USER_QUERY)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
        }
    }

    @Override
    public List<User> getAllUsers() {
        List<User> usersList = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(GET_ALL_USERS_QUERY)) {
            while (rs.next()) {
            	usersList.add(mapRowToUser(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error fetching all users: " + e.getMessage());
        }
        return usersList;
    }

    @Override
    public User getUserByUsername(String username) {
        String query = "SELECT * FROM User WHERE Username = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                	return mapRowToUser(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving user by username: " + e.getMessage());
        }
        return null;
    }

    private String hashPassword(String password) {
    try {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashedBytes = md.digest(password.getBytes(StandardCharsets.UTF_8)); 
        StringBuilder sb = new StringBuilder();
        for (byte b : hashedBytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    } catch (NoSuchAlgorithmException e) {
        throw new RuntimeException("Error hashing password", e);
    }
}

    @Override
    public List<User> getUsersByRole(String role) {
        List<User> usersList = new ArrayList<>();
        String query = "SELECT * FROM User WHERE Role = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, role);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                	 usersList.add(mapRowToUser(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching users by role: " + e.getMessage());
        }
        return usersList;
    }
    @Override
    public void assignRestaurantToOwner(int userId, int restaurantId) {
        String query = "UPDATE User SET Restaurant_Id = ?, Role = 'RestaurantAdmin' WHERE UserId = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, restaurantId);
            stmt.setInt(2, userId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.err.println("Error assigning restaurant to owner: " + e.getMessage());
        }
        
    }
    
    /** Map a ResultSet row to a User object, including restaurantId (can be null). */
    private User mapRowToUser(ResultSet rs) throws SQLException {
        User user = new User(
            rs.getInt("UserId"),
            rs.getString("name"),
            rs.getString("Username"),
            rs.getString("Password"),
            rs.getString("Email"),
            rs.getString("Phone"),
            rs.getString("Address"),
            rs.getString("Role")
        );
        // NEW: set restaurantId only if column exists / is not NULL
        Object restIdObj = rs.getObject("Restaurant_Id");
        if (restIdObj != null) {
            user.setRestaurantId(((Number) restIdObj).intValue());
        }
        return user;
    }
 

}
