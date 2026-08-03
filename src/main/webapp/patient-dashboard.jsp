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

AppointmentDAO dao = new AppointmentDAO();
List<AppointmentView> appointments = dao.getAppointmentsByPatientId(user.getId());
int totalAppointments = appointments.size();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Patient Dashboard - HealthBridge</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/dashboard.css">
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top hb-navbar">
    <div class="container">
        <a class="navbar-brand hb-logo" href="patient-dashboard.jsp">
            <i class="bi bi-heart-pulse-fill"></i> Health<span>Bridge</span>
        </a>

        <button class="navbar-toggler bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navMenu">
            <div class="ms-auto d-flex gap-2">
                <a href="appointment.jsp" class="btn hb-btn px-4">Book Appointment</a>
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
                        <h4><%= user.getFullName() %></h4>
                        <p>Patient Account</p>
                    </div>

                    <a class="side-link active" href="patient-dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a>
                    <a class="side-link" href="appointment.jsp"><i class="bi bi-calendar-plus"></i> Book Appointment</a>
                    <a class="side-link" href="review.jsp"><i class="bi bi-star"></i> Give Review</a>
                    <a class="side-link" href="logout"><i class="bi bi-box-arrow-right"></i> Logout</a>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="main-panel">
                    <div class="page-heading d-flex flex-wrap justify-content-between align-items-center gap-3">
                        <div>
                            <h1>Patient Dashboard</h1>
                            <p>Track appointments, status and waiting number.</p>
                        </div>
                        <a href="appointment.jsp" class="btn hb-btn px-4 py-2">New Appointment</a>
                    </div>

                    <div class="row g-4 mt-2">
                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class="bi bi-calendar-check"></i>
                                <h3><%= totalAppointments %></h3>
                                <p>Total Appointments</p>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class="bi bi-hourglass-split"></i>
                                <h3>Status</h3>
                                <p>Pending / Approved / Rejected</p>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="stat-card">
                                <i class="bi bi-list-ol"></i>
                                <h3>Queue</h3>
                                <p>Waiting Number</p>
                            </div>
                        </div>
                    </div>

                    <div class="section-card">
                        <h3>My Appointments</h3>

                        <% if (appointments.isEmpty()) { %>
                            <div class="empty-box">No appointment booked yet.</div>
                        <% } else { %>
                            <% for(AppointmentView appointment : appointments) { %>
                                <div class="appointment-card">
                                    <div>
                                        <h5 class="fw-bold mb-2"><%= appointment.getDoctorName() %></h5>
                                        <p class="mb-1">Specialization: <%= appointment.getSpecialization() %></p>
                                        <p class="mb-1">Date: <%= appointment.getAppointmentDate() %></p>
                                        <p class="mb-0">Waiting Number: <strong><%= appointment.getQueueNumber() %></strong></p>
                                    </div>

                                    <div>
                                        <% if ("Approved".equalsIgnoreCase(appointment.getStatus())) { %>
                                            <span class="badge bg-success p-2">Approved</span>
                                        <% } else if ("Rejected".equalsIgnoreCase(appointment.getStatus())) { %>
                                            <span class="badge bg-danger p-2">Rejected</span>
                                        <% } else { %>
                                            <span class="badge bg-warning text-dark p-2">Pending</span>
                                        <% } %>
                                    </div>
                                </div>
                            <% } %>
                        <% } %>
                    </div>

                    <div class="row g-4 mt-1">
                        <div class="col-md-6">
                            <div class="quick-card">
                                <i class="bi bi-calendar-heart"></i>
                                <h5 class="mt-3 fw-bold">Book Appointment</h5>
                                <p class="text-muted">Choose a doctor and send appointment request.</p>
                                <a href="appointment.jsp" class="btn hb-btn">Book Now</a>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="quick-card">
                                <i class="bi bi-stars"></i>
                                <h5 class="mt-3 fw-bold">Review Doctor</h5>
                                <p class="text-muted">Rate your consultation experience.</p>
                                <a href="review.jsp" class="btn hb-btn">Give Review</a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>