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
    response.sendRedirect("login.jsp");
    return;
}

AppointmentDAO dao = new AppointmentDAO();
List<AppointmentView> patients = dao.getPatientsForReportUpload(user.getId());
%>

<!DOCTYPE html>
<html>
<head>
    <title>Upload Report - HealthBridge</title>
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

        <div class="ms-auto">
            <a href="doctor-dashboard.jsp" class="btn btn-outline-light px-4">Dashboard</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="form-box">
        <h1>Upload Lab Report</h1>
        <p>Select approved patient and add report details.</p>

        <% if (patients.isEmpty()) { %>
            <div class="empty-box mb-3">No approved patient found. First approve an appointment.</div>
            <a href="doctor-dashboard.jsp" class="btn btn-secondary px-4 py-2">Back</a>
        <% } else { %>
            <form action="uploadReport" method="post">
                <label class="fw-bold">Select Patient</label>
                <select name="patientId" class="form-select" required>
                    <option value="">Choose Patient</option>
                    <% for(AppointmentView patient : patients) { %>
                        <option value="<%= patient.getPatientId() %>">
                            <%= patient.getPatientName() %> - Patient ID: <%= patient.getPatientId() %>
                        </option>
                    <% } %>
                </select>

                <label class="fw-bold">Report Name</label>
                <input type="text" name="reportName" class="form-control" placeholder="Blood Test Report" required>

                <label class="fw-bold">File Path / Report Link</label>
                <input type="text" name="filePath" class="form-control" placeholder="Enter report path or link" required>

                <button class="btn hb-btn px-4 py-2">Upload Report</button>
                <a href="doctor-dashboard.jsp" class="btn btn-secondary px-4 py-2">Back</a>
            </form>
        <% } %>
    </div>
</div>

</body>
</html>