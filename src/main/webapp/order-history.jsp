<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entities.Order" %>
<%@ page import="entities.Item" %>
<%@ page import="utils.ItemCatalog" %>
<%@ page import="utils.OrderService" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Order History</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
    }
    h1 {
      color: #333;
    }
    .order-card {
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 15px;
      margin-bottom: 20px;
      background-color: #f8f9fa;
    }
    .order-card h3 {
      margin-top: 0;
      border-bottom: 1px solid #eee;
      padding-bottom: 10px;
    }
    .order-info {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 10px;
    }
    .order-label {
      font-weight: bold;
    }
    .order-status {
      display: inline-block;
      padding: 5px 10px;
      border-radius: 4px;
      font-weight: bold;
    }
    .status-pending {
      background-color: #fff3cd;
      color: #856404;
    }
    .status-baking {
      background-color: #cce5ff;
      color: #004085;
    }
    .status-delivered {
      background-color: #d4edda;
      color: #155724;
    }
    .status-cancelled {
      background-color: #f8d7da;
      color: #721c24;
    }
    .no-orders {
      background-color: #f8f9fa;
      padding: 20px;
      border-radius: 8px;
      text-align: center;
    }
    .action-buttons {
      margin-top: 15px;
    }
    .action-buttons button {
      padding: 8px 15px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      margin-right: 10px;
    }
    .cancel-btn {
      background-color: #dc3545;
      color: white;
    }
    .cancel-btn:hover {
      background-color: #c82333;
    }
    .message {
      padding: 10px;
      margin: 20px 0;
      border-radius: 4px;
    }
    .success {
      background-color: #d4edda;
      color: #155724;
    }
    .error {
      background-color: #f8d7da;
      color: #721c24;
    }
  </style>
</head>
<body>
<h1>Your Order History</h1>

<%
  // Check if user is logged in
  String userId = (String) session.getAttribute("userId");
  if (userId == null) {
%>
<div class="message error">
  Please <a href="login.jsp">log in</a> to view your order history.
</div>
<% } else { %>

<%
  // Display success message if order was cancelled
  String message = request.getParameter("message");
  String messageType = request.getParameter("type");
  if (message != null && !message.isEmpty()) {
%>
<div class="message <%= messageType != null && messageType.equals("error") ? "error" : "success" %>">
  <%= message %>
</div>
<% } %>

<%
  // Get all orders for the user
  List<Order> userOrders = OrderService.getUserOrders(userId);

  if (userOrders.isEmpty()) {
%>
<div class="no-orders">
  <p>You haven't placed any orders yet.</p>
  <p><a href="order-form.jsp">Place your first order</a></p>
</div>
<% } else { %>

<% for (Order order : userOrders) {
  Item item = ItemCatalog.findItemById(order.getItemId());
  String itemName = (item != null) ? item.getName() : "Unknown Item";

  // Determine status class
  String statusClass = "";
  switch(order.getStatus().toLowerCase()) {
    case "pending":
      statusClass = "status-pending";
      break;
    case "baking":
      statusClass = "status-baking";
      break;
    case "delivered":
      statusClass = "status-delivered";
      break;
    case "cancelled":
      statusClass = "status-cancelled";
      break;
    default:
      statusClass = "";
  }
%>
<div class="order-card">
  <h3>Order #<%= order.getOrderId() %></h3>
  <div class="order-info">
    <div>
      <p><span class="order-label">Item:</span> <%= itemName %></p>
      <p><span class="order-label">Total:</span> $<%= String.format("%.2f", order.getTotal()) %></p>
      <p><span class="order-label">Status:</span> <span class="order-status <%= statusClass %>"><%= order.getStatus() %></span></p>
    </div>
    <div>
      <p><span class="order-label">Order Date:</span> <%= order.getOrderDate() %></p>
      <p><span class="order-label">Delivery Date:</span> <%= order.getDeliveryDate() %></p>
    </div>
  </div>

  <% if (order.getStatus().equalsIgnoreCase("Pending")) { %>
  <div class="action-buttons">
    <form action="cancel-order" method="post" onsubmit="return confirm('Are you sure you want to cancel this order?');">
      <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
      <button type="submit" class="cancel-btn">Cancel Order</button>
    </form>
  </div>
  <% } %>
</div>
<% } %>

<% } %>
<% } %>

<p><a href="order-form.jsp">Place a New Order</a></p>
<p><a href="index.jsp">Return to Home</a></p>
</body>
</html>