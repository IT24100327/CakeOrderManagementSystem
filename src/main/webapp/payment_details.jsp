<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Item" %>
<%@ page import="utils.ItemCatalog" %>

<%
    // Get the selected item
    String itemId = request.getParameter("itemId");

    ItemCatalog catalog = new ItemCatalog();
    catalog.loadFromFile();
    Item selectedItem = catalog.findItemById(itemId);

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
                        <h5 class="mb-3">Your Order</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Item:</strong></span>
                            <span><%= selectedItem.getName() %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Price:</strong></span>
                            <span>$<%= selectedItem.getPrice() %></span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between fw-bold">
                            <span>Total:</span>
                            <span>$<%= selectedItem.getPrice() %></span>
                        </div>
                    </div>

                    <!-- Customer Details Form -->
                    <form action="OrderServlet" method="post">
                        <input type="hidden" name="action" value="placeOrder">
                        <input type="hidden" name="itemId" value="<%= itemId %>">
                        <input type="hidden" name="total" value="<%= selectedItem.getPrice() %>">

                        <h5 class="mb-3">Customer Information</h5>
                        <div class="mb-3">
                            <label for="name" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone" required>
                        </div>

                        <div class="mb-3">
                            <label for="address" class="form-label">Delivery Address</label>
                            <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="quantity" class="form-label">Quantity</label>
                            <input type="number" class="form-control" id="quantity" name="quantity" min="1" value="1" required>
                        </div>

                        <div class="mb-4">
                            <label for="deliveryDate" class="form-label">Delivery Date</label>
                            <input type="date" class="form-control" id="deliveryDate" name="deliveryDate" min="<%= java.time.LocalDate.now().plusDays(1) %>" required>
                        </div>

                        <div class="mb-4 p-3 bg-light rounded">
                            <h6>Payment Method</h6>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="COD" checked>
                                <label class="form-check-label" for="cod">
                                    Cash on Delivery
                                </label>
                            </div>
                            <p class="small text-muted mt-1">Payment will be collected when your order is delivered</p>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">
                                Confirm Order
                            </button>
                        </div>
                    </form>
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