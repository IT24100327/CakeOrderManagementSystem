<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Admin Dashboard - Heavenly Bakery</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Abril%20Fatface.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Alex%20Brush.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Montserrat.css">
    <style>
        :root {
            --bs-primary: #885030;
            --bs-secondary: #ffe2bb;
            --bs-light: #f8f9fa;
            --bs-dark: #212529;
            --sidebar-width: 280px;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f5f5f5;
            overflow-x: hidden;
        }

        /* Header styles */
        .dashboard-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .dashboard-title {
            font-family: 'Abril Fatface', cursive;
            color: var(--bs-primary);
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }

        .dashboard-subtitle {
            font-family: 'Montserrat', sans-serif;
            color: #6c757d;
            font-size: 1.1rem;
            font-weight: 300;
        }

        /* Main content area */
        .main-content {
            padding: 20px;
            min-height: 100vh;
            transition: all 0.3s;
        }

        /* Navbar styles */
        .top-navbar {
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 1rem 1.5rem;
            position: sticky;
            top: 0;
            z-index: 999;
        }

        /* Dashboard cards */
        .dashboard-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 20px;
            height: 100%;
            text-decoration: none;
            color: inherit;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            text-decoration: none;
        }

        .card-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--bs-primary);
        }

        .card-title {
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .card-text {
            color: #6c757d;
            font-size: 0.9rem;
        }


        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        ::-webkit-scrollbar-thumb {
            background: var(--bs-primary);
            border-radius: 4px;
        }
    </style>
</head>

<body>
<%
    String ROLE = (String) session.getAttribute("ROLE");
    if (ROLE == null) {
        response.sendRedirect(request.getContextPath());
        return;
    } else {
        if (!ROLE.equals("ADMIN")) {
            response.sendRedirect(request.getContextPath());
            return;
        }
    }
%>

<!-- Main Content -->
<div class="main-content">
    <!-- Top Navbar -->
    <nav class="top-navbar navbar navbar-expand-lg navbar-light bg-white shadow-sm mb-4">
        <div class="container-fluid">
            <button class="navbar-toggler d-lg-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
                <i class="fas fa-bars"></i>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <span class="d-none d-sm-inline">Welcome, Admin</span>
                    <div>
                        <a href="<%= request.getContextPath() %>/logout" class="btn btn-outline-danger">
                            <i class="fas fa-sign-out-alt me-1"></i> Logout
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Content -->
    <div class="container-fluid">
        <div class="dashboard-header">
            <h1 class="dashboard-title">Dashboard</h1>
            <p class="dashboard-subtitle">Manage your bakery operations with ease</p>
        </div>

        <!-- Navigation Cards -->
        <div class="row">
            <div class="col-md-4">
                <a href="<%= request.getContextPath() %>/admin/ManageOrders.jsp" class="dashboard-card card">
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="fas fa-clipboard-list"></i>
                        </div>
                        <h5 class="card-title">Orders</h5>
                        <p class="card-text">Manage customer orders and track their status</p>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="<%= request.getContextPath() %>/admin/ManageCustomOrders.jsp" class="dashboard-card card">
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <h5 class="card-title">Custom Orders</h5>
                        <p class="card-text">Handle special requests and custom cakes</p>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="<%= request.getContextPath() %>/admin/ManageItems.jsp" class="dashboard-card card">
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="fas fa-bread-slice"></i>
                        </div>
                        <h5 class="card-title">Menu Items</h5>
                        <p class="card-text">Manage bakery products and pricing</p>
                    </div>
                </a>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-4">
                <a href="<%= request.getContextPath() %>/admin/ManageUsers.jsp" class="dashboard-card card">
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h5 class="card-title">Users</h5>
                        <p class="card-text">Manage customer and staff accounts</p>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="<%= request.getContextPath() %>/admin/ManagePayments.jsp" class="dashboard-card card">
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="fas fa-credit-card"></i>
                        </div>
                        <h5 class="card-title">Payments</h5>
                        <p class="card-text">View and process payment transactions</p>
                    </div>
                </a>
            </div>
            <div class="col-md-4">
                <a href="<%= request.getContextPath() %>/admin/ManageReviews.jsp" class="dashboard-card card">
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="fas fa-comment-alt"></i>
                        </div>
                        <h5 class="card-title">Reviews</h5>
                        <p class="card-text">View and respond to customer feedback</p>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>

<script src="<%= request.getContextPath() %>/assets/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>