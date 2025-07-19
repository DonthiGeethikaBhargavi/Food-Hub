package com.food.servlet;

import com.food.dao.UserDAO;
import com.food.daoImpl.UserDAOImpl;
import com.food.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AdminManagementServlet")
public class AdminManagementServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Ensure only SystemAdmin can call this servlet
        HttpSession session = req.getSession(false);
        User current = (session != null) ? (User) session.getAttribute("user") : null;
        if (current == null || !"SystemAdmin".equalsIgnoreCase(current.getRole())) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");

        try {
            switch (action) {
                case "addAdmin"   -> addAdmin(req);
                case "editAdmin"  -> editAdmin(req);
                case "deleteAdmin"-> deleteAdmin(req);
                default           -> System.out.println("⚠️ Unknown action: " + action);
            }
        } catch (Exception e) {
            e.printStackTrace();   // you may log this instead
        }

        // Always refresh dashboard
        resp.sendRedirect("AdminDashboardServlet");
    }

    /* ---------- Helpers ---------- */

    private void addAdmin(HttpServletRequest req) {
        User admin = new User();
        admin.setName(req.getParameter("name"));
        admin.setUsername(req.getParameter("username"));
        admin.setPassword(req.getParameter("password")); // 🔑 Hash in prod
        admin.setEmail(req.getParameter("email"));
        admin.setPhone(req.getParameter("phone"));
        admin.setRestaurantId(Integer.parseInt(req.getParameter("restaurantId")));
        admin.setRole("RestaurantAdmin");

        userDAO.addUser(admin);
        System.out.println("➕ Added new RestaurantAdmin: " + admin.getUsername());
    }

    private void editAdmin(HttpServletRequest req) {
        int userId = Integer.parseInt(req.getParameter("userId"));
        User admin = userDAO.getUser(userId);
        if (admin == null) return;

        admin.setName(req.getParameter("name"));
        admin.setEmail(req.getParameter("email"));
        admin.setPhone(req.getParameter("phone"));
        admin.setRestaurantId(Integer.parseInt(req.getParameter("restaurantId")));

        userDAO.updateUser(admin);
        System.out.println("✏️ Updated RestaurantAdmin ID: " + userId);
    }

    private void deleteAdmin(HttpServletRequest req) {
        int userId = Integer.parseInt(req.getParameter("userId"));
        userDAO.deleteUser(userId);
        System.out.println("🗑️ Deleted RestaurantAdmin ID: " + userId);
    }
}
