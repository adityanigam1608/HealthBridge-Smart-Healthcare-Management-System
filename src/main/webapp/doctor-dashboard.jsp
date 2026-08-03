<%@ page import="java.util.List" %>
<%@ page import="com.healthbridge.model.User" %>
<%@ page import="com.healthbridge.model.AppointmentView" %>
<%@ page import="com.healthbridge.dao.AppointmentDAO" %>

<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

if (!"doctor".equalsIgnoreCase(user.getRole())) {
    response.sendRedirect("patient-dashboard.jsp");
    return;
}

AppointmentDAO dao = new AppointmentDAO();
List<AppointmentView> appointments = dao.getAppointmentsByDoctorUserId(user.getId());
int totalAppointments = appointments.size();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor Dashboard - HealthBridge</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/dashboard.css">
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top hb-navbar">
    <div class="container">
        <a class="navbar-brand hb-logo" href="doctor-dashboard.jsp">
            <i class="bi bi-heart-pulse-fill"></i> Health<span>Bridge</span>
        </a>

        <button class="navbar-toggler bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navMenu">
            <div class="ms-auto d-flex gap-2">
                <a href="upload-report.jsp" class="btn hb-btn px-4">Upload Report</a>
                <a href="logout" class="btn btn-outline-light px-4">Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="dashboard-wrapper">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-3">
                <div class="sidebar">
                    <div class="profile-box">
                        <h4>Dr. <%= user.getFullName() %></h4>
                        <p>Doctor Account</p>
                    </div>

                    <a class="side-link active" href="doctor-dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
                    <a class="side-link" href="upload-report.jsp"><i class="bi bi-file-medical"></i> Upload Report</a>
                    <a class="side-link" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="main-panel">
                    <div class="page-heading d-flex flex-wrap justify-content-between align-items-center gap-3">
                        <div>
                            <h1>Doctor Dashboard</h1>
                            <p>Approve or reject appointment requests.</p>
                        </div>
                        <a href="upload-report.jsp" class="btn hb-btn px-4 py-2">Upload Report</a>
                    </div>

                    <div class="row g-4 mt-2">
                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class="bi bi-people-fill"></i>
                                <h3><%= totalAppointments %></h3>
                                <p>Total Requests</p>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class="bi bi-check-circle"></i>
                                <h3>Approve</h3>
                                <p>Confirm Patient Visit</p>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class="bi bi-file-earmark-medical"></i>
                                <h3>Reports</h3>
                                <p>Upload For Approved Patients</p>
                            </div>
                        </div>
                    </div>

                    <div class="section-card">
                        <h3>Appointment Requests</h3>

                        <% if (appointments.isEmpty()) { %>
                            <div class="empty-box">No appointment request found.</div>
                        <% } else { %>
                            <% for(AppointmentView appointment : appointments) { %>
                                <div class="appointment-card">
                                    <div>
                                        <h5 class="fw-bold mb-2"><%= appointment.getPatientName() %></h5>
                                        <p class="mb-1">Patient ID: <%= appointment.getPatientId() %></p>
                                        <p class="mb-1">Date: <%= appointment.getAppointmentDate() %></p>
                                        <p class="mb-1">Waiting Number: <strong><%= appointment.getQueueNumber() %></strong></p>
                                        <p class="mb-0">Status: <strong><%= appointment.getStatus() %></strong></p>
                                    </div>

                                    <div class="d-flex gap-2 flex-wrap">
                                        <% if ("Pending".equalsIgnoreCase(appointment.getStatus())) { %>
                                            <a href="updateAppointment?id=<%= appointment.getAppointmentId() %>&status=Approved" class="btn btn-success btn-sm">Approve</a>
                                            <a href="updateAppointment?id=<%= appointment.getAppointmentId() %>&status=Rejected" class="btn btn-danger btn-sm">Reject</a>
                                        <% } else if ("Approved".equalsIgnoreCase(appointment.getStatus())) { %>
                                            <span class="badge bg-success p-2">Approved</span>
                                        <% } else { %>
                                            <span class="badge bg-danger p-2">Rejected</span>
                                        <% } %>
                                    </div>
                                </div>
                            <% } %>
                        <% } %>
                    </div>

                    <div class="section-card">
                        <h3>Doctor Tools</h3>
                        <a href="upload-report.jsp" class="btn hb-btn px-4">Upload Patient Report</a>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>