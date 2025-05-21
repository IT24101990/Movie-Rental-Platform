<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management - Movie Rental Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
        
        /* Card styles */
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
        
        /* Table styles */
        .table {
            margin-bottom: 0;
        }
        
        .table th {
            font-weight: 500;
            color: #031f3a;
            border-bottom: 2px solid #dee2e6;
        }
        
        .table td {
            vertical-align: middle;
        }
        
        /* Button styles */
        .btn-primary {
            background: linear-gradient(135deg, #031f3a, #123359);
            border: none;
            padding: 0.5rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #123359, #031f3a);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        .btn-secondary {
            background: #6c757d;
            border: none;
            padding: 0.5rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        .btn-danger {
            background: #dc3545;
            border: none;
            padding: 0.5rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        
        /* Modal styles */
        .modal-content {
            border: none;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .modal-header {
            background: linear-gradient(135deg, #031f3a, #123359);
            color: white;
            border-radius: 10px 10px 0 0;
            padding: 1rem 1.5rem;
        }
        
        .modal-body {
            padding: 1.5rem;
        }
        
        .modal-footer {
            padding: 1rem 1.5rem;
            border-top: 1px solid #dee2e6;
        }
        
        /* Form styles */
        .form-label {
            font-weight: 500;
            color: #031f3a;
        }
        
        .form-control, .form-select {
            border-radius: 5px;
            border: 1px solid #dee2e6;
            padding: 0.5rem 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #123359;
            box-shadow: 0 0 0 0.2rem rgba(18, 51, 89, 0.25);
        }
        
        /* Badge styles */
        .badge {
            padding: 0.5rem 1rem;
            font-weight: 500;
            border-radius: 5px;
        }
        
        .badge.bg-success {
            background: linear-gradient(135deg, #1a472a, #2d5a3f) !important;
        }
        
        .badge.bg-danger {
            background: linear-gradient(135deg, #dc3545, #c82333) !important;
        }
        
        .role-badge {
            width: 130px;
            height: 36px;
            display: inline-block;
            text-align: center;
            font-weight: 500;
            line-height: 36px;
            padding: 0;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/admins">Admins</a>
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
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">Admin Management</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                            <input type="text" id="userSearchInput" class="form-control" placeholder="Search by name or ID" style="max-width: 250px;">
                            <button class="btn btn-primary ms-2" data-bs-toggle="modal" data-bs-target="#addUserModal">
                                <i class="fas fa-plus"></i> Add admin
                            </button>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Username</th>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${users}" var="user">
                                        <c:if test="${user['class'].simpleName eq 'AdminUser'}">
                                            <tr>
                                                <td>${user.id}</td>
                                                <td>${user.username}</td>
                                                <td>${user.fullName}</td>
                                                <td>${user.email}</td>
                                                <td>
                                                    <button class="btn btn-sm btn-danger" 
                                                            onclick="deleteUser('${user.id}')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="addUserModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add admin</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/admins" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" name="fullName" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Admin</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="deleteUserModal" tabindex="-1" aria-labelledby="deleteUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteUserModalLabel">Delete Admin</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p class="text-danger">Warning: This action cannot be undone. The admin's data will be permanently deleted.</p>
                    <form id="deleteUserForm" onsubmit="confirmDeleteUser(event)">
                        <input type="hidden" id="deleteUserId" name="userId">
                        <div class="mb-3">
                            <label for="adminPassword" class="form-label">Enter your admin password to confirm</label>
                            <input type="password" class="form-control" id="adminPassword" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-danger">Delete Admin</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function deleteUser(userId) {
            document.getElementById('deleteUserId').value = userId;
            new bootstrap.Modal(document.getElementById('deleteUserModal')).show();
        }

        function confirmDeleteUser(event) {
            event.preventDefault();
            const userId = document.getElementById('deleteUserId').value;
            const password = document.getElementById('adminPassword').value;

            fetch('${pageContext.request.contextPath}/admin/admins/delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ 
                    userId: userId,
                    password: password
                })
            })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => {
                        throw new Error(text || 'Failed to delete admin');
                    });
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    window.location.reload();
                } else {
                    throw new Error(data.message || 'Failed to delete admin');
                }
            })
            .catch(error => {
                alert(error.message);
            });
        }

        const userSearchInput = document.getElementById('userSearchInput');
        const userTable = document.querySelector('table.table tbody');
        const allRows = Array.from(userTable.querySelectorAll('tr'));
        let currentSort = { column: null, asc: true };

        userSearchInput.addEventListener('input', function() {
            filterAndSortTable();
        });

        function filterAndSortTable() {
            const search = userSearchInput.value.trim().toLowerCase();
            let filteredRows = allRows.filter(row => {
                const id = row.children[0].textContent.trim().toLowerCase();
                const name = row.children[2].textContent.trim().toLowerCase();
                return id.includes(search) || name.includes(search);
            });

            userTable.innerHTML = '';
            filteredRows.forEach(row => userTable.appendChild(row));
        }
    </script>
</body>
</html> 