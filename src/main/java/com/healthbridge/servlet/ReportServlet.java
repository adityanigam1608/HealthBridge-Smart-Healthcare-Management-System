package com.healthbridge.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.healthbridge.db.DBConnection;
import com.healthbridge.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/uploadReport")
public class ReportServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User doctor = (User) session.getAttribute("currentUser");

        int patientId = Integer.parseInt(request.getParameter("patientId"));
        String reportName = request.getParameter("reportName");
        String filePath = request.getParameter("filePath");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO reports(patient_id, doctor_id, report_name, file_path) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, patientId);
            ps.setInt(2, doctor.getId());
            ps.setString(3, reportName);
            ps.setString(4, filePath);

            ps.executeUpdate();

            response.sendRedirect("doctor-dashboard.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("upload-report.jsp");
        }
    }
}