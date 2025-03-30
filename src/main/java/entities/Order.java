package entities;

import java.io.*;
import java.util.ArrayList;

public class Order {
    private static int orderCounter = 0;
    private String orderId;
    private String userId;
    private String itemId;
    private String status;
    private double total;

    public Order(String userId, String itemId, String status, double total) {
        this.userId = userId;
        this.itemId = itemId;
        this.status = status;
        this.total = total;

        orderId = String.valueOf(orderCounter++);

    }

    public Order(String orderId, String userId, String itemId, String status, double total) {
        this.orderId = orderId;
        this.userId = userId;
        this.itemId = itemId;
        this.status = status;
        this.total = total;
    }

    public static int getOrderCounter() {
        return orderCounter;
    }

    public static void setOrderCount(int orderCount) {
        orderCounter = orderCount;
    }

    public String getOrderId() {
        return orderId;
    }

    public String getUserId() {
        return userId;
    }

    public String getItemId() {
        return itemId;
    }

    public String getStatus() {
        return status;
    }

    public double getTotal() {
        return total;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return orderId + "|" + userId + "|" + itemId + "|" + status + "|" + total;
    }

    // Convert a string to an Order object
    public static Order fromString(String str) {
        String[] parts = str.split("\\|");
        if (parts.length < 5) {
            throw new IllegalArgumentException("Invalid order string format");
        }

        String orderId = parts[0];
        String userId = parts[1];
        String itemId = parts[2];
        String status = parts[3];
        double total = Double.parseDouble(parts[4]);

        return new Order(orderId, userId, itemId, status, total);
    }

    // Save order to file
    public void saveToFile(String filename) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename, true))) {
            writer.write(this.toString());
            writer.newLine();
        }
    }
}