<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Movie Rental</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background: linear-gradient(to bottom, #031f3a, #123359) !important;
            padding: 1rem 0;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .navbar-brand {
            color: #ffffff !important;
            font-weight: bold;
            font-size: 1.5rem;
            text-decoration: none;
            padding: 0.5rem 1rem;
        }
        .navbar-brand:hover {
            color: #ffffff !important;
            opacity: 0.9;
        }
        .main-content {
            flex: 1;
            padding: 2rem 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            background: rgba(255, 255, 255, 0.95);
            width: 100%;
            max-width: 500px;
            margin: 0 auto;
        }
        .card-title {
            color: #031f3a;
            font-weight: 600;
        }
        .form-control {
            border-radius: 8px;
            border: 1px solid #dee2e6;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #123359;
            box-shadow: 0 0 0 0.2rem rgba(18, 51, 89, 0.25);
        }
        .form-label {
            color: #031f3a;
            font-weight: 500;
        }
        .btn-primary {
            background: linear-gradient(135deg, #031f3a, #123359);
            border: none;
            border-radius: 8px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #123359, #031f3a);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(18, 51, 89, 0.2);
        }
        .show-password-btn {
            background: linear-gradient(135deg, #031f3a, #123359);
            color: #fff;
            border: none;
            border-radius: 0 8px 8px 0;
            transition: all 0.3s ease;
        }
        .show-password-btn:hover {
            background: linear-gradient(135deg, #123359, #031f3a);
            transform: translateY(-1px);
        }
        .alert-danger {
            background-color: #fff3f3;
            border-color: #ffcdd2;
            color: #d32f2f;
            border-radius: 8px;
        }
        a {
            color: #123359;
            text-decoration: none;
            transition: all 0.3s ease;
            position: relative;
            padding: 0 2px;
        }
        a:hover {
            color: #031f3a;
            text-decoration: none;
        }
        a::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -2px;
            left: 0;
            background: linear-gradient(135deg, #031f3a, #123359);
            transition: width 0.3s ease;
        }
        a:hover::after {
            width: 100%;
        }
        .input-group {
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            border-radius: 8px;
        }
        .input-group .form-control {
            border-radius: 8px 0 0 8px;
        }
        .input-group .show-password-btn {
            border-radius: 0 8px 8px 0;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">Movie Rental</a>
        </div>
    </nav>

    <div class="main-content">
        <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                    <div class="card">
                        <div class="card-body p-4">
                            <h2 class="card-title text-center mb-4">Welcome Back</h2>
                        
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/login" method="post">
                                <div class="mb-4">
                                <label for="username" class="form-label">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" required placeholder="Enter your username">
                            </div>
                            
                                <div class="mb-4">
                                <label for="password" class="form-label">Password</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="password" name="password" required placeholder="Enter your password">
                                        <button class="show-password-btn btn" type="button" id="togglePassword" tabindex="-1">
                                            <i class="bi bi-eye" id="togglePasswordIcon"></i>
                                        </button>
                                    </div>
                            </div>

                            <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary">Sign In</button>
                            </div>
                        </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/includes/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.getElementById('togglePassword').addEventListener('click', function() {
        const passwordInput = document.getElementById('password');
        const icon = document.getElementById('togglePasswordIcon');
        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            icon.classList.remove('bi-eye');
            icon.classList.add('bi-eye-slash');
        } else {
            passwordInput.type = 'password';
            icon.classList.remove('bi-eye-slash');
            icon.classList.add('bi-eye');
        }
    });
    </script>
</body>
</html> 