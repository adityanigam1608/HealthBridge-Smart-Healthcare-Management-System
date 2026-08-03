<!DOCTYPE html>
<html>
<head>
    <title>Login - HealthBridge</title>
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
            <p>Login to your account</p>
        </div>

        <form action="login" method="post">
            <label>Email Address</label>
            <input type="email" name="email" class="form-control" placeholder="Enter email" required>

            <label>Password</label>
            <input type="password" name="password" class="form-control" placeholder="Enter password" required>

            <button class="btn hb-btn w-100 mt-4">Login</button>
        </form>

        <p class="text-center mt-4">
            New user? <a href="register.jsp">Create account</a>
        </p>

        <div class="text-center">
            <a href="index.jsp">Back to Home</a>
        </div>
    </div>
</div>

</body>
</html>