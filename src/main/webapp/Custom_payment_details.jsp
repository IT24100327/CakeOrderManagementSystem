<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Item" %>
<%@ page import="utils.OrderQueue" %>


<%
    // Initialize with default values
    int userId = 0;
    String itemId = null;

    int quantity = 1;
    Item selectedItem = null;
    String error = null;

    String [] customOrderDetails = OrderQueue.getCustomOrderDetailsById();

    assert customOrderDetails != null;

    String orderId = customOrderDetails[1];
    String total = customOrderDetails[5];
    String occasion = customOrderDetails[7];
    String flavor = customOrderDetails[8];
    String fillings = customOrderDetails[9];
    String size = customOrderDetails[10];
    String shape = customOrderDetails[11];


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
<%--                    <% if (selectedItem != null) { %>--%>
                    <!-- Order Summary -->
                    <div class="order-summary mb-4">
                        <h5 class="mb-3">Your Order [<%= orderId %>]</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Item:</strong></span>
                            <span>Custom Cake</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Price:</strong></span>
                            <span>Rs. <%= total %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Quantity:</strong></span>
                            <span>x<%=quantity%></span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Custom Cake Details:</strong></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Occasion:</strong></span>
                            <span><%=occasion%></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Flavor:</strong></span>
                            <span><%=flavor%></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Fillings:</strong></span>
                            <span><%=fillings%></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Cake Size:</strong></span>
                            <span><%=size%></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Cake Shape:</strong></span>
                            <span><%=shape%></span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between fw-bold">
                            <span>Total:</span>
                            <span>Rs. <%=total%></span>
                        </div>
                    </div>

                    <!-- Customer Details Form -->
                    <form action="PaymentServlet" method="post">
                        <div>

                            <input type="hidden" name="action" value="pay">
                            <input type="hidden" name="orderId" value="<%= orderId %>">
                            <input type="hidden" name="paymentAmount" value="<%= total %>">

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
                    <div style="margin-top: 20px;">
                        <form action="PaymentServlet" method="post" style="">
                            <input type="hidden" name="action" value="cancel">
                            <button type="submit" class="btn btn-outline-danger btn-lg">
                                Cancel
                            </button>
                        </form>
                    </div>

<%--                    <% } else { %>--%>
<%--                    <div class="alert alert-danger">Item not found. Please try again.</div>--%>
<%--                    <% } %>--%>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
