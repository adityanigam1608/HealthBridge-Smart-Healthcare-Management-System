package com.healthbridge.servlet;

import java.io.IOException;

import com.healthbridge.dao.UserDAO;
import com.healthbridge.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.loginUser(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            if ("doctor".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("doctor-dashboard.jsp");
            } else {
                response.sendRedirect("patient-dashboard.jsp");
            }

        } else {
            response.sendRedirect("login.jsp?msg=invalid");
        }
    }
}