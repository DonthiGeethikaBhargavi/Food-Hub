package com.food.utility;

import java.security.SecureRandom;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class OrderIdGenerator {
    private static final String PREFIX = "ORDFH"; // Food Hub Prefix
    private static final String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private static final Random RANDOM = new SecureRandom();

    public static String generateOrderId(int userId, int restaurantId) {
        String userName = "";
        String restaurantName = "";

        // ✅ Corrected SQL query with column aliases
        String query = "SELECT u.name AS user_name, r.name AS restaurant_name " +
                       "FROM user u " +
                       "JOIN restaurant r ON r.restaurantid = ? " +
                       "WHERE u.userid = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, restaurantId);
            stmt.setInt(2, userId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                userName = rs.getString("user_name"); // ✅ Correct column alias usage
                restaurantName = rs.getString("restaurant_name"); // ✅ Correct column alias usage
            }
        } catch (SQLException e) {
            System.err.println("Database error while fetching user and restaurant names: " + e.getMessage());
            e.printStackTrace();
        }

        // ✅ Extract initials safely
        String userInitials = extractInitials(userName, 2);
        String restaurantInitials = extractInitials(restaurantName, 2);

        // ✅ Get current month abbreviation
        String monthAbbreviation = new SimpleDateFormat("MMM").format(new Date()).toUpperCase();

        // ✅ Generate random alphanumeric string
        String randomPart = generateRandomString(4);

        // ✅ Construct and return the unique Order ID
        return PREFIX + restaurantInitials + userInitials + monthAbbreviation + randomPart;
    }

    /**
     * Extracts initials from a given name.
     * If the name is empty, returns "XX" as default.
     */
    private static String extractInitials(String name, int length) {
        if (name == null || name.trim().isEmpty()) return "XX"; // Default if name is missing
        String[] words = name.trim().split("\\s+");
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

    /**
     * Generates a random alphanumeric string of given length.
     */
    private static String generateRandomString(int length) {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(ALPHABET.charAt(RANDOM.nextInt(ALPHABET.length())));
        }
        return sb.toString();
    }
}
