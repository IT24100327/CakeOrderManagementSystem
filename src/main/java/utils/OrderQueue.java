package utils;

import entities.CustomCakeOrder;
import entities.Order;

import java.io.*;
import java.util.LinkedList;
import java.util.Queue;


public class OrderQueue {
    private static Queue<Order> orderQueue = new LinkedList<>();
    private static Queue<Order> normalQueue = new LinkedList<>(); // Initialize here
    private static String FILE_PATH = "E:/Data/OrderQueue.txt"; // Relative path
    private static int lastOrderId = 0;

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

    public static String[] getCustomOrderDetailsById() throws FileNotFoundException {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                    CustomCakeOrder order =  CustomCakeOrder.fromStringToObject(line);
                    String idNumStr = order.getOrderId().replace("ORD", "");
                    int idNum = Integer.parseInt(idNumStr);
                    if(idNum == lastOrderId){
                        String[] parts = line.split("\\|");
                        return parts;
                    }
            }
        } catch (IOException e) {
            System.err.println("Not Creat Custom Order Details Array " + e.getMessage());
            e.printStackTrace();
        }

        return null;
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

    public static Queue<Order> getNormalOrderQueue(){
        return new LinkedList<>(normalQueue);
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

    //public static Queue<CustomCakeOrder> getCustomQueue() {
        //return new LinkedList<>(customQueue);
    //}

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
                String[] parts = line.split("\\|");
                if (parts[0].equals("normalOrder")) {
                    Order order = Order.fromString(line);
                    String idNumStr = order.getOrderId().replace("ORD", "");
                    int idNum = Integer.parseInt(idNumStr);
                    lastOrderId = Math.max(lastOrderId, idNum);
                    orderQueue.add(order);
                }

                else if (parts[0].equals("customOrder")) {
                    CustomCakeOrder order = CustomCakeOrder.fromStringToObject(line);
                    String idNumStr = order.getOrderId().replace("ORD", "");
                    int idNum = Integer.parseInt(idNumStr);
                    lastOrderId = Math.max(lastOrderId, idNum);
                    orderQueue.add(order);
                }

                        // Update lastOrderId
                       // String idNumStr = order.getOrderId().replace("ORD", "");
                        //int idNum = Integer.parseInt(idNumStr);
                        //lastOrderId = Math.max(lastOrderId, idNum);
            }
            System.out.println("File loaded");
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
        for(Order order : orderQueue){
            if(!order.getItemId().equals("CUSTOMCAKE")){
                normalQueue.add(order);
            }
        }
        BubbleSorter.bubbleSortByDeliveryDate(normalQueue);
    }

    // Sorting part for Custom Cake
    public static void sortOrderByDate() {
        BubbleSorter.bubbleSortByDeliveryDate(orderQueue);
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