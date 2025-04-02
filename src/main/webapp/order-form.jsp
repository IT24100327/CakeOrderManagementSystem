<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entities.Item" %>
<%@ page import="utils.ItemCatalog" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Place an Order</title>
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
        .item-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .item-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            transition: transform 0.3s ease;
        }
        .item-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .item-card h3 {
            margin-top: 0;
        }
        .price {
            font-weight: bold;
            color: #e63946;
        }
        form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        select, input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #45a049;
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
<h1>Place an Order</h1>

<%
    // Check if user is logged in
    String userId = (String) session.getAttribute("userId");
    if (false) {
%>
<div class="message error">
    Please <a href="login.jsp">log in</a> to place an order.
</div>
<% } else { %>

<%
    // Display success message if order was placed
    String message = request.getParameter("message");
    String messageType = request.getParameter("type");
    if (message != null && !message.isEmpty()) {
%>
<div class="message <%= messageType != null && messageType.equals("error") ? "error" : "success" %>">
    <%= message %>
</div>
<% } %>

<%
    ItemCatalog catalog = new ItemCatalog();
    catalog.loadFromFile();

    List<Item> items = catalog.getAllItems();
%>

<h2>Order Form</h2>
<form action="OrderServlet" method="post">

    <input type="hidden" name="action" value="place">


<%--    <% Double itemPrice = Double.parseDouble(request.getParameter("ItemPrice")); %>--%>
    <input type="hidden" name="itemPrice" value="500">
    <input type="hidden" name="userId" value=1>
    <input type="hidden" name="itemId" value="IT9999">

<%--    <% String itemId = request.getParameter("itemId"); %>--%>


    <div class="form-group">
        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" min="1" value="1" required>
    </div>

    <div class="form-group">
        <label for="deliveryDate">Delivery Date:</label>
        <%
            // Set min date to tomorrow
            LocalDate tomorrow = LocalDate.now().plusDays(1);
            String tomorrowStr = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        %>
        <input type="date" id="deliveryDate" name="deliveryDate" min="<%= tomorrowStr %>" required>
    </div>

    <button type="submit">Place Order</button>
</form>
<% } %>

</body>
</html>