<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Profile - Movie Rental</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
            padding: 3rem 0 20px;
            background-color: #f8f9fa;
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
        }
        .nav-link:hover {
            color: #ffffff !important;
            opacity: 0.9;
            background-color: rgba(255, 255, 255, 0.1);
        }
        .nav-link.active {
            background-color: rgba(255, 255, 255, 0.2);
        }
        .navbar-toggler {
            border-color: rgba(255, 255, 255, 0.5);
        }
        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.75%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        .profile-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .profile-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .card-header {
            background: linear-gradient(to bottom, #031f3a, #123359);
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 1.5rem;
        }

        .card-header h5 {
            margin: 0;
            font-weight: 600;
            font-size: 1.5rem;
        }

        .card-body {
            padding: 2rem;
        }

        .form-label {
            font-weight: 500;
            color: #031f3a;
            margin-bottom: 0.5rem;
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

        .form-control:read-only {
            background-color: #f8f9fa;
        }

        .btn-primary {
            background: linear-gradient(to bottom, #031f3a, #123359);
            border: none;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(to bottom, #123359, #031f3a);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .section-divider {
            border-top: 2px solid #eee;
            margin: 2rem 0;
            position: relative;
        }

        .section-divider h6 {
            position: absolute;
            top: -12px;
            left: 0;
            background: white;
            padding: 0 1rem;
            color: #031f3a;
            font-weight: 600;
        }

        .alert {
            border-radius: 8px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            border: none;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .alert-success {
            background: linear-gradient(135deg, #1a472a, #2d5a3f);
            color: white;
        }

        .alert-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/admins">Admins</a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/profile">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="content-wrapper">
        <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>

                    <div class="profile-card">
                    <div class="card-header">
                            <h5><i class="fas fa-user-circle me-2"></i>Admin Profile</h5>
                    </div>
                    <div class="card-body">
                        <form id="profileForm" onsubmit="updateProfile(event)">
                                <div class="mb-4">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" class="form-control" id="username" value="${admin.username}" readonly>
                            </div>

                                <div class="mb-4">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" 
                                       value="${admin.fullName}" required>
                            </div>

                                <div class="mb-4">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" 
                                       value="${admin.email}" required>
                            </div>

                                <div class="section-divider">
                            <h6>Change Password</h6>
                                </div>

                                <div class="mb-4">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <input type="password" class="form-control" id="currentPassword" name="currentPassword">
                            </div>

                                <div class="mb-4">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword" 
                                       minlength="6">
                            </div>

                                <div class="mb-4">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                       minlength="6">
                            </div>

                                <div class="d-flex justify-content-between align-items-center">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>Save Changes
                                    </button>
                                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                                        <i class="fas fa-trash-alt me-2"></i>Delete Account
                                    </button>
                            </div>
                        </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteAccountModal" tabindex="-1" aria-labelledby="deleteAccountModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteAccountModalLabel">Delete Account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p class="text-danger">Warning: This action cannot be undone. All your data will be permanently deleted.</p>
                    <form id="deleteAccountForm" onsubmit="deleteAccount(event)">
                        <div class="mb-3">
                            <label for="password" class="form-label">Enter your password to confirm</label>
                            <input type="password" class="form-control" id="password" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-danger">Delete Account</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateProfile(event) {
            event.preventDefault();

            const currentPassword = document.getElementById('currentPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if ((currentPassword || newPassword || confirmPassword) &&
                (currentPassword === '' || newPassword === '' || confirmPassword === '')) {
                alert('Please fill in all password fields to change your password');
                return;
            }

            if (newPassword !== confirmPassword) {
                alert('New passwords do not match');
                return;
            }

            const data = {
                fullName: document.getElementById('fullName').value,
                email: document.getElementById('email').value
            };

            if (currentPassword && newPassword) {
                data.currentPassword = currentPassword;
                data.newPassword = newPassword;
            }

            fetch('${pageContext.request.contextPath}/admin/profile', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => {
                        throw new Error(text || 'Failed to update profile');
                    });
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    window.location.reload();
                } else {
                    throw new Error(data.message || 'Failed to update profile');
                }
            })
            .catch(error => {
                alert(error.message);
            });
        }

        function deleteAccount(event) {
            event.preventDefault();
            const password = document.getElementById('password').value;

            fetch('${pageContext.request.contextPath}/delete-account', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ password: password })
            })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => {
                        throw new Error(text || 'Failed to delete account');
                    });
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    window.location.href = '${pageContext.request.contextPath}/';
                } else {
                    throw new Error(data.message || 'Failed to delete account');
                }
            })
            .catch(error => {
                alert(error.message);
            });
        }
    </script>
</body>
</html> 