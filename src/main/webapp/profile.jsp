<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Queue" %>

<%@ page import="entities.Order" %>
<%@ page import="utils.OrderQueue" %>
<%@ page import="entities.Item" %>
<%@ page import="utils.ItemCatalog" %>


<%
    Queue<Order> orders = null;

    ItemCatalog catalog = new ItemCatalog();
    catalog.loadFromFile();


    try {
        OrderQueue.loadFromFile();
        OrderQueue.sortOrderByDeliveryDate();
        orders = OrderQueue.getOrderQueue();
    } catch (Exception e) {
        // Log error or handle appropriately
        System.err.println("Error loading orders: " + e.getMessage());
        orders = new LinkedList<>(); // Empty queue as fallback
    }
%>

<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Profile - Brand</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Abril%20Fatface.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Alex%20Brush.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Montserrat.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Raleway.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bs-theme-overrides.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Banner-Heading-Image-images.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Navbar-Centered-Links-icons.css">
</head>

<%
    String email = (String) session.getAttribute("email");
    String ROLE = (String) session.getAttribute("ROLE");
    String userId = (String) session.getAttribute("ID");
%>

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
                <li class="nav-item" style="font-size: 12px;text-align: center;">
                    <a class="nav-link active me-5" href="<%= request.getContextPath() %>/" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-weight: bold;">HOME</a>
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
                <%
                    if(email != null){
                %>
                <li class="nav-item">
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/profile.jsp" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">PROFILE</a>
                </li>
                <%
                    }
                %>

                <%if(ROLE != null){
                    if(ROLE.equals("ADMIN")){
                %>
                <li class="nav-item">
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/admin" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">ADMIN PANEL</a>
                </li>
                <%
                        }
                    }
                %>

            </ul>
            <%
                if(email == null){
            %>
            <button class="btn btn-secondary fw-light me-2" type="button" style="font-family: Raleway, sans-serif;font-size: 12px;border-radius: 0px;"><a class="nav-link" href="<%= request.getContextPath() %>/login">LOGIN</a></button>
            <button class="btn btn-secondary fw-light" type="button" style="font-family: Raleway, sans-serif;font-size: 12px;border-radius: 0px;"><a class="nav-link" href="<%= request.getContextPath() %>/signup">SIGN UP</a></button>

            <%
            }else{
            %>
            <button class="btn btn-secondary fw-light me-2" type="button" style="font-family: Raleway, sans-serif;font-size: 12px;border-radius: 0px;"><a class="nav-link" href="<%= request.getContextPath() %>/logout">LOGOUT</a></button>
            <%
                }
            %>
        </div>
    </div>
</nav>
    <div class="container">
        <div id="wrapper">
            <div class="d-flex flex-column" id="content-wrapper">
                <div id="content">
                    <div class="container-fluid">
                        <h1 class="text-dark mb-4" style="font-family: 'Abril Fatface', serif;color: var(--bs-primary);"><span style="color: rgb(136, 80, 48);">Profile</span></h1>
                        <div class="row mb-3">
                            <div class="col-lg-8 col-xxl-6">
                                <div class="row">
                                    <div class="col-xxl-12">
                                        <div class="card shadow mb-3">
                                            <div class="card-header py-3">
                                                <p class="text-primary m-0 fw-bold" style="font-family: Montserrat, sans-serif;">User Settings</p>
                                            </div>
                                            <div class="card-body">
                                                <form>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="mb-3"><label class="form-label" for="username" style="font-family: Montserrat, sans-serif;"><strong>Username</strong></label><input class="form-control" type="text" id="username" placeholder="user.name" name="username"></div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="mb-3"><label class="form-label" for="email" style="font-family: Montserrat, sans-serif;"><strong>Email Address</strong></label><input class="form-control" type="email" id="email" placeholder="user@example.com" name="email"></div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="mb-3"><label class="form-label" for="first_name" style="font-family: Montserrat, sans-serif;"><strong>First Name</strong></label><input class="form-control" type="text" id="first_name" placeholder="John" name="first_name"></div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="mb-3"><label class="form-label" for="last_name" style="font-family: Montserrat, sans-serif;"><strong>Last Name</strong></label><input class="form-control" type="text" id="last_name" placeholder="Doe" name="last_name"></div>
                                                        </div>
                                                    </div>
                                                    <div class="mb-3"><button class="btn btn-primary btn-sm" type="submit" style="font-family: Raleway, sans-serif;">Save Settings</button></div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <h1 class="text-dark mb-4" style="font-family: 'Abril Fatface', serif;"><span style="color: rgb(136, 80, 48);">My Orders</span></h1>
                        <div class="card shadow mb-5">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <div class="table-responsive">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th class="fs-6 fw-light" style="font-family: 'Abril Fatface', serif;color: var(--bs-primary);">Order ID</th>
                                                        <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Item ID</th>
                                                        <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Item Name</th>
                                                        <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Quantity</th>
                                                        <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Total</th>
                                                        <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Delivery Date</th>
                                                        <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Status</th>
                                                        <th class="fs-6 fw-light" style="color: var(--bs-primary);font-family: 'Abril Fatface', serif;">Actions</th>
                                                    </tr>
                                                </thead>

                                                <% for (Order order : orders) {
                                                    if (order.getUserId() == Integer.parseInt(userId)) {
                                                        %>

                                                <% Item item = catalog.findItemById(order.getItemId());

                                                %>
                                                <tbody>
                                                <tr>
                                                    <td style="font-family: Montserrat, sans-serif;"><%=order.getOrderId()%></td>
                                                    <td style="font-family: Montserrat, sans-serif;"><%=order.getItemId()%></td>
                                                    <td style="font-family: Montserrat, sans-serif;"><%= item.getName() %></td>
                                                    <td style="font-family: Montserrat, sans-serif;"><%=order.getQuantity()%></td>
                                                    <td style="font-family: Montserrat, sans-serif;"><%=order.getTotal()%></td>
                                                    <td style="font-family: Montserrat, sans-serif;"><%=order.getDeliveryDate()%></td>
                                                    <td style="font-family: Montserrat, sans-serif;"><%=order.getStatus()%></td>
                                                    <td>
                                                        <% if (order.getStatus().equals("pending")) {%>

                                                        <form action="payment_details.jsp" method="post">
                                                            <input type="hidden" name="itemId" value="<%=order.getItemId()%>">
                                                            <input type="hidden" name="quantity" value="<%=order.getQuantity()%>">
                                                            <input type="hidden" name="total" value="<%=order.getTotal()%>">
                                                            <input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
                                                            <input type="submit" name="submit" value="Pay Now" class="btn btn-primary btn-sm" style="font-family: Raleway, sans-serif;">
                                                        </form>

                                                        <% } %>
                                                    </td>
                                                </tr>
                                                </tbody>
                                                   <% } %>
                                                <% } %>
                                            </table>
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>