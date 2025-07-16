package com.food.servlet;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.MessageDigest;
import com.food.dao.UserDAO;
import com.food.daoImpl.UserDAOImpl;
import com.food.model.User;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAOImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = "Customer"; // Default role for new users
        
        // Validate input
        if (name == null || username == null || email == null || password == null || phone == null || 
        	    name.trim().isEmpty() || username.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty() || phone.trim().isEmpty()) {
        	    request.setAttribute("error", "All fields are required.");
        	    request.getRequestDispatcher("signup.jsp").forward(request, response);
        	    return;
        	}

        	// ✅ Gmail Email validation
        	if (!email.matches("^[a-zA-Z0-9._%+-]+@gmail\\.com$")) {
        	    request.setAttribute("error", "Only Gmail addresses are allowed.");
        	    request.getRequestDispatcher("signup.jsp").forward(request, response);
        	    return;
        	}


        // Check if username already exists
        if (userDAO.getUserByUsername(username) != null) {
            request.setAttribute("error", "Username is already taken. Please choose another.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }
     // ✅ Phone Number validation
        if (!phone.matches("\\d{10}")) {
            request.setAttribute("error", "Phone number must be exactly 10 digits.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        // Password strength check (at least 6 characters)
        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters long.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }
        

        // Create user object
        String hashedPassword = hashPassword(password);
        User newUser = new User(0, name, username, hashedPassword, email, phone, address, role);

        
        try {
            userDAO.addUser(newUser);
            request.setAttribute("message", "Signup successful! Please log in.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Something went wrong. Please try again later.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method is not supported for signup.");
    }
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder hex = new StringBuilder();
            for (byte b : hash) {
                hex.append(String.format("%02x", b));
            }
            return hex.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return password; // fallback (not recommended)
        }
    }

}
