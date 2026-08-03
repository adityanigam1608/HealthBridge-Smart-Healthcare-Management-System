package com.healthbridge.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.healthbridge.db.DBConnection;
import com.healthbridge.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/review")
public class ReviewServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("currentUser");

        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO reviews(patient_id, doctor_id, rating, comment) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, user.getId());
            ps.setInt(2, doctorId);
            ps.setInt(3, rating);
            ps.setString(4, comment);

            ps.executeUpdate();

            response.sendRedirect("patient-dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("review.jsp");
        }
    }
}