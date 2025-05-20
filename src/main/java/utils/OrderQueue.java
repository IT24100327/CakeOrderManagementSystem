package utils;

import entities.CustomCakeOrder;
import entities.ItemOrder;
import entities.Order;
import entities.Payment;

import java.io.*;
import java.time.LocalDate;
import java.util.LinkedList;
import java.util.Queue;


public class OrderQueue {
    private static final Queue<Order> orderQueue = new LinkedList<>();
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
        saveToFile();
        System.out.println("Added a order");
    }

    public static Queue<Order> getOrderQueue() {
        return new LinkedList<>(orderQueue);
    }

    public static Queue<CustomCakeOrder> getCustomQueue() {
        LinkedList<CustomCakeOrder> cco = new LinkedList<>();
        for (Order order: orderQueue) {
            if (order instanceof CustomCakeOrder) {
                CustomCakeOrder customOrder = (CustomCakeOrder) order;
                cco.add(customOrder);
            }
        }
        return cco;
    }

    public static Queue<ItemOrder> getItemQueue() {
        LinkedList<ItemOrder> cco = new LinkedList<>();
        for (Order order: orderQueue) {
            if (order instanceof ItemOrder) {
                ItemOrder customOrder = (ItemOrder) order;
                cco.add(customOrder);
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
                }

                else if (parts[0].equals("customOrder")) {
                    CustomCakeOrder order = CustomCakeOrder.fromStringToObject(line);
                    String idNumStr = order.getOrderId().replace("ORD", "");
                    int idNum = Integer.parseInt(idNumStr);
                    lastOrderId = Math.max(lastOrderId, idNum);
                    orderQueue.add(order);
                }

            }

            System.out.println("OrderQueue loaded From File!");

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

    public static Queue<CustomCakeOrder> getCustomOrdersByDeliveryDate() {
        Queue<CustomCakeOrder> cco = new LinkedList<>();
        for(Order order : orderQueue){
            if (order instanceof CustomCakeOrder) {
                CustomCakeOrder customOrder = (CustomCakeOrder) order;
                cco.add(customOrder);
            }
        }
        BubbleSorter.bubbleSortCustomOrdersByDate(cco);
        return cco;
    }

    public static Queue<ItemOrder> getItemOrdersByDeliveryDate() {
        Queue<ItemOrder> itemOrderQ = new LinkedList<>();
        for(Order order : orderQueue){
            if (order instanceof ItemOrder) {
                ItemOrder itemOrder = (ItemOrder) order;
                itemOrderQ.add(itemOrder);
            }
        }
        BubbleSorter.bubbleSortByDeliveryDate(itemOrderQ);
        return itemOrderQ;
    }

    public static void updateItemOrder(String orderId, int quantity, LocalDate deliveryDate) {
        ItemOrder order = findItemOrderById(orderId);
        if (order != null) {
            order.setQuantity(quantity);
            order.setDeliveryDate(deliveryDate);
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