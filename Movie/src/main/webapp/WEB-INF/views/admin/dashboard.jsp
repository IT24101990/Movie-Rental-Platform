<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Movie Rental</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            background-color: #f8f9fa;
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .content-wrapper {
            flex: 1 0 auto;
            width: 100%;
            padding-bottom: 20px;
            background-color: #f8f9fa;
        }
        footer {
            flex-shrink: 0;
            width: 100%;
        }
        footer .list-unstyled li {
            margin-bottom: 0.5rem;
        }
        footer .text-decoration-none {
            color: #ffffff !important;
        }
        footer .bi {
            margin-right: 0.5rem;
        }
        .navbar {
            background: linear-gradient(to bottom, #031f3a, #123359) !important;
            padding: 1rem 0;
        }
        .navbar-brand {
            color: #ffffff !important;
            font-weight: bold;
            font-size: 1.5rem;
            transition: color 0.3s ease;
        }
        .navbar-brand:hover {
            color: #ffffff !important;
            opacity: 0.9;
        }
        .nav-link {
            color: #ffffff !important;
            transition: color 0.3s ease;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            position: relative;
        }
        .nav-link:hover {
            color: #ffffff !important;
            opacity: 0.9;
            background-color: rgba(255, 255, 255, 0.1);
        }
        .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 50%;
            background: #ffffff;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }
        .nav-link:hover::after {
            width: 80%;
        }
        .nav-link.active {
            background-color: rgba(255, 255, 255, 0.2);
        }
        .nav-link.active::after {
            width: 80%;
        }
        .navbar-toggler {
            border-color: rgba(255, 255, 255, 0.5);
        }
        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.75%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }
        
        /* Dashboard specific styles */
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 1.5rem;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .card-header {
            background: linear-gradient(135deg, #031f3a, #123359);
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 1rem 1.5rem;
        }
        
        .card-header h5 {
            margin: 0;
            font-weight: 500;
        }
        
        .card-body {
            padding: 1.5rem;
        }
        
        .welcome-card {
            background: linear-gradient(135deg, #031f3a, #123359);
            color: white;
        }
        
        .welcome-card .card-body {
            padding: 2rem;
        }
        
        .welcome-card h2 {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .welcome-card p {
            font-size: 1.1rem;
            opacity: 0.9;
            margin: 0;
        }
        
        .stats-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .stats-card .card-body {
            padding: 1.5rem;
        }
        
        .stats-card .card-title {
            font-size: 1rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
            opacity: 0.9;
        }
        
        .stats-card .card-text {
            font-size: 2rem;
            font-weight: 600;
            margin: 0;
        }
        
        .bg-primary {
            background: linear-gradient(135deg, #031f3a, #123359) !important;
        }
        
        .bg-success {
            background: linear-gradient(135deg, #1a472a, #2d5a3f) !important;
        }
        
        .bg-info {
            background: linear-gradient(135deg, #0c4b6e, #1a6b94) !important;
        }
        
        .bg-warning {
            background: linear-gradient(135deg, #856404, #b38a00) !important;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">Movie Rental</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/admins">Admins</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/profile">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>


    <div class="content-wrapper">
        <div class="container mt-4">
            <div class="row">
                <!-- Welcome Card -->
                <div class="col-md-12 mb-4">
                    <div class="card welcome-card">
                        <div class="card-body">
                            <h2>Welcome, ${sessionScope.user.fullName}!</h2>
                            <p>This is your admin dashboard where you can manage the Movie rental system.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var dropdowns = document.querySelectorAll('.dropdown-toggle');
            dropdowns.forEach(function(dropdown) {
                new bootstrap.Dropdown(dropdown);
            });
        });


        function loadDashboardData() {

            fetch('${pageContext.request.contextPath}/api/admin/stats/users')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('totalUsers').textContent = data.total;
                });

            fetch('${pageContext.request.contextPath}/api/admin/stats/products')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('totalProducts').textContent = data.total;
                });

            fetch('${pageContext.request.contextPath}/api/admin/stats/rentals/active')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('activeRentals').textContent = data.total;
                });
        }


        document.addEventListener('DOMContentLoaded', loadDashboardData);

        setInterval(loadDashboardData, 300000);
    </script>
</body>
</html> 