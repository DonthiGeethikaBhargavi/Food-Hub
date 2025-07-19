package com.food.exception;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Custom Error Handler Servlet
 */
@WebServlet("/ErrorHandler")
public class CustomErrorHandler extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleError(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleError(request, response);
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Integer statusCode = (Integer) request.getAttribute("errorCode");
        String errorMessage = (String) request.getAttribute("errorMessage");
        Throwable exception = (Throwable) request.getAttribute("exception");

        if (statusCode == null) {
            statusCode = response.getStatus();
        }
        if (errorMessage == null) {
            errorMessage = getErrorMessage(statusCode);
        }

        request.setAttribute("errorCode", statusCode);
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("exception", exception);

        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }

    private String getErrorMessage(Integer statusCode) {
        switch (statusCode) {
            case 404: return "The requested page was not found.";
            case 500: return "Internal Server Error. Please try again later.";
            default: return "Oops! Something went wrong.";
        }
    }
}
