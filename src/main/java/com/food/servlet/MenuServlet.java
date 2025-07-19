package com.food.servlet;

import com.food.daoImpl.MenuDAOImpl;
import com.food.daoImpl.RestaurantDAOImpl;
import com.food.model.Menu;
import com.food.model.Restaurant;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/MenuServlet")
@MultipartConfig( // ✅ This tells Tomcat to expect file uploads
	    fileSizeThreshold = 1024 * 1024 * 1, // 1MB in memory before written to disk
	    maxFileSize = 1024 * 1024 * 10,      // 10MB max file size
	    maxRequestSize = 1024 * 1024 * 15    // 15MB total request size
	)
public class MenuServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            // Ensure restaurantId is provided and valid
            String restaurantIdParam = request.getParameter("restaurantId");
            if (restaurantIdParam == null || restaurantIdParam.isEmpty()) {
                response.sendRedirect("Home"); // Redirect to Home if no ID
                return;
            }

            String restaurantIdStr = request.getParameter("restaurantId");
            int restaurantId = 0;
            if (restaurantIdStr != null && !restaurantIdStr.isEmpty()) {
                try {
                    restaurantId = Integer.parseInt(restaurantIdStr);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                    response.sendRedirect("error.jsp");
                    return;
                }
            } else {
                response.sendRedirect("error.jsp");
                return;
            }


            // Fetch restaurant details
            RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
            Restaurant restaurant = restaurantDAO.getRestaurant(restaurantId);

            // Check if restaurant exists
            if (restaurant == null) {
                response.sendRedirect("error.jsp"); // Redirect if restaurant not found
                return;
            }

            // Store restaurant in session to persist when navigating
            session.setAttribute("restaurant", restaurant);

            // Fetch menu items for the restaurant
            MenuDAOImpl menuDAO = new MenuDAOImpl();
            List<Menu> menuList = menuDAO.getAllMenusByRestaurant(restaurantId);

            // Set attributes to pass to JSP
            request.setAttribute("menuList", menuList);

            // Forward to menu.jsp
            request.getRequestDispatcher("menu.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("Home"); // Redirect to Home if ID is invalid
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect on general error
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = null;
        int restaurantId = 0;
        String itemName = null;
        String description = null;
        double price = 0.0;
        String imagePath = null;

        MenuDAOImpl menuDAO = new MenuDAOImpl();

        try {
            // Parse multipart/form-data
            if (request.getContentType() != null && request.getContentType().startsWith("multipart/form-data")) {
                // Setup file upload
                String uploadPath = getServletContext().getRealPath("/") + "uploads";
                java.io.File uploadDir = new java.io.File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                javax.servlet.http.Part imagePart = request.getPart("image");
                String fileName = java.nio.file.Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                if (!fileName.isEmpty()) {
                    String imageSavePath = "uploads/" + System.currentTimeMillis() + "_" + fileName;
                    imagePart.write(uploadPath + "/" + System.currentTimeMillis() + "_" + fileName);
                    imagePath = imageSavePath;
                }

                action = request.getParameter("action");
                restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
                itemName = request.getParameter("itemName");
                description = request.getParameter("description");
                price = Double.parseDouble(request.getParameter("price"));

                switch (action) {
                    case "add":
                        Menu newMenu = new Menu();
                        newMenu.setRestaurantId(restaurantId);
                        newMenu.setItemName(itemName);
                        newMenu.setDescription(description);
                        newMenu.setPrice(price);
                        newMenu.setImagePath(imagePath != null ? imagePath : "");
                        menuDAO.addMenu(newMenu);
                        break;

                    case "update":
                        int menuId = Integer.parseInt(request.getParameter("menuId"));
                        Menu updateMenu = new Menu();
                        updateMenu.setMenuId(menuId);
                        updateMenu.setItemName(itemName);
                        updateMenu.setDescription(description);
                        updateMenu.setPrice(price);
                        updateMenu.setAvailable(true); // or use logic if there's a checkbox

                     // Get the previous image path if no new image was uploaded
                        if (imagePath != null && !imagePath.isEmpty()) {
                            updateMenu.setImagePath(imagePath);
                        } else {
                            // Fetch existing menu to get old image path
                            Menu existingMenu = menuDAO.getMenu(menuId);
                            if (existingMenu != null) {
                                updateMenu.setImagePath(existingMenu.getImagePath());
                            }
                        }


                    case "delete":
                        int deleteId = Integer.parseInt(request.getParameter("menuId"));
                        menuDAO.deleteMenu(deleteId);
                        break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/OwnerDashboardServlet");
    }

}
