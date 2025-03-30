package utils;

import entities.Item;
import entities.Order;

import java.io.*;
import java.util.LinkedList;
import java.util.Queue;

import static entities.Order.fromString;

public class OrderQueue {
    private static Queue<Order> orderQueue;
    private static String FILE_PATH;
    private static int lastItemId = 0;

    // Constructor to initialize the queue and set the default file path
    public OrderQueue() {
        orderQueue = new LinkedList<>();
        FILE_PATH = "E:/Data/OrderQueue.txt";
    }

    private static String generateItemId() {
        lastItemId++;
        return String.format("ORD%04d", lastItemId);
    }

    // Add an order to the queue and save it to the file
    public static void add(Order order) throws IOException {
        if (order.getItemId() == null || order.getItemId().isEmpty()) {
            order.setItemId(generateItemId());
        }
        orderQueue.add(order);
        order.saveToFile(FILE_PATH);
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
                Order order = fromString(line);
                orderQueue.add(order);
                // remove text part
                String idNumStr = order.getOrderId().replace("ORD", "");
                int idNum = Integer.parseInt(idNumStr);
                if (idNum > lastItemId) {
                    lastItemId = idNum;
                }
            }
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