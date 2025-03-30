package utils;

import entities.Order;

import java.io.*;
import java.util.LinkedList;
import java.util.Queue;

import static entities.Order.fromString;

public class OrderQueue {
    private static Queue<Order> orderQueue;
    private static String FILE_PATH;

    // Constructor to initialize the queue and set the default file path
    public OrderQueue() {
        orderQueue = new LinkedList<>(); // Initialize the class-level orderQueue
        FILE_PATH = "data/orders.txt"; // Default file path
    }

    // Method to set a custom file path
    public static void setFilePath(File path) {
        FILE_PATH = path.getAbsolutePath();
        System.out.println("File path set to: " + FILE_PATH);
        System.out.println("File exists: " + path.exists());
    }

    // Add an order to the queue and save it to the file
    public static void add(Order order) throws IOException {
        orderQueue.add(order);
        order.saveToFile(FILE_PATH);
        System.out.println("Order added: " + order);
    }


    // Get the order queue
    public Queue<Order> getOrderQueue() {
        return orderQueue;
    }

    // Load orders from file to the queue
    public static void loadFromFile() throws IOException {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            System.out.println("File does not exist. Creating a new file.");
            file.createNewFile(); // Create the file if it doesn't exist
            return;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            int orderCount = 0;
            while ((line = reader.readLine()) != null) {
                orderQueue.add(fromString(line));
                orderCount++;
            }
            Order.setOrderCount(orderCount);
        }
    }

    // Process Next Order (Move to Baking)
    public static void processNextOrder() throws IOException {
        if (!orderQueue.isEmpty()) {
            Order order = orderQueue.poll();
            if (order != null) {
                order.setStatus("Baking");
                order.saveToFile(FILE_PATH);
            }
        }
    }

    // Cancel Order
    public static void cancelOrder(String orderId) {
        // removeIf method can remove elements from anywhere in the queue based on the condition.
        orderQueue.removeIf(order -> order.getOrderId().equals(orderId));
        updateFile();
    }

    // Save Updated Orders Back to File
    private static void updateFile() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Order order : orderQueue) {
                writer.write(order.getOrderId() + "," + order.getUserId() + "," + order.getItemId() + "," + order.getStatus());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}