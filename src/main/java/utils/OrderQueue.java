package utils;

import entities.Item;
import entities.Order;

import java.io.*;
import java.util.LinkedList;
import java.util.Queue;

import static entities.Order.fromString;

public class OrderQueue {
    private static Queue<Order> orderQueue = new LinkedList<>(); // Initialize here
    private static String FILE_PATH = "E:/Data/OrderQueue.txt"; // Relative path
    private static int lastOrderId = 0;

    public OrderQueue() {
    }

    public static String generateOrderId() {
        lastOrderId++;
        return String.format("ORD%04d", lastOrderId);
    }

    public static void add(Order order) throws IOException {
        if (order == null) {
            throw new IllegalArgumentException("Order cannot be null");
        }

        if (order.getOrderId() == null || order.getOrderId().isEmpty()) {
            order.setOrderId(generateOrderId());
        }
        orderQueue.add(order);
        saveToFile();
    }

    public static Queue<Order> getOrderQueue() {
        return new LinkedList<>(orderQueue);
    }

    public static void loadFromFile() throws IOException {
        File file = new File(FILE_PATH);

        // Create file if doesn't exist
        if (!file.exists()) {
            file.createNewFile();
            return;
        }

        // Clear existing orders before loading
        orderQueue.clear();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    if (!line.trim().isEmpty()) {
                        Order order = fromString(line);
                        if (order != null) {
                            orderQueue.add(order);

                            // Update lastOrderId
                            String idNumStr = order.getOrderId().replace("ORD", "");
                            int idNum = Integer.parseInt(idNumStr);
                            lastOrderId = Math.max(lastOrderId, idNum);
                        }
                    }
                } catch (Exception e) {
                    System.err.println("Error parsing order from line: " + line);
                    e.printStackTrace();
                }
            }
        }
    }

    public static void processNextOrder() throws IOException {
        if (!orderQueue.isEmpty()) {
            Order order = orderQueue.poll();
            if (order != null) {
                order.setStatus("Baking");
                saveToFile();
            }
        }
    }

    public static void cancelOrder(String orderId) {
        orderQueue.removeIf(order -> order != null && order.getOrderId().equals(orderId));
        saveToFile();
    }

    private static void saveToFile() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Order order : orderQueue) {
                if (order != null) {
                    writer.write(order.toString());
                    writer.newLine();
                }
            }
        } catch (IOException e) {
            System.err.println("Error saving orders to file: " + e.getMessage());
            e.printStackTrace();
        }
    }
}