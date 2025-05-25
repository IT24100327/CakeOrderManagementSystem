package utils;

import entities.CustomCakeOrder;
import entities.ItemOrder;
import entities.Order;
import entities.Payment;

import java.io.*;
import java.time.LocalDate;

public class OrderQueue {
    private static final CustomQueue<Order> orderQueue = new CustomQueue<>();
    private static final String FILE_PATH = "E:/Data/OrderQueue.txt"; // Relative path
    private static int lastOrderId = 0;

    static {
        try {
            loadFromFile();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public OrderQueue() {
    }

    public static int getLastOrderId() {
        return lastOrderId;
    }

    public static void setLastOrderId(int lastOrderId) {
        OrderQueue.lastOrderId = lastOrderId;
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

        sortQueueByDeliveryDate();
        saveToFile();
        System.out.println("Added order and sorted by delivery date: " + order.getOrderId());
    }

    private static void sortQueueByDeliveryDate() {
        CustomQueue<ItemOrder> itemOrders = getItemQueue();
        CustomQueue<CustomCakeOrder> customOrders = getCustomQueue();

        BubbleSorter.bubbleSortByDeliveryDate(itemOrders);
        BubbleSorter.bubbleSortCustomOrdersByDate(customOrders);

        orderQueue.clear();

        while (!itemOrders.isEmpty()) {
            orderQueue.add(itemOrders.pop());
        }

        while (!customOrders.isEmpty()) {
            orderQueue.add(customOrders.pop());
        }
    }

    public static CustomQueue<Order> getOrderQueue() {
        return orderQueue;
    }

    public static CustomQueue<CustomCakeOrder> getCustomQueue() {
        CustomQueue<CustomCakeOrder> cco = new CustomQueue<>();
        for (Order order : orderQueue) {
            if (order instanceof CustomCakeOrder) {
                cco.add((CustomCakeOrder) order);
            }
        }
        return cco;
    }

    public static CustomQueue<ItemOrder> getItemQueue() {
        CustomQueue<ItemOrder> cco = new CustomQueue<>();
        for (Order order : orderQueue) {
            if (order instanceof ItemOrder) {
                cco.add((ItemOrder) order);
            }
        }
        return cco;
    }

    public static void loadFromFile() throws IOException {
        File file = new File(FILE_PATH);

        if (!file.exists()) {
            file.createNewFile();
            return;
        }

        orderQueue.clear();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts[0].equals("ItemOrder")) {
                    ItemOrder order = ItemOrder.fromString(line);
                    if (order != null) {
                        String idNumStr = order.getOrderId().replace("ORD", "");
                        int idNum = Integer.parseInt(idNumStr);
                        lastOrderId = Math.max(lastOrderId, idNum);
                        orderQueue.add(order);
                    }
                } else if (parts[0].equals("customOrder")) {
                    CustomCakeOrder order = CustomCakeOrder.fromStringToObject(line);
                    String idNumStr = order.getOrderId().replace("ORD", "");
                    int idNum = Integer.parseInt(idNumStr);
                    lastOrderId = Math.max(lastOrderId, idNum);
                    orderQueue.add(order);
                }
            }
            // Sort the queue after loading
            sortQueueByDeliveryDate();
            System.out.println("OrderQueue loaded From File!");
        }
    }

    public static Order findOrderById(String orderId) {
        for (Order order : orderQueue) {
            if (order.getOrderId().equals(orderId)) {
                return order;
            }
        }
        return null;
    }

    public static ItemOrder findItemOrderById(String itemOrderId) {
        for (Order order : orderQueue) {
            if (order.getOrderId().equals(itemOrderId)) {
                return (ItemOrder) order;
            }
        }
        return null;
    }

    public static CustomCakeOrder findCustomOrderById(String customOrderId) {
        for (Order order : orderQueue) {
            if (order.getOrderId().equals(customOrderId)) {
                return (CustomCakeOrder) order;
            }
        }
        return null;
    }
    // Already sorted (by delivery date)
    public static CustomQueue<CustomCakeOrder> getCustomOrdersByDeliveryDate() {
        return getCustomQueue();
    }

    // Already sorted (by delivery date)
    public static CustomQueue<ItemOrder> getItemOrdersByDeliveryDate() {
        return getItemQueue();
    }

    public static void updateItemOrder(String orderId, int quantity, LocalDate deliveryDate) {
        ItemOrder order = findItemOrderById(orderId);
        if (order != null) {
            order.setQuantity(quantity);
            order.setDeliveryDate(deliveryDate);

            sortQueueByDeliveryDate();
            saveToFile();
        }
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

    public static void setOrderStatus(String orderId, String status) {
        Order order = findOrderById(orderId);
        if (order != null) {
            order.setStatus(status);
        }
        saveToFile();
    }

    public static void setOrderPayment(String orderId, Payment payment) {
        Order order = findOrderById(orderId);
        if (order != null) {
            order.setPayment(payment);
        }
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