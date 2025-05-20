<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Item" %>
<%@ page import="utils.ItemCatalog" %>

<%
    // Initialize with default values
    int userId = 0;
    String itemId = null;
    String orderId = null;
    int quantity = 1;
    Double total = 0.0;
    Item selectedItem = null;
    String error = null;

    try {
        // Safely get parameters
        String userIdParam = request.getParameter("userId");
        String quantityParam = request.getParameter("quantity");
        Object orderIdAttrib = request.getAttribute("orderId");
        Object totalAttrib = request.getAttribute("total");

        // for then access though profile page
        String orderIdParam = request.getParameter("orderId");
        String totalParam = request.getParameter("total");

        itemId = request.getParameter("itemId");

        // Parse with validation
        if (userIdParam != null && !userIdParam.isEmpty()) {
            userId = Integer.parseInt(userIdParam);
            System.out.println("User ID set");
        }
        if (quantityParam != null && !quantityParam.isEmpty()) {
            quantity = Integer.parseInt(quantityParam);
            System.out.println("Quantity set");
        }
        if (orderIdParam != null && !orderIdParam.isEmpty()) {
            orderId = orderIdParam;
            System.out.println("Order Id set (From Parameter)");
        }
        if (totalParam != null && !totalParam.isEmpty()) {
            total = Double.parseDouble(totalParam);
            System.out.println("Total set (From Parameter)");
        }
        if (orderIdAttrib != null) {
            orderId = (String) orderIdAttrib;
            System.out.println("Order ID set");
        }
        if (totalAttrib != null) {
            total = (Double) totalAttrib;
            System.out.println("Total set");
        }

        // Load item if we have an ID
        if (itemId != null && !itemId.isEmpty()) {
            ItemCatalog catalog = new ItemCatalog();
            catalog.loadFromFile();
            selectedItem = catalog.findItemById(itemId);
        }
    } catch (NumberFormatException e) {
        error = "Invalid number format in parameters";
    } catch (Exception e) {
        error = "Error processing request: " + e.getMessage();
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Details - Heavenly Bakery</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .payment-card {
            max-width: 600px;
            margin: 0 auto;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .order-summary {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
        }
        .btn-primary {
            background-color: #885030;
            border-color: #885030;
        }
        .btn-primary:hover {
            background-color: #6e4124;
            border-color: #6e4124;
        }
    </style>
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card payment-card">
                <div class="card-header bg-white">
                    <h3 class="text-center mb-0">Order Details</h3>
                </div>
                <div class="card-body">
                    <% if (selectedItem != null) { %>
                    <!-- Order Summary -->
                    <div class="order-summary mb-4">
                        <h5 class="mb-3">Your Order [<%= orderId %>]</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Item:</strong></span>
                            <span><%= selectedItem.getName() %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Price:</strong></span>
                            <span>Rs. <%= selectedItem.getPrice() %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Quantity:</strong></span>
                            <span>x<%=quantity%></span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between fw-bold">
                            <span>Total:</span>
                            <span>Rs. <%=total%></span>
                        </div>
                    </div>

                    <!-- Customer Details Form -->
                    <form action="PaymentServlet" method="post">
                        <input type="hidden" name="action" value="pay">
                        <input type="hidden" name="orderId" value="<%= orderId %>">
                        <input type="hidden" name="paymentAmount" value="<%= total %>">

                        <div>
                            <h6>Payment Method</h6>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="card" checked>
                                <label class="form-check-label" for="cod">
                                    Card Payment
                                </label>
                            </div>
                            <p class="small text-muted mt-1">Pay for Order with Card</p>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="cash" checked>
                                <label class="form-check-label" for="cod">
                                    Cash Payment
                                </label>
                            </div>
                            <p class="small text-muted mt-1">Pay for Order with Cash</p>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">
                                Confirm Order
                            </button>
                        </div>
                    </form>
                    <div style="margin-top: 20px;">
                        <form action="PaymentServlet" method="post" style="">
                            <input type="hidden" name="action" value="cancel">
                            <button type="submit" class="btn btn-outline-danger btn-lg">
                                Cancel
                            </button>
                        </form>
                    </div>

                    <% } else { %>
                    <div class="alert alert-danger">Item not found. Please try again.</div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>