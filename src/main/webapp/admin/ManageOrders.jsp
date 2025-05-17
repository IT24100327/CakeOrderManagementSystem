<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entities.Order" %>
<%@ page import="utils.OrderQueue" %>
<%@ page import="java.util.Queue" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    Queue<Order> orders = null;
    Queue<Order> orders_pending = new LinkedList<>();
    Queue<Order> orders_to_process = new LinkedList<>();
    Queue<Order> orders_baking = new LinkedList<>();
    Queue<Order> orders_finished = new LinkedList<>();

    try {
        OrderQueue.loadFromFile();
        OrderQueue.sortOrderByDeliveryDate();
        orders = OrderQueue.getNormalOrderQueue();
    } catch (Exception e) {
        System.err.println("Error loading orders: " + e.getMessage());
        orders = new LinkedList<>(); // Empty queue as fallback
    }

    try {
        while (!orders.isEmpty()) {
            Order order = orders.poll();
            if (order.getStatus().equals("pending")) {
                orders_pending.add(order);
            } else if (order.getStatus().equals("to-process")) {
                orders_to_process.add(order);
            } else if (order.getStatus().equals("baking")) {
                orders_baking.add(order);
            } else if (order.getStatus().equals("finished")) {
                orders_finished.add(order);
            }
        }
    } catch (Exception e) {
        System.err.println("Error sorting orders: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Dashboard - Heavenly Bakery</title>
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

        .sidebar-nav-link .bi-chevron-down {
            margin-left: auto;
            transition: transform 0.3s;
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

        /* Status card styles */
        .status-card {
            border-left: 4px solid;
            transition: all 0.3s;
            cursor: pointer;
        }

        .status-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .status-card.pending {
            border-left-color: #ffc107;
        }

        .status-card.to-process {
            border-left-color: #fd7e14;
        }

        .status-card.baking {
            border-left-color: #0dcaf0;
        }

        .status-card.finished {
            border-left-color: #198754;
        }

        .status-card.active {
            background-color: rgba(136, 80, 48, 0.05);
        }

        .status-count {
            font-size: 1.5rem;
            font-weight: bold;
        }

        .order-section {
            display: none;
        }

        .order-section.active {
            display: block;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Badge styles */
        .badge-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .badge-to-process {
            background-color: #ffe5d0;
            color: #fd7e14;
        }

        .badge-baking {
            background-color: #d1f7ff;
            color: #0c5460;
        }

        .badge-finished {
            background-color: #d4edda;
            color: #155724;
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .main-content, .top-navbar {
                margin-left: 0;
            }
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
            <a href="<%=request.getContextPath()%>/admin/ManageOrders.jsp" class="sidebar-nav-link active">
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
            <a href="<%=request.getContextPath()%>/admin/ManagePayments.jsp" class="sidebar-nav-link" >
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

        <!-- Order Status Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card status-card pending active" onclick="showSection('pending')">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted mb-2">Pending Payment</h6>
                                <h3 class="status-count mb-0"><%= orders_pending.size() %></h3>
                            </div>
                            <div class="bg-warning bg-opacity-10 p-3 rounded">
                                <i class="fas fa-clock text-warning"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card status-card to-process" onclick="showSection('to-process')">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted mb-2">To Process</h6>
                                <h3 class="status-count mb-0"><%= orders_to_process.size() %></h3>
                            </div>
                            <div class="bg-orange bg-opacity-10 p-3 rounded">
                                <i class="fas fa-list-check text-orange"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card status-card baking" onclick="showSection('baking')">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted mb-2">Baking</h6>
                                <h3 class="status-count mb-0"><%= orders_baking.size() %></h3>
                            </div>
                            <div class="bg-info bg-opacity-10 p-3 rounded">
                                <i class="fas fa-fire text-info"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card status-card finished" onclick="showSection('finished')">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-muted mb-2">Finished</h6>
                                <h3 class="status-count mb-0"><%= orders_finished.size() %></h3>
                            </div>
                            <div class="bg-success bg-opacity-10 p-3 rounded">
                                <i class="fas fa-check-circle text-success"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Order Sections -->
        <div class="order-section active" id="pending-section">
            <div class="card dashboard-card">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Pending Payment Orders</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>User ID</th>
                                <th>Item ID</th>
                                <th>Status</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Order Date</th>
                                <th>Delivery Date</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <% for (Order order : orders_pending) { %>
                            <tr>
                                <td><%=order.getOrderId()%></td>
                                <td><%=order.getUserId()%></td>
                                <td><%=order.getItemId()%></td>
                                <td><span class="badge badge-pending"><%=order.getStatus()%></span></td>
                                <td><%=order.getQuantity()%></td>
                                <td>Rs. <%=order.getTotal()%></td>
                                <td><%=order.getOrderDate()%></td>
                                <td><%=order.getDeliveryDate()%></td>
                                <td>
                                    <div class="btn-group" role="group">
                                        <button type="button" class="btn btn-outline-primary btn-sm"
                                                data-bs-toggle="modal"
                                                data-bs-target="#<%=order.getOrderId()%>_update">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button type="button" class="btn btn-outline-danger btn-sm"
                                                data-bs-toggle="modal"
                                                data-bs-target="#<%=order.getOrderId()%>_cancel">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="order-section" id="to-process-section">
            <div class="card dashboard-card">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Orders To Process</h5>
                </div>
                <div class="card-body">
                    <% if (!orders_to_process.isEmpty()) { %>
                    <div class="mb-3">
                        <form action="<%=request.getContextPath()%>/OrderServlet" method="post">
                            <input type="hidden" name="action" value="to-process">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-forward me-2"></i>Process Next Order (Move to Baking)
                            </button>
                        </form>
                    </div>
                    <% } %>

                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Order ID</th>
                                <th>User ID</th>
                                <th>Item ID</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Order Date</th>
                                <th>Delivery Date</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                int position = 1;
                                for (Order order : orders_to_process) {
                            %>
                            <tr>
                                <td><%=position++%></td>
                                <td><%=order.getOrderId()%></td>
                                <td><%=order.getUserId()%></td>
                                <td><%=order.getItemId()%></td>
                                <td><%=order.getQuantity()%></td>
                                <td>Rs. <%=order.getTotal()%></td>
                                <td><%=order.getOrderDate()%></td>
                                <td><%=order.getDeliveryDate()%></td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="order-section" id="baking-section">
            <div class="card dashboard-card">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Baking Orders</h5>
                </div>
                <div class="card-body">
                    <% if (!orders_baking.isEmpty()) { %>
                    <div class="mb-3">
                        <form action="<%=request.getContextPath()%>/OrderServlet" method="post">
                            <input type="hidden" name="action" value="baking">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-check me-2"></i>Process Next Order (Mark as Completed)
                            </button>
                        </form>
                    </div>
                    <% } %>

                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Order ID</th>
                                <th>User ID</th>
                                <th>Item ID</th>
                                <th>Status</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Order Date</th>
                                <th>Delivery Date</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                position = 1;
                                for (Order order : orders_baking) {
                            %>
                            <tr>
                                <td><%= position++ %></td>
                                <td><%=order.getOrderId()%></td>
                                <td><%=order.getUserId()%></td>
                                <td><%=order.getItemId()%></td>
                                <td><span class="badge badge-baking"><%=order.getStatus()%></span></td>
                                <td><%=order.getQuantity()%></td>
                                <td>Rs. <%=order.getTotal()%></td>
                                <td><%=order.getOrderDate()%></td>
                                <td><%=order.getDeliveryDate()%></td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="order-section" id="finished-section">
            <div class="card dashboard-card">
                <div class="card-header bg-white">
                    <h5 class="mb-0">Finished Orders</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>User ID</th>
                                <th>Item ID</th>
                                <th>Status</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Order Date</th>
                                <th>Delivery Date</th>
                                <th>Completed On</th>
                            </tr>
                            </thead>
                            <tbody>
                            <% for (Order order : orders_finished) { %>
                            <tr>
                                <td><%=order.getOrderId()%></td>
                                <td><%=order.getUserId()%></td>
                                <td><%=order.getItemId()%></td>
                                <td><span class="badge badge-finished"><%=order.getStatus()%></span></td>
                                <td><%=order.getQuantity()%></td>
                                <td>Rs. <%=order.getTotal()%></td>
                                <td><%=order.getOrderDate()%></td>
                                <td><%=order.getDeliveryDate()%></td>
                                <td><!-- Placeholder for completed date --></td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modals for pending orders -->
        <% for (Order order : orders_pending) { %>
        <!-- Update Modal -->
        <div class="modal fade" id="<%=order.getOrderId()%>_update" tabindex="-1" aria-labelledby="editOrderModalLabel<%=order.getOrderId()%>" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editOrderModalLabel<%=order.getOrderId()%>">Edit Order #<%=order.getOrderId()%></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="<%=request.getContextPath()%>/OrderServlet" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="orderId" value="<%=order.getOrderId()%>">

                            <div class="mb-3">
                                <label for="itemId<%=order.getOrderId()%>" class="form-label">Item ID</label>
                                <input type="text" class="form-control" id="itemId<%=order.getOrderId()%>"
                                       name="itemId" value="<%=order.getItemId()%>" readonly>
                            </div>

                            <div class="mb-3">
                                <label for="quantity<%=order.getOrderId()%>" class="form-label">Quantity</label>
                                <input type="number" class="form-control" id="quantity<%=order.getOrderId()%>"
                                       name="quantity" min="1" value="<%=order.getQuantity()%>" required>
                            </div>

                            <div class="mb-3">
                                <label for="deliveryDate<%=order.getOrderId()%>" class="form-label">Delivery Date</label>
                                <%
                                    LocalDate tomorrow = LocalDate.now().plusDays(1);
                                    String tomorrowStr = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                                %>
                                <input type="date" class="form-control" id="deliveryDate<%=order.getOrderId()%>"
                                       name="deliveryDate" min="<%=tomorrowStr%>" value="<%=order.getDeliveryDate()%>" required>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Cancel Order Modal -->
        <div class="modal fade" id="<%=order.getOrderId()%>_cancel" tabindex="-1" aria-labelledby="cancelOrderModalLabel<%=order.getOrderId()%>" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title" id="cancelOrderModalLabel<%=order.getOrderId()%>">Cancel Order #<%=order.getOrderId()%></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to cancel this order?</p>
                        <div class="card bg-light mb-3">
                            <div class="card-body">
                                <p class="mb-1"><strong>Item:</strong> <%=order.getItemId()%></p>
                                <p class="mb-1"><strong>Quantity:</strong> <%=order.getQuantity()%></p>
                                <p class="mb-0"><strong>Delivery Date:</strong> <%=order.getDeliveryDate()%></p>
                            </div>
                        </div>

                        <form action="<%=request.getContextPath()%>/OrderServlet" method="post" id="cancelForm<%=order.getOrderId()%>">
                            <input type="hidden" name="action" value="cancel">
                            <input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">No, Keep Order</button>
                        <button type="submit" form="cancelForm<%=order.getOrderId()%>" class="btn btn-danger">Yes, Cancel Order</button>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

<script src="<%= request.getContextPath() %>/assets/bootstrap/js/bootstrap.min.js"></script>
<script>
    // Close sidebar when clicking outside on mobile
    document.addEventListener('click', function(event) {
        const sidebar = document.querySelector('.sidebar');
        const isClickInsideSidebar = sidebar.contains(event.target);
        const isClickOnToggler = event.target.closest('.navbar-toggler');

        if (window.innerWidth <= 992 && !isClickInsideSidebar && !isClickOnToggler && sidebar.classList.contains('active')) {
            sidebar.classList.remove('active');
        }
    });

    // Show order section based on status card click
    function showSection(sectionId) {
        // Hide all sections
        document.querySelectorAll('.order-section').forEach(section => {
            section.classList.remove('active');
        });

        // Show selected section
        document.getElementById(`${sectionId}-section`).classList.add('active');

        // Update active status card
        document.querySelectorAll('.status-card').forEach(card => {
            card.classList.remove('active');
        });

        document.querySelector(`.status-card.${sectionId}`).classList.add('active');
    }
</script>