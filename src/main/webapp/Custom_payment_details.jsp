<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.Item" %>
<%@ page import="utils.OrderQueue" %>
<%@ page import="entities.User" %>
<%@ page import="entities.CustomCakeOrder" %>


<%
    // Initialize with default values
    User user = (User) session.getAttribute("USER");

    CustomCakeOrder cco =null;
    if (request.getAttribute("cco") != null) {
        cco = (CustomCakeOrder) request.getAttribute("cco");
        System.out.println("new order found");
    } else {
        cco = (CustomCakeOrder) OrderQueue.findOrderById(request.getParameter("orderId"));
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
                    <div class="order-summary mb-4">
                        <h5 class="mb-3">Your Order [<%= cco.getOrderId() %>]</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Price:</strong></span>
                            <span>Rs. <%= cco.total() %></span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Custom Cake Details:</strong></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Occasion:</strong></span>
                            <span><%= cco.getOccasion() %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Flavor:</strong></span>
                            <span><%= cco.getCakeFlavour() %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Fillings:</strong></span>
                            <span><%= cco.getFilling() %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Cake Size:</strong></span>
                            <span><%= cco.getCakeSize() %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span><strong>Cake Shape:</strong></span>
                            <span><%= cco.getCakeShape() %></span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between fw-bold">
                            <span>Total:</span>
                            <span>Rs. <%= cco.total() %></span>
                        </div>
                    </div>

                    <!-- Customer Details Form -->
                    <form action="PaymentServlet" method="post">
                        <div>

                            <input type="hidden" name="action" value="pay">
                            <input type="hidden" name="orderId" value="<%= cco.getOrderId() %>">

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
                            <input type="hidden" name="orderId" value="<%=cco.getOrderId()%>">
                            <button type="submit" class="btn btn-outline-danger btn-lg">
                                Cancel
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
