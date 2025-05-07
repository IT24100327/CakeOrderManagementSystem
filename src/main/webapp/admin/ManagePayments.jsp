<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="entities.Payment" %>
<%@ page import="utils.paymentHandle" %>

<%
    paymentHandle.loadFromFile();
    paymentHandle.sortOrderByPaymentDate();
    LinkedList<Payment> payments = paymentHandle.getPayments();
%>

<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Payment Management - Heavenly Bakery</title>
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

        /* Sidebar styles */
        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            background: var(--bs-primary);
            color: white;
            z-index: 1000;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
        }

        .sidebar-brand {
            padding: 1.5rem;
            font-family: 'Alex Brush', cursive;
            font-size: 2rem;
            color: var(--bs-secondary);
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-nav {
            padding: 0;
            list-style: none;
        }

        .sidebar-nav-item {
            position: relative;
        }

        .sidebar-nav-link {
            display: flex;
            align-items: center;
            padding: 1rem 1.5rem;
            color: var(--bs-secondary);
            text-decoration: none;
            transition: all 0.3s;
        }

        .sidebar-nav-link:hover, .sidebar-nav-link.active {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .sidebar-nav-link i {
            margin-right: 0.75rem;
            font-size: 1.1rem;
        }

        /* Main content area */
        .main-content {
            margin-left: var(--sidebar-width);
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

        /* Card styles */
        .dashboard-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 20px;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        /* Table styles */
        .table {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .table thead th {
            background-color: var(--bs-primary);
            color: white;
            border: none;
        }

        /* Button styles */
        .btn-primary {
            background-color: var(--bs-primary);
            border-color: var(--bs-primary);
        }

        .btn-primary:hover {
            background-color: #6a3d24;
            border-color: #6a3d24;
        }

        /* Status badges */
        .badge-paid {
            background-color: #d4edda;
            color: #155724;
        }

        .badge-refunded {
            background-color: #f8d7da;
            color: #721c24;
        }

        .badge-pending {
            background-color: #fff3cd;
            color: #856404;
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
<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-brand">Heavenly Bakery</div>
    <ul class="sidebar-nav">
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/index.jsp" class="sidebar-nav-link">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/ManageOrders.jsp" class="sidebar-nav-link">
                <i class="fas fa-clipboard-list"></i> Orders
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/ManageCustomOrders.jsp" class="sidebar-nav-link" >
                <i class="fas fa-star"></i> Custom Orders
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/ManageItems.jsp" class="sidebar-nav-link">
                <i class="fas fa-bread-slice"></i> Items
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/ManageUsers.jsp" class="sidebar-nav-link">
                <i class="fas fa-users"></i> Users
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/ManagePayments.jsp" class="sidebar-nav-link active" >
                <i class="fas fa-credit-card"></i> Payments
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/ManageReviews.jsp" class="sidebar-nav-link">
                <i class="fas fa-comment-alt"></i> Reviews
            </a>
        </li>
    </ul>
</div>

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
        <h4 class="mb-4">Payment Management</h4>

        <div class="card dashboard-card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>Payment ID</th>
                            <th>Order ID</th>
                            <th>Amount</th>
                            <th>Method</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (Payment payment : payments) {
                            if (payment != null) {
                        %>
                        <tr>
                            <td><%= payment.getPaymentId() %></td>
                            <td><%= payment.getOrderId() %></td>
                            <td>$<%= payment.getPaymentAmount() %></td>
                            <td><%= payment.getPaymentMethod() %></td>
                            <td><%= payment.getPaymentDate() %></td>
                            <td>
                                <% if ("PAID".equals(payment.getPaymentStatus())) { %>
                                <span class="badge badge-paid">Paid</span>
                                <% } else if ("REFUNDED".equals(payment.getPaymentStatus())) { %>
                                <span class="badge badge-refunded">Refunded</span>
                                <% } else { %>
                                <span class="badge badge-pending">Pending</span>
                                <% } %>
                            </td>
                            <td>
                                <% if ("PAID".equals(payment.getPaymentStatus())) { %>
                                <button class="btn btn-outline-danger btn-sm" type="button"
                                        data-bs-toggle="modal"
                                        data-bs-target="#refundModal<%= payment.getPaymentId() %>">
                                    <i class="fas fa-undo"></i> Refund
                                </button>
                                <% } %>
                            </td>
                        </tr>
                        <% }
                        } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Refund Modals -->
<% for (Payment payment : payments) {
    if (payment != null && "PAID".equals(payment.getPaymentStatus())) { %>
<div class="modal fade" id="refundModal<%= payment.getPaymentId() %>" tabindex="-1"
     aria-labelledby="refundModalLabel<%= payment.getPaymentId() %>" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title" id="refundModalLabel<%= payment.getPaymentId() %>">
                    Refund Payment #<%= payment.getPaymentId() %>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to refund this payment?</p>
                <div class="card bg-light mb-3">
                    <div class="card-body">
                        <p class="mb-1"><strong>Order ID:</strong> <%= payment.getOrderId() %></p>
                        <p class="mb-1"><strong>Amount:</strong> $<%= payment.getPaymentAmount() %></p>
                        <p class="mb-1"><strong>Method:</strong> <%= payment.getPaymentMethod() %></p>
                        <p class="mb-0"><strong>Date:</strong> <%= payment.getPaymentDate() %></p>
                    </div>
                </div>

                <form action="<%= request.getContextPath() %>/PaymentServlet" method="post"
                      id="refundForm<%= payment.getPaymentId() %>">
                    <input type="hidden" name="action" value="refund">
                    <input type="hidden" name="paymentId" value="<%= payment.getPaymentId() %>">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" form="refundForm<%= payment.getPaymentId() %>"
                        class="btn btn-danger">Confirm Refund</button>
            </div>
        </div>
    </div>
</div>
<% }
} %>

<script src="<%= request.getContextPath() %>/assets/bootstrap/js/bootstrap.min.js"></script>
<script>
    // Toggle sidebar on mobile
    document.querySelector('.navbar-toggler').addEventListener('click', function() {
        document.querySelector('.sidebar').classList.toggle('active');
    });

    // Highlight active tab in sidebar
    const navLinks = document.querySelectorAll('.sidebar-nav-link');
    navLinks.forEach(link => {
        link.addEventListener('click', function() {
            navLinks.forEach(l => l.classList.remove('active'));
            this.classList.add('active');
        });
    });

    // Close sidebar when clicking outside on mobile
    document.addEventListener('click', function(event) {
        const sidebar = document.querySelector('.sidebar');
        const isClickInsideSidebar = sidebar.contains(event.target);
        const isClickOnToggler = event.target.closest('.navbar-toggler');

        if (window.innerWidth <= 992 && !isClickInsideSidebar && !isClickOnToggler && sidebar.classList.contains('active')) {
            sidebar.classList.remove('active');
        }
    });
</script>
</body>
</html>