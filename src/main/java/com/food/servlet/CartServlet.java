package com.food.servlet;

import com.food.model.Cart;
import com.food.model.CartItem;
import com.food.model.Menu;
import com.food.daoImpl.MenuDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                int menuId = parseIntParam(request, response, "menuId");
                int restaurantId = parseIntParam(request, response, "restaurantId");
                int quantity = parseIntParam(request, response, "quantity");

                if (!cart.getItems().isEmpty()) {
                    int existingRestaurantId = cart.getItems().values().iterator().next().getRestaurantId();
                    if (existingRestaurantId != restaurantId) {
                        response.sendRedirect("cart.jsp?error=different_restaurant&restaurantId=" + restaurantId);
                        return;
                    }
                }

                MenuDAOImpl menuDAO = new MenuDAOImpl();
                Menu menuItem = menuDAO.getMenu(menuId);
                if (menuItem != null) {
                    cart.addItem(new CartItem(menuId, restaurantId, menuItem.getItemName(), quantity, menuItem.getPrice(), menuItem.getImagePath()));
                }
            } else if ("remove".equals(action)) {
                int menuId = parseIntParam(request, response, "menuId");
                cart.removeItem(menuId);
            } else if ("update".equals(action)) {
                int menuId = parseIntParam(request, response, "menuId");
                int quantity = parseIntParam(request, response, "quantity");

                if (quantity > 0) {
                    cart.updateItem(menuId, quantity);
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Quantity must be greater than 0");
                    return;
                }
            } else if ("clear".equals(action)) {
                cart.clear();
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
            return;
        }

        session.setAttribute("cart", cart);
        redirectToAppropriatePage(request, response);
    }

    /**
     * Utility method to parse integer parameters safely.
     */
    private int parseIntParam(HttpServletRequest request, HttpServletResponse response, String paramName) throws IOException {
        String paramValue = request.getParameter(paramName);
        if (paramValue == null || paramValue.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameter: " + paramName);
            throw new NumberFormatException("Invalid parameter: " + paramName);
        }
        return Integer.parseInt(paramValue);
    }

    /**
     * Utility method to handle redirection logic.
     */
    private void redirectToAppropriatePage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String restaurantIdParam = request.getParameter("restaurantId");
        int restaurantId = (restaurantIdParam != null && !restaurantIdParam.isEmpty()) ? Integer.parseInt(restaurantIdParam) : -1;
        String redirectPage = request.getParameter("redirect");

        if ("true".equals(redirectPage)) {
            response.sendRedirect(restaurantId != -1 ? "MenuServlet?restaurantId=" + restaurantId : "MenuServlet");
        } else {
            response.sendRedirect(restaurantId != -1 ? "cart.jsp?restaurantId=" + restaurantId : "cart.jsp");
        }
    }
}
