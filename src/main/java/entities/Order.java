// Implemented itemlist as a ArrayList

package entities;

import java.io.*;
import java.util.ArrayList;

public class Order {
    private String orderId;
    private String userId;

    //TODO: After Item Class is Properly Implemented Change Accordingly
    private ArrayList<TestItem> itemList;

    private String status;
    private double total;

    public Order(String orderId, String userId, ArrayList<TestItem> itemList, String status, double total) {
        this.orderId = orderId;
        this.userId = userId;
        this.itemList = (itemList != null) ? itemList : new ArrayList<>();
        this.status = status;
        this.total = total;
    }

    @Override
    public String toString() {
        return orderId + "|" + userId + "|" + serializeItemList() + "|" + status + "|" + total;
    }

    // Converts ArrayList<Item> into a String (Item1_Name:Price,Item2_Name:Price,...)
    private String serializeItemList() {
        if (itemList.isEmpty()) return "EMPTY";

        //TODO: After Item Class is Properly Implemented Change Accordingly
        StringBuilder sb = new StringBuilder();
        for (TestItem item : itemList) {
            sb.append(item.getName()).append(":").append(item.getPrice()).append(",");
        }
        return sb.substring(0, sb.length() - 1); // Remove trailing comma
    }

    // Converts a String back into an ArrayList<Item>
    private static ArrayList<TestItem> deserializeItemList(String str) {
        ArrayList<TestItem> items = new ArrayList<>();
        if (str.equals("EMPTY")) return items;

        //TODO: After Item Class is Properly Implemented Change Accordingly
        String[] itemParts = str.split(",");
        for (String itemStr : itemParts) {
            String[] itemData = itemStr.split(":");
            if (itemData.length == 2) {
                String name = itemData[0];
                double price = Double.parseDouble(itemData[1]);
                items.add(new TestItem(name, price));
            }
        }
        return items;
    }


    // Convert a string to an Order object
    public static Order fromString(String str) {
        String[] parts = str.split("\\|");
        if (parts.length < 5) {
            throw new IllegalArgumentException("Invalid order string format");
        }

        String orderId = parts[0];
        String userId = parts[1];
        ArrayList<TestItem> itemList = deserializeItemList(parts[2]);
        String status = parts[3];
        double total = Double.parseDouble(parts[4]);

        return new Order(orderId, userId, itemList, status, total);
    }

    // Save order to file
    public void saveToFile(String filename) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename, true))) {
            writer.write(this.toString());
            writer.newLine();
        }
    }

    // Load orders from file
    public static ArrayList<Order> loadFromFile(String filename) throws IOException {
        ArrayList<Order> orders = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = reader.readLine()) != null) {
                orders.add(fromString(line));
            }
        }
        return orders;
    }
}
