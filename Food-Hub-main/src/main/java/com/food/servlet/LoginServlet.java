package com.food.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.food.dao.UserDAO;
import com.food.daoImpl.UserDAOImpl;
import com.food.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAOImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        // Validate user credentials
        if (userDAO.validateUser(username, password)) {
            User user = userDAO.getUserByUsername(username); // Fetch full User object
           
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user); // Store User object in session
             // ✅ Debug logs
                System.out.println("✅ Login Success");
                System.out.println("User: " + user.getUsername());
                System.out.println("Role: " + user.getRole());
             // 🧠 Redirect based on role
                String role = user.getRole();

                if ("SystemAdmin".equalsIgnoreCase(role)) {
                    response.sendRedirect("AdminDashboardServlet");
                } else if ("RestaurantAdmin".equalsIgnoreCase(role)) {
                    response.sendRedirect("OwnerDashboardServlet"); // ✅ Servlet URL
                }
             else { // Default to customer
                	response.sendRedirect("Home"); // Redirect to home page
                }
                
            } else {
                request.setAttribute("error", "User not found. Please try again.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
