package com.healthbridge.servlet;

import java.io.IOException;

import com.healthbridge.dao.AppointmentDAO;
import com.healthbridge.model.Appointment;
import com.healthbridge.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/bookAppointment")
public class AppointmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("currentUser");

        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        String appointmentDate = request.getParameter("appointmentDate");

        Appointment appointment = new Appointment();
        appointment.setPatientId(user.getId());
        appointment.setDoctorId(doctorId);
        appointment.setAppointmentDate(appointmentDate);
        appointment.setStatus("Pending");

        AppointmentDAO dao = new AppointmentDAO();
        boolean status = dao.bookAppointment(appointment);

        if (status) {
            response.sendRedirect("patient-dashboard.jsp");
        } else {
            response.sendRedirect("appointment.jsp");
        }
    }
}