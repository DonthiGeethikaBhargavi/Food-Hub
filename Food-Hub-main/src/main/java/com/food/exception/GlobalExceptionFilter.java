package com.food.exception;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Global Exception Handling and 404 Error Filter
 */
@WebFilter("/*") // Apply filter to all requests
public class GlobalExceptionFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        try {
            chain.doFilter(request, response); // Process request first

            // **Check for 404 Error**
            if (res.getStatus() == HttpServletResponse.SC_NOT_FOUND && !res.isCommitted()) {
                req.setAttribute("errorCode", 404);
                req.setAttribute("errorMessage", "The requested page was not found.");
                RequestDispatcher dispatcher = req.getRequestDispatcher("/ErrorHandler");
                dispatcher.forward(req, res);
            }

        } catch (Exception e) {
            e.printStackTrace();

            // Ensure response is not committed before forwarding
            if (!res.isCommitted()) {
                req.setAttribute("errorCode", HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                req.setAttribute("errorMessage", "Internal Server Error. Please try again later.");
                req.setAttribute("exception", e);
                RequestDispatcher dispatcher = req.getRequestDispatcher("/ErrorHandler");
                dispatcher.forward(req, res);
            } else {
                System.err.println("❗Response already committed, cannot forward.");
            }
        }
    }
}
