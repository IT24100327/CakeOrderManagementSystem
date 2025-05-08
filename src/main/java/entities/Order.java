package entities;

import java.io.*;
import java.util.ArrayList;
import java.time.LocalDateTime;
import java.time.format.*;

import utils.ItemCatalog;

public class Order {
    protected String orderId;
    protected int userId;
    protected String itemId;
    protected int quantity;
    protected String status;
    protected double total;
    protected String orderDate;
    protected String deliveryDate;

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public Order(int userId, String itemId, int quantity, String status, double total, String deliveryDate) {
        orderId = null;
        this.userId = userId;
        this.itemId = itemId;
        this.status = status;
        this.quantity = quantity;
        this.total = total;
        this.orderDate = LocalDateTime.now().format(formatter);
        this.deliveryDate = deliveryDate;
    }

    // constructor for make object from string
    public Order(String orderId, int userId, String itemId, int quantity, String status, double total, String orderDate, String deliveryDate) {
        this.orderId = orderId;
        this.userId = userId;
        this.itemId = itemId;
        this.status = status;
        this.quantity = quantity;
        this.total = total;
        this.orderDate = orderDate;
        this.deliveryDate = deliveryDate;
    }
// Constructor for customCakeOrder
    public Order(String orderId, int userId) {
        this.orderId = orderId;
        this.userId = userId;

    }

    public int getUserId() {
        return userId;
    }


    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(String deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    @Override
    public String toString() {
        return orderId + "|" + userId + "|" + itemId + "|" + status + "|" + quantity + "|" + total + "|" + orderDate + "|" + deliveryDate;
    }

    // Convert a string to an Order object
    public static Order fromString(String str) throws IOException {
        String[] parts = str.split("\\|");
        if (parts.length < 8) {
            throw new IllegalArgumentException("Invalid order string format");
        }

        String orderId = parts[0];
        int userId = Integer.parseInt(parts[1]);
        String itemId = parts[2];
        String status = parts[3];
        int quantity = Integer.parseInt(parts[4]);
        double total = Double.parseDouble(parts[5]);
        String orderDate = parts[6];
        String deliveryDate = parts[7];

        return new Order(orderId, userId, itemId, quantity, status, total, orderDate, deliveryDate);
    }

}

