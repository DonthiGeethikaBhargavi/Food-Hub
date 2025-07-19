package com.food.utility;

import java.security.SecureRandom;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class OrderIdUpdater {
    private static final String PREFIX = "ORDFH"; // Food Hub Prefix
    private static final String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private static final Random RANDOM = new SecureRandom();

    // Database credentials (Change as per your DB setup)
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fooddeliveryapp";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "root";

    public static void main(String[] args) {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            conn.setAutoCommit(false); // Enable transaction handling
            updateOrderIds(conn);
            conn.commit(); // Commit all updates together for efficiency
            System.out.println("✅ All Order IDs updated successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void updateOrderIds(Connection conn) throws SQLException {
        String fetchOrdersQuery = "SELECT o.orderid, u.name AS user_name, r.name AS restaurant_name " +
                                  "FROM ordertable o " +
                                  "JOIN user u ON o.userid = u.userid " +
                                  "JOIN restaurant r ON o.restaurantid = r.restaurantid";

        try (PreparedStatement stmt = conn.prepareStatement(fetchOrdersQuery);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                String oldOrderId = rs.getString("orderid");
                String userName = rs.getString("user_name");
                String restaurantName = rs.getString("restaurant_name");

                // ✅ Generate a new unique Order ID
                String newOrderId = generateUniqueOrderId(restaurantName, userName);

                // ✅ Update Order ID across all relevant tables in a batch
                updateOrderTables(conn, oldOrderId, newOrderId);

                System.out.println("✅ Updated Order ID: " + oldOrderId + " → " + newOrderId);
            }
        }
    }

    private static void updateOrderTables(Connection conn, String oldOrderId, String newOrderId) throws SQLException {
        String[] updateQueries = {
            "UPDATE `ordertable` SET orderid = ? WHERE orderid = ?",
            "UPDATE `orderitem` SET orderid = ? WHERE orderid = ?",
            "UPDATE `orderhistory` SET orderid = ? WHERE orderid = ?"
        };

        try {
            for (String query : updateQueries) {
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, newOrderId);
                    stmt.setString(2, oldOrderId);
                    stmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            conn.rollback(); // Rollback all changes if an error occurs
            throw new SQLException("❌ Error updating Order IDs: " + e.getMessage(), e);
        }
    }

    // 🔹 Order ID Generator (Example Format: ORDFHIBESMAR7XQZ)
    public static String generateUniqueOrderId(String restaurantName, String userName) {
        // Extract initials from restaurant and user name
        String restaurantInitials = extractInitials(restaurantName, 2); // e.g., "Italian Bistro" → "IB"
        String userInitials = extractInitials(userName, 2); // e.g., "Emma Smith" → "ES"

        // Get month abbreviation (e.g., "MAR" for March)
        String monthAbbreviation = new SimpleDateFormat("MMM").format(new Date()).toUpperCase();

        // Generate random alphanumeric sequence
        String randomPart = generateRandomString(4); // Ensuring uniqueness

        // Generate unique ID (Example: ORDFHIBESMAR7XQZ)
        return String.format("%s%s%s%s%s", PREFIX, restaurantInitials, userInitials, monthAbbreviation, randomPart);
    }

    private static String extractInitials(String name, int length) {
        if (name == null || name.trim().isEmpty()) return "XX"; // Default if no name available
        String[] words = name.trim().split("\\s+"); // Split by spaces
        StringBuilder initials = new StringBuilder();
        for (String word : words) {
            if (!word.isEmpty() && initials.length() < length) {
                initials.append(word.charAt(0));
            }
        }
        while (initials.length() < length) {
            initials.append("X"); // Fill with 'X' if not enough initials
        }
        return initials.toString().toUpperCase();
    }

    private static String generateRandomString(int length) {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(ALPHABET.charAt(RANDOM.nextInt(ALPHABET.length())));
        }
        return sb.toString();
    }
}
