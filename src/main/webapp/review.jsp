<%@ page import="java.util.List" %>
<%@ page import="com.healthbridge.dao.DoctorDAO" %>
<%@ page import="com.healthbridge.model.Doctor" %>
<%@ page import="com.healthbridge.model.User" %>

<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

DoctorDAO dao = new DoctorDAO();
List<Doctor> doctors = dao.getAllDoctors();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Review Doctor - HealthBridge</title>
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
        <h1>Give Doctor Review</h1>
        <p>Rate your consultation and share feedback.</p>

        <form action="review" method="post">
            <label class="fw-bold">Select Doctor</label>
            <select name="doctorId" class="form-select" required>
                <option value="">Choose Doctor</option>
                <% for(Doctor d : doctors) { %>
                    <option value="<%= d.getId() %>"><%= d.getName() %> - <%= d.getSpecialization() %></option>
                <% } %>
            </select>

            <label class="fw-bold">Rating</label>
            <input type="number" name="rating" min="1" max="5" class="form-control" placeholder="Enter rating 1 to 5" required>

            <label class="fw-bold">Comment</label>
            <textarea name="comment" rows="5" class="form-control" placeholder="Write your review" required></textarea>

            <button class="btn hb-btn px-4 py-2">Submit Review</button>
            <a href="patient-dashboard.jsp" class="btn btn-secondary px-4 py-2">Back</a>
        </form>
    </div>
</div>

</body>
</html>