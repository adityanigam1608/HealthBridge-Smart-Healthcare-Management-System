<!DOCTYPE html>
<html>
<head>
    <title>Register - HealthBridge</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/auth.css">
</head>
<body>

<div class="auth-page">
    <div class="auth-card">
        <div class="text-center mb-4">
            <h2><i class="bi bi-heart-pulse-fill"></i> Health<span>Bridge</span></h2>
            <p>Create your account</p>
        </div>

        <form name="registerForm" action="register" method="post" onsubmit="return validateRegisterForm()">
            <label>Full Name</label>
            <input type="text" name="fullName" class="form-control" placeholder="Enter full name" required>

            <label>Email Address</label>
            <input type="email" name="email" class="form-control" placeholder="Enter email" required>

            <label>Password</label>
            <input type="password" name="password" class="form-control" placeholder="Enter password" required>

            <label>Select Role</label>
            <select name="role" class="form-control" required>
                <option value="">Choose role</option>
                <option value="patient">Patient</option>
                <option value="doctor">Doctor</option>
            </select>

            <button class="btn hb-btn w-100 mt-4">Register</button>
        </form>

        <p class="text-center mt-4">
            Already registered? <a href="login.jsp">Login</a>
        </p>

        <div class="text-center">
            <a href="index.jsp">Back to Home</a>
        </div>
    </div>
</div>

<script src="js/validation.js"></script>
</body>
</html>