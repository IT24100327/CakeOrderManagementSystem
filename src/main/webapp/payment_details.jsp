<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Item" %>
<%@ page import="utils.ItemCatalog" %>
<%@ page import="entities.ItemOrder" %>
<%@ page import="entities.User" %>
<%@ page import="utils.OrderQueue" %>

<%

    OrderQueue.loadFromFile();
    ItemCatalog.loadFromFile();

    User user = (User) session.getAttribute("USER");

    ItemOrder order = null;

    if (request.getAttribute("order") != null) {
        order = (ItemOrder) request.getAttribute("order");
        System.out.println("new order found");
    } else {
        order = OrderQueue.findItemOrderById(request.getParameter("orderId"));
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
                    <% if (order != null) { %>
                    <!-- Order Summary -->
                    <div class="order-summary mb-4">
                        <h5 class="mb-3">Your Order [<%= order.getOrderId() %>]</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Item:</strong></span>
                            <span><%= order.getItem().getItemId() %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Price:</strong></span>
                            <span>Rs. <%= order.getItem().getPrice() %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Quantity:</strong></span>
                            <span>x<%= order.getQuantity() %></span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between fw-bold">
                            <span>Total:</span>
                            <span>Rs. <%= order.getItem().getPrice() * order.getQuantity() %></span>
                        </div>
                    </div>

                    <!-- Customer Details Form -->
                    <form action="PaymentServlet" method="post">
                        <div>

                            <input type="hidden" name="action" value="pay">
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">

                            <h6>Payment Method</h6>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="COD" checked>
                                <label class="form-check-label" for="cod">
                                    Cash on Delivery
                                </label>
                            </div>
                            <p class="small text-muted mt-1">Payment will be collected when your order is delivered</p>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="cre" value="CREDIT">
                                <label class="form-check-label" for="cre">
                                    Credit Card
                                </label>
                            </div>
                            <p class="small text-muted mt-1">Pay with your Credit Card</p>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="deb" value="DEBIT">
                                <label class="form-check-label" for="deb">
                                    Debit Card
                                </label>
                            </div>
                            <p class="small text-muted mt-1">Pay with your Debit Card</p>

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
                            <input type="hidden" name="orderId" value="<%=order.getOrderId()%>">
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