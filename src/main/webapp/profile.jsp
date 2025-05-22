<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Queue" %>
<%@ page import="entities.Order" %>
<%@ page import="utils.OrderQueue" %>
<%@ page import="entities.ItemOrder" %>
<%@ page import="entities.User" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="entities.CustomCakeOrder" %>

<%
    // Redirect to login if not authenticated
    User user = (User) session.getAttribute("USER");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    Queue<ItemOrder> itemOrders = null;
    Queue<CustomCakeOrder> customOrders = null;
    try {
        itemOrders = OrderQueue.getItemOrdersByDeliveryDate();
        customOrders = OrderQueue.getCustomQueue();
    } catch (Exception e) {
        System.err.println("Error retrieving orders: " + e.getMessage());
        request.setAttribute("errorMessage", "Error loading order information. Please try again later.");
    }
%>

<!DOCTYPE html>
<html data-bs-theme="light" lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Profile - Heavenly Bakery</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Abril%20Fatface.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Alex%20Brush.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Montserrat.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Raleway.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bs-theme-overrides.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Banner-Heading-Image-images.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Navbar-Centered-Links-icons.css">
    <style>
        .nav-link {
            font-size: 14px !important;
        }
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body id="page-top" style="color: var(--bs-light);background: var(--bs-secondary);">
<nav class="navbar navbar-expand-md bg-primary py-3 mb-3" style="background: var(--bs-secondary);color: var(--bs-primary);">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <span class="fs-5 fw-light text-start" style="color: var(--bs-secondary);font-family: 'Alex Brush', serif;font-size: 29px;">Heavenly Bakery</span>
        </a>
        <button data-bs-toggle="collapse" class="navbar-toggler" data-bs-target="#navcol-3">
            <span class="visually-hidden">Toggle navigation</span>
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navcol-3">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-weight: bold;">HOME</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/about" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">ABOUT</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/customCake.jsp" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">CUSTOM CAKES</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/reviews" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">REVIEWS</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active me-5" href="<%= request.getContextPath() %>/profile.jsp" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">PROFILE</a>
                </li>
                <% if (user.getROLE() != null && user.getROLE().equals("ADMIN")) { %>
                <li class="nav-item">
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/admin" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">ADMIN PANEL</a>
                </li>
                <% } %>
            </ul>
            <button class="btn btn-secondary fw-light me-2" type="button" style="font-family: Raleway, sans-serif;font-size: 12px;border-radius: 0px;">
                <a class="nav-link" href="<%= request.getContextPath() %>/logout">LOGOUT</a>
            </button>
        </div>
    </div>
</nav>

