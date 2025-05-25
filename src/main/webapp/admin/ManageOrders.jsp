<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entities.Order" %>
<%@ page import="utils.OrderQueue" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="entities.ItemOrder" %>
<%@ page import="utils.ItemCatalog" %>
<%@ page import="entities.User" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="utils.CustomQueue" %>

<%
    // Check if user is logged in
    User user = (User) session.getAttribute("USER");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Initialize order queue and counts
    CustomQueue<ItemOrder> orders = null;
    Map<String, Integer> statusCounts = new HashMap<>();
    statusCounts.put("pending", 0);
    statusCounts.put("in-progress", 0);
    statusCounts.put("finished", 0);

    try {
        // Always reload data to ensure fresh state
        OrderQueue.loadFromFile();
        ItemCatalog.loadFromFile();
        orders = OrderQueue.getItemQueue(); // Get delivery date-sorted ItemOrders

        // Count orders by status
        for (ItemOrder order : orders) {
            String status = order.getStatus().toLowerCase();
            if (status.equals("pending") || status.equals("in-progress") || status.equals("finished")) {
                statusCounts.put(status, statusCounts.getOrDefault(status, 0) + 1);
            }
        }
    } catch (Exception e) {
        System.err.println("Error loading orders: " + e.getMessage());
        orders = new CustomQueue<>();
        request.setAttribute("error", "Failed to load orders. Please try again later.");
    }
%>

