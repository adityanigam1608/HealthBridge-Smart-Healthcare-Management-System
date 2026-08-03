package com.healthbridge.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.healthbridge.db.DBConnection;
import com.healthbridge.model.User;

public class UserDAO {

    public boolean registerUser(User user) {
        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO users(full_name, email, password, role) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;

                ResultSet rs = ps.getGeneratedKeys();
                int userId = 0;

                if (rs.next()) {
                    userId = rs.getInt(1);
                }

                if ("doctor".equalsIgnoreCase(user.getRole())) {
                    String doctorSql = "INSERT INTO doctors(name, specialization, available_time, user_id) VALUES (?, ?, ?, ?)";
                    PreparedStatement dps = con.prepareStatement(doctorSql);

                    dps.setString(1, user.getFullName());
                    dps.setString(2, "General Physician");
                    dps.setString(3, "10:00 AM - 5:00 PM");
                    dps.setInt(4, userId);

                    int doctorRow = dps.executeUpdate();

                    if (doctorRow > 0) {
                        System.out.println("Doctor also inserted into doctors table.");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            status = false;
        }

        return status;
    }

    public User loginUser(String email, String password) {
        User user = null;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();

                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}