<div class="container">
    <div id="wrapper">
        <div class="d-flex flex-column" id="content-wrapper">
            <div id="content">
                    <div class="container-fluid">
                        <h1 class="text-dark mb-4" style="font-family: 'Abril Fatface', serif;color: var(--bs-primary);">
                            <span style="color: rgb(136, 80, 48);">Welcome, <%= user.getfName()%>!</span>
                        </h1>

                        <% if (request.getAttribute("errorMessage") != null) { %>
                        <div class="alert alert-danger" role="alert">
                            <%= request.getAttribute("errorMessage") %>
                        </div>
                        <% } %>
                        <% if (request.getAttribute("successMessage") != null) { %>
                        <div class="alert alert-success" role="alert">
                            <%= request.getAttribute("successMessage") %>
                        </div>
                        <% } %>

                        <!-- Added User Settings Section -->
                        <div class="row mb-3">
                            <div class="col-lg-8 col-xxl-6">
                                <div class="row">
                                    <div class="col-xxl-12">
                                        <div class="card shadow mb-3">
                                            <div class="card-header py-3">
                                                <p class="text-primary m-0 fw-bold" style="font-family: Montserrat, sans-serif;">User Settings</p>
                                            </div>
                                            <div class="card-body">
                                                <%
                                                    String errorMessage = (String) session.getAttribute("errorMessage");
                                                    if (errorMessage != null) {
                                                %>
                                                <div class="alert alert-danger">
                                                    <%= errorMessage %>
                                                </div>
                                                <%
                                                        session.removeAttribute("errorMessage");
                                                    }
                                                %>
                                                <%
                                                    String successMessage = (String) session.getAttribute("successMessage");
                                                    if (successMessage != null) {
                                                %>
                                                <div class="alert alert-success">
                                                    <%= successMessage %>
                                                </div>
                                                <%
                                                        session.removeAttribute("successMessage");
                                                    }
                                                %>
                                                <form action="<%= request.getContextPath() %>/updateprofile" method="post">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="mb-3">
                                                                <label class="form-label" for="first_name" style="font-family: Montserrat, sans-serif;"><strong>First Name</strong></label>
                                                                <input class="form-control" type="text" id="first_name" name="firstName" value="<%= user.getfName() %>" required>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="mb-3">
                                                                <label class="form-label" for="last_name" style="font-family: Montserrat, sans-serif;"><strong>Last Name</strong></label>
                                                                <input class="form-control" type="text" id="last_name" name="lastName" value="<%= user.getlName() %>" required>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="mb-3">
                                                                <label class="form-label" for="email" style="font-family: Montserrat, sans-serif;"><strong>Email Address</strong></label>
                                                                <input class="form-control" type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <button class="btn btn-primary btn-sm" type="submit" style="font-family: Raleway, sans-serif;">Save Settings</button>
                                                        <button type="button" class="btn btn-danger btn-sm ms-2" style="font-family: Raleway, sans-serif;" data-bs-toggle="modal" data-bs-target="#deleteProfileModal">
                                                            Delete Profile
                                                        </button>
                                                    </div>
                                                </form>

                                                <!-- Delete Profile Modal -->
                                                <div class="modal fade" id="deleteProfileModal" tabindex="-1" aria-labelledby="deleteProfileModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header" style="background-color: var(--bs-secondary);">
                                                                <h5 class="modal-title" id="deleteProfileModalLabel" style="font-family: 'Abril Fatface', serif; color: rgb(136, 80, 48);">Confirm Delete Profile</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body" style="font-family: Montserrat, sans-serif;">
                                                                <p>Are you sure you want to delete your profile? This action cannot be undone.</p>
                                                                <form id="deleteProfileForm" action="<%= request.getContextPath() %>/deleteprofile" method="post">
                                                                    <div class="mb-3">
                                                                        <label for="confirmPassword" class="form-label"><strong>Enter your password to confirm</strong></label>
                                                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal" style="font-family: Raleway, sans-serif;">Cancel</button>
                                                                <button type="submit" form="deleteProfileForm" class="btn btn-danger btn-sm" style="font-family: Raleway, sans-serif;">Delete Profile</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    <h3 class="text-dark mb-4" style="font-family: 'Abril Fatface', serif;">
                        <span style="color: rgb(136, 80, 48);">My Orders</span>
                    </h3>

                    <div class="card shadow mb-5">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <% if (itemOrders == null || itemOrders.isEmpty()) { %>
                                    <div class="alert alert-info">You don't have any orders yet.</div>
                                    <% } else { %>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <th class="fs-6 fw-light" style="font-family: 'Abril Fatface', serif;color: var(--bs-primary);">Order ID</th>
                                                <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Item</th>
                                                <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Quantity</th>
                                                <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Total</th>
                                                <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Delivery Date</th>
                                                <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Status</th>
                                                <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Actions</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <%
                                                for (ItemOrder order : itemOrders) {
                                                    if (order != null && order.getUser() != null && order.getUser().getID() == user.getID()) {
                                                        boolean isValidOrder = order.getItem() != null && (order.getPayment() != null || order.getStatus().equals("pending"));
                                                        double total = isValidOrder && order.getPayment() != null ? order.getPayment().getPaymentAmount() : order.getItem().getPrice() * order.getQuantity();
                                            %>
                                            <tr>
                                                <td style="font-family: Montserrat, sans-serif;"><%= order.getOrderId() %></td>
                                                <td style="font-family: Montserrat, sans-serif;"><%= order.getItem().getName() %></td>
                                                <td style="font-family: Montserrat, sans-serif;"><%= order.getQuantity() %></td>
                                                <td style="font-family: Montserrat, sans-serif;">Rs.<%= String.format("%.2f", total) %></td>
                                                <td style="font-family: Montserrat, sans-serif;"><%= order.getDeliveryDate() %></td>
                                                <td style="font-family: Montserrat, sans-serif;">
                                                    <span class="badge
                                                        <%= order.getStatus().equals("pending") ? "bg-warning" :
                                                            order.getStatus().equals("to-process") ? "bg-info" :
                                                            order.getStatus().equals("baking") ? "bg-primary" :
                                                            order.getStatus().equals("finished") ? "bg-success" :
                                                            order.getStatus().equals("cancelled") ? "bg-danger" : "bg-secondary" %>">
                                                        <%= order.getStatus() %>
                                                    </span>
                                                </td>
                                                <td class="gap-2 align-items-center">
                                                    <% if (order.getStatus().equals("pending")) { %>
                                                    <form action="<%= request.getContextPath() %>/payment_details.jsp" method="post" class="d-inline">
                                                        <input type="hidden" name="action" value="pay">
                                                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                                        <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") %>">
                                                        <button type="submit" class="btn btn-primary btn-sm" style="font-family: Raleway, sans-serif;">
                                                            Pay Now
                                                        </button>
                                                    </form>
                                                    <button type="button" class="btn btn-outline-primary btn-sm"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#<%= order.getOrderId() %>_update"
                                                            style="font-family: Raleway, sans-serif;">
                                                        <i class="fas fa-edit"></i> Update
                                                    </button>
                                                    <% } %>
                                                </td>
                                            </tr>
                                            <% } %>
                                            <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                    <% } %>
                                </div>

                                <%
                                    for (ItemOrder order : itemOrders) {
                                        if (order != null && order.getUser() != null && order.getUser().getID() == user.getID() && order.getStatus().equals("pending")) {
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
                                                        <label for="itemName<%= order.getOrderId() %>" class="form-label" style="font-family: Montserrat, sans-serif;">
                                                            <strong>Item</strong>
                                                        </label>
                                                        <input type="text" class="form-control" id="itemName<%= order.getOrderId() %>"
                                                               value="<%= order.getItem() != null ? order.getItem().getName() : "" %>" readonly>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="quantity<%= order.getOrderId() %>" class="form-label" style="font-family: Montserrat, sans-serif;">
                                                            <strong>Quantity</strong>
                                                        </label>
                                                        <input type="number" class="form-control" id="quantity<%= order.getOrderId() %>"
                                                               name="quantity" min="1" value="<%= order.getQuantity() %>" required>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="deliveryDate<%= order.getOrderId() %>" class="form-label" style="font-family: Montserrat, sans-serif;">
                                                            <strong>Delivery Date</strong>
                                                        </label>
                                                        <%
                                                            LocalDate tomorrow = LocalDate.now().plusDays(1);
                                                            String tomorrowStr = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                                                        %>
                                                        <input type="date" class="form-control" id="deliveryDate<%= order.getOrderId() %>"
                                                               name="deliveryDate" min="<%= tomorrowStr %>" value="<%= order.getDeliveryDate() %>" required>
                                                    </div>

                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="font-family: Raleway, sans-serif;">
                                                            Close
                                                        </button>
                                                        <button type="submit" class="btn btn-primary" style="font-family: Raleway, sans-serif;">
                                                            Save Changes
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% } %>
                                <% } %>
                            </div>
                        </div>
                    </div>

                    <h3 class="text-dark mb-4" style="font-family: 'Abril Fatface', serif;">
                        <span style="color: rgb(136, 80, 48);">My Custom Cake Orders</span>
                    </h3>

                    <div class="card shadow mb-5">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <% if (customOrders == null || customOrders.isEmpty()) { %>
                                    <div class="alert alert-info">You don't have any orders yet.</div>
                                    <% } else { %>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <th class="fs-6 fw-light" style="font-family: 'Abril Fatface', serif;color: var(--bs-primary);">Order ID</th>
                                                <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Total</th>
                                                <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Delivery Date</th>
                                                <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Status</th>
                                                <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Actions</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <%
                                                for (CustomCakeOrder order : customOrders) {
                                                    if (order != null && order.getUser() != null && order.getUser().getID() == user.getID()) {
                                                        double total = order.getPayment() != null ? order.getPayment().getPaymentAmount() : order.total();
                                            %>
                                            <tr>
                                                <td style="font-family: Montserrat, sans-serif;"><%= order.getOrderId() %></td>
                                                <td style="font-family: Montserrat, sans-serif;">Rs.<%= String.format("%.2f", total) %></td>
                                                <td style="font-family: Montserrat, sans-serif;"><%= order.getDeliveryDate() %></td>
                                                <td style="font-family: Montserrat, sans-serif;">
                                                    <span class="badge
                                                        <%= order.getStatus().equals("pending") ? "bg-warning" :
                                                            order.getStatus().equals("to-process") ? "bg-info" :
                                                            order.getStatus().equals("baking") ? "bg-primary" :
                                                            order.getStatus().equals("finished") ? "bg-success" :
                                                            order.getStatus().equals("cancelled") ? "bg-danger" : "bg-secondary" %>">
                                                        <%= order.getStatus() %>
                                                    </span>
                                                </td>
                                                <td class="d-flex gap-2 align-items-center">
                                                    <% if (order.getStatus().equals("pending")) { %>
                                                    <form action="<%= request.getContextPath() %>/Custom_payment_details.jsp" method="post" class="d-inline">
                                                        <input type="hidden" name="action" value="pay">
                                                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                                        <input type="hidden" name="csrfToken" value="<%= session.getAttribute("csrfToken") %>">
                                                        <button type="submit" class="btn btn-primary btn-sm" style="font-family: Raleway, sans-serif;">
                                                            Pay Now
                                                        </button>
                                                    </form>
                                                    <button type="button" class="btn btn-outline-primary btn-sm"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#<%= order.getOrderId() %>_update"
                                                            style="font-family: Raleway, sans-serif;">
                                                        <i class="fas fa-edit"></i> Update
                                                    </button>
                                                    <% } %>
                                                    <button type="button" class="btn btn-outline-primary btn-sm"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#<%= order.getOrderId() %>_view"
                                                            style="font-family: Raleway, sans-serif;">
                                                        <i class="fas fa-eye"></i> View
                                                    </button>
                                                </td>
                                            </tr>
                                            <% } %>
                                            <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                    <% } %>
                                </div>

                                <% for (CustomCakeOrder order : customOrders) {
                                    if (order != null && order.getUser() != null && order.getUser().getID() == user.getID() && order.getStatus().equals("pending")) {
                                %>
                                <!-- Update Modal -->
                                <div class="modal fade" id="<%= order.getOrderId() %>_update" tabindex="-1" aria-labelledby="editOrderModalLabel<%= order.getOrderId() %>" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Edit Order #<%= order.getOrderId() %></h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="<%= request.getContextPath() %>/ItemOrderServlet" method="post">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">

                                                    <!-- Delivery Date -->
                                                    <%
                                                        LocalDate tomorrow = LocalDate.now().plusDays(1);
                                                        String tomorrowStr = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                                                    %>
                                                    <div class="mb-3">
                                                        <label class="form-label"><strong>Delivery Date</strong></label>
                                                        <input type="date" class="form-control" name="deliveryDate" min="<%= tomorrowStr %>" value="<%= order.getDeliveryDate() %>" required>
                                                    </div>

                                                    <!-- Cake Details -->
                                                    <div class="mb-3"><label class="form-label"><strong>Occasion</strong></label><input type="text" class="form-control" name="occasion" value="<%= order.getOccasion() %>"></div>
                                                    <div class="mb-3"><label class="form-label"><strong>Flavour</strong></label><input type="text" class="form-control" name="cakeFlavour" value="<%= order.getCakeFlavour() %>"></div>
                                                    <div class="mb-3"><label class="form-label"><strong>Filling</strong></label><input type="text" class="form-control" name="filling" value="<%= order.getFilling() %>"></div>
                                                    <div class="mb-3"><label class="form-label"><strong>Size</strong></label><input type="text" class="form-control" name="cakeSize" value="<%= order.getCakeSize() %>"></div>
                                                    <div class="mb-3"><label class="form-label"><strong>Shape</strong></label><input type="text" class="form-control" name="cakeShape" value="<%= order.getCakeShape() %>"></div>
                                                    <div class="mb-3"><label class="form-label"><strong>Special Instructions</strong></label><textarea class="form-control" name="instructions"><%= order.getInstructions() %></textarea></div>

                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-primary">Save Changes</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% } } %>

                                <% for (CustomCakeOrder order : customOrders) { %>
                                <!-- View Modal -->
                                <div class="modal fade" id="<%= order.getOrderId() %>_view" tabindex="-1" aria-labelledby="viewOrderModalLabel<%= order.getOrderId() %>" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Order Details #<%= order.getOrderId() %></h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body">
                                                <p><strong>Occasion:</strong> <%= order.getOccasion() %></p>
                                                <p><strong>Cake Flavour:</strong> <%= order.getCakeFlavour() %></p>
                                                <p><strong>Filling:</strong> <%= order.getFilling() %></p>
                                                <p><strong>Size:</strong> <%= order.getCakeSize() %></p>
                                                <p><strong>Shape:</strong> <%= order.getCakeShape() %></p>
                                                <p><strong>Instructions:</strong> <%= order.getInstructions() %></p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% } %>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>