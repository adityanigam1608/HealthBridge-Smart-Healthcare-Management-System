package com.healthbridge.servlet;

import java.io.IOException;

import com.healthbridge.dao.AppointmentDAO;
import com.healthbridge.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/updateAppointment")
public class UpdateAppointmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User doctor = (User) session.getAttribute("currentUser");

        if (!"doctor".equalsIgnoreCase(doctor.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int appointmentId = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        if (!"Approved".equalsIgnoreCase(status) && !"Rejected".equalsIgnoreCase(status)) {
            response.sendRedirect("doctor-dashboard.jsp");
            return;
        }

        AppointmentDAO dao = new AppointmentDAO();
        dao.updateAppointmentStatus(appointmentId, doctor.getId(), status);

        response.sendRedirect("doctor-dashboard.jsp");
    }
}