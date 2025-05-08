package entities;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class Item {
    private String name;
    private double price;
    private String itemId;
    private String category;
    private String description;

    public Item(String name, double price, String itemId, String category, String description) {
        this.name = name;
        this.price = price;
        this.itemId = itemId;
        this.category = category;
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public String getItemId() {
        return itemId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    @Override
    public String toString() {
        return name + "|" + price + "|" + itemId + "|" + category +  "|" + description;
    }

    // Convert a string to an Order object
    public static Item fromString(String str) {
        String[] parts = str.split("\\|");
        if (parts.length < 5) {
            throw new IllegalArgumentException("Invalid order string format");
        }

        String name = parts[0];
        double price = Double.parseDouble(parts[1]);
        String itemId = parts[2];
        String category = parts[3];
        String description = parts[4];

        return new Item(name, price, itemId, category, description);
    }

    // Save order to file
    public void saveToFile(String filename) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename, true))) {
            writer.write(this.toString());
            writer.newLine();
        }
    }
}
