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

    private static String generateOrderId() {
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

        orderQueue.clear();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                        Order order = fromString(line);
                        orderQueue.add(order);

                        // Update lastOrderId
                        String idNumStr = order.getOrderId().replace("ORD", "");
                        int idNum = Integer.parseInt(idNumStr);
                        lastOrderId = Math.max(lastOrderId, idNum);
            }
        }
    }

    // Find an item by its ID
    public static Order findOrderById(String orderId) {
        for (Order order : orderQueue) {
            if (order.getOrderId().equals(orderId)) {
                return order;
            }
        }
        return null;
    }

    public static void sortOrderByDeliveryDate() {
        OrderSorter.bubbleSortByDeliveryDate(orderQueue);
    }

    public static void updateItem(String orderId, int quantity, String deliveryDate, double newItemPrice) {
        Order order = findOrderById(orderId);
        if (order != null) {
            order.setQuantity(quantity);
            order.setDeliveryDate(deliveryDate);
            order.setTotal(newItemPrice);
        }

        saveToFile();
    }

    public static void processOrder(Order orderToProcess) throws IOException {
        if (orderToProcess != null && orderToProcess.getStatus().equals("pending")) {
            orderToProcess.setStatus("to-process");
        } else if (orderToProcess != null && orderToProcess.getStatus().equals("to-process")) {
            orderToProcess.setStatus("baking");
        } else if (orderToProcess != null && orderToProcess.getStatus().equals("baking")) {
            orderToProcess.setStatus("finished");
        }

        saveToFile();
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