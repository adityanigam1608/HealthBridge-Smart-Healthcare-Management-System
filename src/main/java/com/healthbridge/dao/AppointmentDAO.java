package com.healthbridge.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.healthbridge.db.DBConnection;
import com.healthbridge.model.Appointment;
import com.healthbridge.model.AppointmentView;

public class AppointmentDAO {

    public boolean bookAppointment(Appointment appointment) {
        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO appointments(patient_id, doctor_id, appointment_date, status) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, appointment.getPatientId());
            ps.setInt(2, appointment.getDoctorId());
            ps.setString(3, appointment.getAppointmentDate());
            ps.setString(4, "Pending");

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public List<AppointmentView> getAppointmentsByPatientId(int patientId) {
        List<AppointmentView> appointments = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT a.id, a.patient_id, d.name AS doctor_name, d.specialization, " +
                         "a.appointment_date, a.status, " +
                         "(SELECT COUNT(*) FROM appointments a2 " +
                         "WHERE a2.doctor_id = a.doctor_id " +
                         "AND a2.appointment_date = a.appointment_date " +
                         "AND a2.id <= a.id " +
                         "AND a2.status <> 'Rejected') AS queue_no " +
                         "FROM appointments a " +
                         "JOIN doctors d ON a.doctor_id = d.id " +
                         "WHERE a.patient_id = ? " +
                         "ORDER BY a.id DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, patientId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                AppointmentView av = new AppointmentView();

                av.setAppointmentId(rs.getInt("id"));
                av.setPatientId(rs.getInt("patient_id"));
                av.setDoctorName(rs.getString("doctor_name"));
                av.setSpecialization(rs.getString("specialization"));
                av.setAppointmentDate(rs.getString("appointment_date"));
                av.setStatus(rs.getString("status"));
                av.setQueueNumber(rs.getInt("queue_no"));

                appointments.add(av);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return appointments;
    }

    public List<AppointmentView> getAppointmentsByDoctorUserId(int doctorUserId) {
        List<AppointmentView> appointments = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT a.id, a.patient_id, u.full_name AS patient_name, d.name AS doctor_name, " +
                         "d.specialization, a.appointment_date, a.status, " +
                         "(SELECT COUNT(*) FROM appointments a2 " +
                         "WHERE a2.doctor_id = a.doctor_id " +
                         "AND a2.appointment_date = a.appointment_date " +
                         "AND a2.id <= a.id " +
                         "AND a2.status <> 'Rejected') AS queue_no " +
                         "FROM appointments a " +
                         "JOIN users u ON a.patient_id = u.id " +
                         "JOIN doctors d ON a.doctor_id = d.id " +
                         "WHERE d.user_id = ? " +
                         "ORDER BY a.id DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, doctorUserId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                AppointmentView av = new AppointmentView();

                av.setAppointmentId(rs.getInt("id"));
                av.setPatientId(rs.getInt("patient_id"));
                av.setPatientName(rs.getString("patient_name"));
                av.setDoctorName(rs.getString("doctor_name"));
                av.setSpecialization(rs.getString("specialization"));
                av.setAppointmentDate(rs.getString("appointment_date"));
                av.setStatus(rs.getString("status"));
                av.setQueueNumber(rs.getInt("queue_no"));

                appointments.add(av);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return appointments;
    }

    public boolean updateAppointmentStatus(int appointmentId, int doctorUserId, String status) {
        boolean result = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE appointments a " +
                         "JOIN doctors d ON a.doctor_id = d.id " +
                         "SET a.status = ? " +
                         "WHERE a.id = ? AND d.user_id = ?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, appointmentId);
            ps.setInt(3, doctorUserId);

            int row = ps.executeUpdate();

            if (row > 0) {
                result = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public List<AppointmentView> getPatientsForReportUpload(int doctorUserId) {
        List<AppointmentView> patients = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT DISTINCT u.id AS patient_id, u.full_name AS patient_name " +
                         "FROM appointments a " +
                         "JOIN users u ON a.patient_id = u.id " +
                         "JOIN doctors d ON a.doctor_id = d.id " +
                         "WHERE d.user_id = ? AND a.status = 'Approved' " +
                         "ORDER BY u.full_name";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, doctorUserId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                AppointmentView av = new AppointmentView();

                av.setPatientId(rs.getInt("patient_id"));
                av.setPatientName(rs.getString("patient_name"));

                patients.add(av);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return patients;
    }
}