<!DOCTYPE html>
<html data-bs-theme="light" lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Orders - Heavenly Bakery</title>
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
            transition: transform 0.3s ease;
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
            margin-bottom: 20px;
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
            border: none;
            border-radius: 12px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .status-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .status-card .card-body {
            padding: 1.5rem;
        }

        .status-card .icon-container {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .status-card.pending {
            background: linear-gradient(135deg, #fff8e1 0%, #ffecb3 100%);
        }

        .status-card.in-progress {
            background: linear-gradient(135deg, #e1f5fe 0%, #b3e5fc 100%);
        }

        .status-card.finished {
            background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
        }

        .status-card .icon-container.pending {
            background-color: rgba(255, 193, 7, 0.2);
        }

        .status-card .icon-container.in-progress {
            background-color: rgba(13, 202, 240, 0.2);
        }

        .status-card .icon-container.finished {
            background-color: rgba(25, 135, 84, 0.2);
        }

        .status-card i {
            font-size: 1.5rem;
        }

        .status-card.pending i {
            color: #ffc107;
        }

        .status-card.in-progress i {
            color: #0dcaf0;
        }

        .status-card.finished i {
            color: #198754;
        }

        .status-count {
            font-size: 2rem;
            font-weight: 700;
            color: var(--bs-dark);
            margin-bottom: 0.25rem;
        }

        .status-title {
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #6c757d;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        /* Badge styles */
        .badge-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .badge-in-progress {
            background-color: #d1f7ff;
            color: #0c5460;
        }

        .badge-finished {
            background-color: #d4edda;
            color: #155724;
        }

        .badge-next {
            background-color: #007bff;
            color: white;
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
            .table-responsive {
                font-size: 0.9rem;
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
            <a href="<%=request.getContextPath()%>/admin/ManageCustomOrders.jsp" class="sidebar-nav-link">
                <i class="fas fa-star"></i> Custom Orders
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/ManageItems.jsp" class="sidebar-nav-link">
                <i class="fas fa-bread-slice"></i> Items
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/ManagePayments.jsp" class="sidebar-nav-link">
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
                    <span class="d-none d-sm-inline">Welcome, <%=user.getfName() + " " + user.getlName()%></span>
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
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%= request.getAttribute("error") %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% } %>

        <!-- Next Order to Process (Earliest Delivery Date) -->
        <%
            ItemOrder nextOrder = null;
            for (ItemOrder order : orders) {
                if (order.getStatus().equals("in-progress")) {
                    nextOrder = order;
                    break;
                }
            }
            if (nextOrder != null) {
        %>
        <div class="card dashboard-card mb-4">
            <div class="card-header bg-white">
                <h5 class="mb-0">Next Order to Process (Earliest Delivery Date)</h5>
            </div>
            <div class="card-body">
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
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>1</td>
                            <td><%= nextOrder.getOrderId() %></td>
                            <td><%= nextOrder.getUser() != null ? nextOrder.getUser().getID() : -99 %></td>
                            <td><%= nextOrder.getItem() != null ? nextOrder.getItem().getItemId() : "N/A" %></td>
                            <td><span class="badge badge-in-progress badge-next">Next: <%= nextOrder.getStatus() %></span></td>
                            <td><%= nextOrder.getQuantity() %></td>
                            <td>Rs. <%= nextOrder.getPayment() != null ? String.format("%.2f", nextOrder.getPayment().getPaymentAmount()) : "0.00" %></td>
                            <td><%= nextOrder.getOrderDate() %></td>
                            <td><%= nextOrder.getDeliveryDate() %></td>
                            <td>
                                <a href="<%=request.getContextPath()%>/ItemOrderServlet?action=finish&orderId=<%=nextOrder.getOrderId()%>">
                                    <button type="button" class="btn btn-primary btn-sm">
                                        Finish
                                    </button>
                                </a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <% } %>

        <!-- Order Status Cards -->
        <div class="row mb-4 g-4">
            <div class="col-md-4">
                <div class="card status-card pending h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <p class="status-title">Pending Payment</p>
                                <h3 class="status-count"><%= statusCounts.get("pending") %></h3>
                            </div>
                            <div class="icon-container pending">
                                <i class="fas fa-clock"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card status-card in-progress h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <p class="status-title">In Progress</p>
                                <h3 class="status-count"><%= statusCounts.get("in-progress") %></h3>
                            </div>
                            <div class="icon-container in-progress">
                                <i class="fas fa-fire"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card status-card finished h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <p class="status-title">Finished</p>
                                <h3 class="status-count"><%= statusCounts.get("finished") %></h3>
                            </div>
                            <div class="icon-container finished">
                                <i class="fas fa-check-circle"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Order Tables -->
        <%
            String[] statuses = {"pending", "in-progress", "finished"};
            String[] sectionTitles = {"Pending Payment Orders", "In Progress Orders", "Finished Orders"};
            String[] badgeClasses = {"badge-pending", "badge-in-progress", "badge-finished"};

            for (int i = 0; i < statuses.length; i++) {
                String status = statuses[i];
                String sectionTitle = sectionTitles[i];
                String badgeClass = badgeClasses[i];
        %>
        <div class="card dashboard-card mb-4">
            <div class="card-header bg-white">
                <h5 class="mb-0"><%= sectionTitle %></h5>
            </div>
            <div class="card-body">
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
                            <% if (!status.equals("finished")) { %>
                            <th>Actions</th>
                            <% } %>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            int position = 1;
                            boolean hasOrders = false;
                            for (ItemOrder order : orders) {
                                if (order.getStatus().toLowerCase().equals(status)) {
                                    hasOrders = true;
                                    String itemId = order.getItem() != null ? order.getItem().getItemId() : "N/A";
                                    int userId = order.getUser() != null ? order.getUser().getID() : -99;
                                    String paymentAmount = order.getPayment() != null ? String.format("%.2f", order.getPayment().getPaymentAmount()) : "0.00";
                                    String displayStatus = status.equals("finished") ? "Completed" : order.getStatus();
                        %>
                        <tr>
                            <td><%= position %></td>
                            <td><%= order.getOrderId() %></td>
                            <td><%= userId %></td>
                            <td><%= itemId %></td>
                            <td><span class="badge <%= badgeClass %>"><%= displayStatus %></span></td>
                            <td><%= order.getQuantity() %></td>
                            <td>Rs. <%= paymentAmount %></td>
                            <td><%= order.getOrderDate() %></td>
                            <td><%= order.getDeliveryDate() %></td>
                            <% if (!status.equals("finished")) { %>
                            <td>
                                <% if (status.equals("pending")) { %>
                                <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-outline-primary btn-sm"
                                            data-bs-toggle="modal"
                                            data-bs-target="#<%= order.getOrderId() %>_update">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button type="button" class="btn btn-outline-danger btn-sm"
                                            data-bs-toggle="modal"
                                            data-bs-target="#<%= order.getOrderId() %>_cancel">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                                <% } else if (status.equals("in-progress") && position == 1) { %>
                                <a href="<%=request.getContextPath()%>/ItemOrderServlet?action=finish&orderId=<%=order.getOrderId()%>">
                                    <button type="button" class="btn btn-outline-primary btn-sm">
                                        Finish
                                    </button>
                                </a>
                                <% } %>
                            </td>
                            <% } %>
                        </tr>
                        <%
                                    position++;
                                }
                            }
                            if (!hasOrders) { %>
                        <tr><td colspan="<%= status.equals("finished") ? 9 : 10 %>" class="text-center">No <%= status %> orders found.</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <% } %>

        <!-- Modals for pending orders -->
        <% for (ItemOrder order : orders) {
            if (order.getStatus().toLowerCase().equals("pending")) {
        %>
        <!-- Update Modal -->
        <div class="modal fade" id="<%= order.getOrderId() %>_update" tabindex="-1" aria-labelledby="editOrderModalLabel<%= order.getOrderId() %>" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editOrderModalLabel<%= order.getOrderId() %>">Edit Order #<%= order.getOrderId() %></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="<%= request.getContextPath() %>/ItemOrderServlet" method="post">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">

                            <div class="mb-3">
                                <label for="itemId<%= order.getOrderId() %>" class="form-label">Item ID</label>
                                <input type="text" class="form-control" id="itemId<%= order.getOrderId() %>"
                                       name="itemId" value="<%= order.getItem() != null ? order.getItem().getItemId() : "" %>" readonly>
                            </div>

                            <div class="mb-3">
                                <label for="quantity<%= order.getOrderId() %>" class="form-label">Quantity</label>
                                <input type="number" class="form-control" id="quantity<%= order.getOrderId() %>"
                                       name="quantity" min="1" value="<%= order.getQuantity() %>" required>
                            </div>

                            <div class="mb-3">
                                <label for="deliveryDate<%= order.getOrderId() %>" class="form-label">Delivery Date</label>
                                <%
                                    LocalDate tomorrow = LocalDate.now().plusDays(1);
                                    String tomorrowStr = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                                %>
                                <input type="date" class="form-control" id="deliveryDate<%= order.getOrderId() %>"
                                       name="deliveryDate" min="<%= tomorrowStr %>" value="<%= order.getDeliveryDate() %>" required>
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
        <div class="modal fade" id="<%= order.getOrderId() %>_cancel" tabindex="-1" aria-labelledby="cancelOrderModalLabel<%= order.getOrderId() %>" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title" id="cancelOrderModalLabel<%= order.getOrderId() %>">Cancel Order #<%= order.getOrderId() %></h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to cancel this order?</p>
                        <div class="card bg-light mb-3">
                            <div class="card-body">
                                <p class="mb-1"><strong>Item:</strong> <%= order.getItem() != null ? order.getItem().getItemId() : "N/A" %></p>
                                <p class="mb-1"><strong>Quantity:</strong> <%= order.getQuantity() %></p>
                                <p class="mb-0"><strong>Delivery Date:</strong> <%= order.getDeliveryDate() %></p>
                            </div>
                        </div>

                        <form action="<%= request.getContextPath() %>/ItemOrderServlet" method="post" id="cancelForm<%= order.getOrderId() %>">
                            <input type="hidden" name="action" value="cancel">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                            <input type="hidden" name="_csrf" value="<%= session.getAttribute("csrfToken") %>">
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">No, Keep Order</button>
                        <button type="submit" form="cancelForm<%= order.getOrderId() %>" class="btn btn-danger">Yes, Cancel Order</button>
                    </div>
                </div>
            </div>
        </div>
        <% } } %>
    </div>
</div>

<script src="<%= request.getContextPath() %>/assets/bootstrap/js/bootstrap.min.js"></script>
<script>
    // Toggle sidebar on mobile
    document.querySelector('.navbar-toggler').addEventListener('click', function() {
        document.querySelector('.sidebar').classList.toggle('active');
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