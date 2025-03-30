package entities;

import java.io.*;
import java.util.ArrayList;
import java.time.LocalDateTime;
import java.time.format.*;

import utils.ItemCatalog;

public class Order {
    private String orderId;
    private String userId;
    private String itemId;
    private String status;
    private double total;
    private String orderDate;
    private String deliveryDate;

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public Order(String userId, Item item, String status, double total, String deliveryDate) {
        orderId = null;
        this.userId = userId;
        this.itemId = item.getItemId();
        this.status = status;
        this.total = total;
        this.orderDate = LocalDateTime.now().format(formatter);
        this.deliveryDate = deliveryDate;
    }

    // constructor for make object from string
    public Order(String orderId, String userId, Item item, String status, double total, String orderDate,  String deliveryDate) {
        this.orderId = orderId;
        this.userId = userId;
        this.itemId = item.getItemId();
        this.status = status;
        this.total = total;
        this.orderDate = orderDate;
        this.deliveryDate = deliveryDate;
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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    @Override
    public String toString() {
        return orderId + "|" + userId + "|" + itemId + "|" + status + "|" + total + "|" + orderDate + "|" + deliveryDate;
    }

    // Convert a string to an Order object
    public static Order fromString(String str) {
        String[] parts = str.split("\\|");
        if (parts.length < 7) {
            throw new IllegalArgumentException("Invalid order string format");
        }

        String orderId = parts[0];
        String userId = parts[1];

        String itemId = parts[2];
        Item item = ItemCatalog.findItemById(itemId);

        String status = parts[3];
        double total = Double.parseDouble(parts[4]);
        String orderDate = parts[5];
        String deliveryDate = parts[6];

        return new Order(orderId, userId, item, status, total, orderDate, deliveryDate);
    }

    // Save order to file
    public void saveToFile(String filename) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename, true))) {
            writer.write(this.toString());
            writer.newLine();
        }
    }
}