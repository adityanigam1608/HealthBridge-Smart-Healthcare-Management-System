<%@ page import="java.util.List" %>
<%@ page import="com.healthbridge.model.User" %>
<%@ page import="com.healthbridge.model.Doctor" %>
<%@ page import="com.healthbridge.dao.DoctorDAO" %>

<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

DoctorDAO doctorDAO = new DoctorDAO();
List<Doctor> doctors = doctorDAO.getAllDoctors();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Book Appointment - HealthBridge</title>
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

        <div class="ms-auto">
            <a href="patient-dashboard.jsp" class="btn btn-outline-light px-4">Dashboard</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="form-box">
        <h1>Book Appointment</h1>
        <p>Select doctor and preferred appointment date.</p>

        <form action="bookAppointment" method="post">
            <label class="fw-bold">Select Doctor</label>
            <select name="doctorId" class="form-select" required>
                <option value="">Choose Doctor</option>
                <% for(Doctor doctor : doctors) { %>
                    <option value="<%= doctor.getId() %>">
                        <%= doctor.getName() %> - <%= doctor.getSpecialization() %> - <%= doctor.getAvailableTime() %>
                    </option>
                <% } %>
            </select>

            <label class="fw-bold">Appointment Date</label>
            <input type="date" name="appointmentDate" class="form-control" required>

            <button type="submit" class="btn hb-btn px-4 py-2">Confirm Appointment</button>
            <a href="patient-dashboard.jsp" class="btn btn-secondary px-4 py-2">Back</a>
        </form>
    </div>
</div>

</body>
</html>