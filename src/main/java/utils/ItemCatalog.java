package utils;

import entities.Item;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import static entities.Item.fromString;

public class ItemCatalog {
    private static List<Item> items = new ArrayList<>();
    private static String filePath = "E:/Data/ItemCatalog.txt";
    private static int lastItemId = 0;

    static {
        try {
            loadFromFile();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static String generateItemId() {
        lastItemId++;
        return String.format("ITM%04d", lastItemId);
    }

    // Add a new item to the catalog
    public static void addItem(Item item) throws IOException {
        if (item.getItemId() == null || item.getItemId().isEmpty()) {
            item.setItemId(generateItemId());
        }
        items.add(item);
        item.saveToFile(filePath);
    }

    // Remove an item from the catalog by item ID
    public static void removeItem(String itemId) {
        items.removeIf(item -> item.getItemId().equals(itemId));
        updateFile();
    }

    public static void updateItem(String itemId, String newItemName, double newItemPrice) {
        Item item = findItemById(itemId);
        item.setName(newItemName);
        item.setPrice(newItemPrice);
        updateFile();
    }

    private static void updateFile() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Item item : items) {
                writer.write(item.getName() + "|" + item.getPrice() + "|" + item.getItemId() + "|" + item.getCategory() + "|" + item.getDescription());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Find an item by its ID
    public static Item findItemById(String itemId) {
        for (Item item : items) {
            if (item.getItemId().equals(itemId)) {
                return item;
            }
        }
        return null; // Return null if the item is not found
    }



    public static void loadFromFile() throws IOException {
        File file = new File(filePath);
        if (!file.exists()) {
            System.out.println("File does not exist. Creating a new file.");
            file.createNewFile();
            return;
        }

        items.clear();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Item item = fromString(line);
                items.add(item);
                // remove text part
                String idNumStr = item.getItemId().replace("ITM", "");
                int idNum = Integer.parseInt(idNumStr);
                if (idNum > lastItemId) {
                    lastItemId = idNum;
                }
            }
        }
    }

    // Get a list of all items in the catalog
    public static List<Item> getAllItems() {
        return new ArrayList<>(items);
    }

    // Print all items in the catalog
    public void printCatalog() {
        for (Item item : items) {
            System.out.println(item);
        }
    }
}