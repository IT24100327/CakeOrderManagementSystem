<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entities.Item" %>
<%@ page import="java.util.List" %>
<%@ page import="utils.ItemCatalog" %>
<%@ page import="utils.OrderQueue" %>
<%@ page import="java.util.Queue" %>
<%@ page import="entities.Order" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    ItemCatalog catalog = new ItemCatalog();
    catalog.loadFromFile();
    List<Item> item = catalog.getAllItems();

    Queue<Order> orders = null;
    Queue<Order> orders_pending = new LinkedList<>();
    Queue<Order> orders_to_process = new LinkedList<>();
    Queue<Order> orders_baking = new LinkedList<>();
    Queue<Order> orders_finished = new LinkedList<>();

    try {
        OrderQueue.loadFromFile();
        OrderQueue.sortOrderByDeliveryDate();
        orders = OrderQueue.getOrderQueue();
    } catch (Exception e) {
        // Log error or handle appropriately
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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Abril%20Fatface.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Alex%20Brush.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Montserrat.css">
    <style>
        :root {
            --bs-primary: #885030; /* Purple */
            --bs-secondary: #ffe2bb; /* Light gray */
        }

        body {
            background: var(--bs-primary);
            font-family: 'Montserrat', sans-serif;
        }

        .navbar-brand {
            font-family: 'Alex Brush', cursive;
            font-size: 2rem;
            color: var(--bs-primary) !important;
        }

        .nav-tabs {
            background: var(--bs-primary);
            border-bottom: none;
        }

        .nav-tabs .nav-link {
            font-family: 'Abril Fatface', serif;
            color: var(--bs-secondary);
            border: none;
            padding: 1rem 1.5rem;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        .nav-tabs .nav-link:hover {
            color: var(--bs-primary);
            background-color: var(--bs-secondary);
        }

        .nav-tabs .nav-link.active {
            color: var(--bs-primary);
            background-color: var(--bs-secondary);
        }

        .tab-content-container {
            background: var(--bs-secondary);
            border-radius: 0 0 8px 8px;
        }

        .dashboard-card {
            transition: transform 0.3s ease;
            border-left: 4px solid;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
        }

        .border-left-primary {
            border-left-color: var(--bs-primary) !important;
        }

        .border-left-success {
            border-left-color: #28a745 !important;
        }

        .border-left-info {
            border-left-color: #17a2b8 !important;
        }

        .border-left-warning {
            border-left-color: #ffc107 !important;
        }

        .card-icon {
            color: var(--bs-primary);
            opacity: 0.7;
        }
    </style>
</head>

<body id="page-top">
<%
    String ROLE = (String) session.getAttribute("ROLE");
    if (ROLE == null) {
        response.sendRedirect(request.getContextPath());
        return;
    }else{
        if (!ROLE.equals("ADMIN")) {
            response.sendRedirect(request.getContextPath());
            return;
        }
    }
%>
<%= ROLE%>

<nav class="navbar navbar-expand-md py-3" style="background: var(--bs-secondary);">
    <div class="container">
        <a class="navbar-brand" href="#">Heavenly Bakery Admin</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a href="<%= request.getContextPath() %>/logout" class="btn btn-primary">
                        <i class="fas fa-sign-out-alt me-1"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container py-4">
    <div class="row">
        <div class="col-12">
            <ul class="nav nav-tabs" id="dashboardTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <a class="nav-link active" id="dashboard-tab" data-bs-toggle="tab" href="#dashboard" role="tab" style="font-size: 28px;">Dashboard</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="orders-tab" data-bs-toggle="tab" href="#orders" role="tab" style="font-size: 28px;">Orders</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="items-tab" data-bs-toggle="tab" href="#items" role="tab" style="font-size: 28px;">Items</a>
                </li>
                <li class="nav-item" role="presentation">
                    <a class="nav-link" id="reviews-tab" data-bs-toggle="tab" href="#reviews" role="tab" style="font-size: 28px;">Reviews</a>
                </li>
            </ul>

            <div class="tab-content tab-content-container p-4" id="dashboardTabsContent">
                <div class="tab-pane fade show active" id="dashboard" role="tabpanel">
                    <div class="row">
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-left-primary py-2 dashboard-card">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col me-2">
                                            <div class="text-uppercase text-primary fw-bold text-xs mb-1">Earnings (monthly)</div>
                                            <div class="text-dark fw-bold h5 mb-0">$40,000</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-left-success py-2 dashboard-card">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col me-2">
                                            <div class="text-uppercase text-success fw-bold text-xs mb-1">Earnings (annual)</div>
                                            <div class="text-dark fw-bold h5 mb-0">$215,000</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-left-info py-2 dashboard-card">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col me-2">
                                            <div class="text-uppercase text-info fw-bold text-xs mb-1">Tasks</div>
                                            <div class="row align-items-center g-0">
                                                <div class="col-auto">
                                                    <div class="text-dark fw-bold h5 mb-0 me-3">50%</div>
                                                </div>
                                                <div class="col">
                                                    <div class="progress progress-sm">
                                                        <div class="progress-bar bg-info" style="width: 50%"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-left-warning py-2 dashboard-card">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col me-2">
                                            <div class="text-uppercase text-warning fw-bold text-xs mb-1">Pending Requests</div>
                                            <div class="text-dark fw-bold h5 mb-0">18</div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-comments fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="orders" role="tabpanel">
                    <h4 class="mb-4">Orders Management</h4>

                    <!-- Order Status Tabs -->
                    <ul class="nav nav-pills mb-4" id="orderStatusTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="payment-pending-tab" data-bs-toggle="pill"
                                    data-bs-target="#payment-pending" type="button" role="tab">
                                Payment Pending
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="to-process-tab" data-bs-toggle="pill"
                                    data-bs-target="#to-process" type="button" role="tab">
                                To Process
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="baking-tab" data-bs-toggle="pill"
                                    data-bs-target="#baking" type="button" role="tab">
                                Baking
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="finished-tab" data-bs-toggle="pill"
                                    data-bs-target="#finished" type="button" role="tab">
                                Finished
                            </button>
                        </li>
                    </ul>

                    <!-- Order Status Tab Content -->
                    <div class="tab-content" id="orderStatusTabsContent">
                        <!-- Payment Pending Tab -->
                        <div class="tab-pane fade show active" id="payment-pending" role="tabpanel">
                            <table class="table table-hover table-bordered">
                                <thead class="table-dark">
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
                                    <td><%=order.getStatus()%></td>
                                    <td><%=order.getQuantity()%></td>
                                    <td><%=order.getTotal()%></td>
                                    <td><%=order.getOrderDate()%></td>
                                    <td><%=order.getDeliveryDate()%></td>
                                    <td>
                                        <button type="button" class="btn btn-warning btn-sm"
                                                data-bs-toggle="modal"
                                                data-bs-target="#<%=order.getOrderId()%>_update">
                                            Edit
                                        </button>
                                        <button type="button" class="btn btn-danger btn-sm"
                                                data-bs-toggle="modal"
                                                data-bs-target="#<%=order.getOrderId()%>_cancel">
                                            Cancel
                                        </button>
                                    </td>
                                </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>

                        <!-- To Process Tab -->
                        <div class="tab-pane fade" id="to-process" role="tabpanel">
                            <% if (!orders_to_process.isEmpty()) { %>
                            <div class="mb-3">
                                <form action="<%=request.getContextPath()%>/OrderServlet" method="post">
                                    <input type="hidden" name="action" value="to-process">
                                    <button type="submit" class="btn btn-primary">
                                        Process Next Order (Move to Baking)
                                    </button>
                                </form>
                            </div>
                            <% } %>

                            <table class="table table-hover table-bordered">
                                <thead class="table-dark">
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
                                    <td><%=order.getTotal()%></td>
                                    <td><%=order.getOrderDate()%></td>
                                    <td><%=order.getDeliveryDate()%></td>
                                </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>

                        <!-- Baking Tab -->
                        <div class="tab-pane fade" id="baking" role="tabpanel">
                            <table class="table table-hover table-bordered">
                                <thead class="table-dark">
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
                                <% for (Order order : orders_baking) { %>
                                <tr>
                                    <td><%=order.getOrderId()%></td>
                                    <td><%=order.getUserId()%></td>
                                    <td><%=order.getItemId()%></td>
                                    <td><%=order.getStatus()%></td>
                                    <td><%=order.getQuantity()%></td>
                                    <td><%=order.getTotal()%></td>
                                    <td><%=order.getOrderDate()%></td>
                                    <td><%=order.getDeliveryDate()%></td>
                                    <td>
                                        <!-- Placeholder for baking actions -->
                                    </td>
                                </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>

                        <!-- Finished Tab -->
                        <div class="tab-pane fade" id="finished" role="tabpanel">
                            <table class="table table-hover table-bordered">
                                <thead class="table-dark">
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
                                    <td><%=order.getStatus()%></td>
                                    <td><%=order.getQuantity()%></td>
                                    <td><%=order.getTotal()%></td>
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

                <!-- Modals for pending orders -->
                <% for (Order order : orders_pending) { %>
                <!-- Update Modal -->
                <div class="modal fade" id="<%=order.getOrderId()%>_update" tabindex="-1" aria-labelledby="editOrderModalLabel<%=order.getOrderId()%>" aria-hidden="true">
                    <div class="modal-dialog">
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
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header bg-danger text-white">
                                <h5 class="modal-title" id="cancelOrderModalLabel<%=order.getOrderId()%>">Cancel Order #<%=order.getOrderId()%></h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to cancel this order?</p>
                                <p><strong>Item:</strong> <%=order.getItemId()%></p>
                                <p><strong>Quantity:</strong> <%=order.getQuantity()%></p>
                                <p><strong>Delivery Date:</strong> <%=order.getDeliveryDate()%></p>

                                <form action="<%=request.getContextPath()%>/OrderServlet" method="post" id="cancelForm<%=order.getOrderId()%>">
                                    <input type="hidden" name="action" value="cancel">
                                    <input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No, Keep Order</button>
                                <button type="submit" form="cancelForm<%=order.getOrderId()%>" class="btn btn-danger">Yes, Cancel Order</button>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>

                <div class="tab-pane fade" id="items" role="tabpanel">
                    <div class="align-items-stretch">
                        <h4 class="mb-4">Bakery Items</h4>
                        <a href="<%= request.getContextPath() %>/admin/AddItems.jsp">
                            <button type="button" class="btn btn-primary">Add Item</button>
                        </a>
                    </div>

                    <p>Bakery Items go Here</p>
                </div>

                <div class="tab-pane fade" id="reviews" role="tabpanel">
                    <h4 class="mb-4">Customer Reviews</h4>
                    <p>Your customer reviews content will go here.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<%= request.getContextPath() %>/assets/bootstrap/js/bootstrap.min.js"></script>

</body>
</html>