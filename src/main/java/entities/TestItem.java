// test class to test my order class
//                             - Prageeth

package entities;

public class TestItem {
    private String name;
    private double price;
    private String itemId;

    public TestItem(String name, double price, String itemId) {
        this.name = name;
        this.price = price;
        this.itemId = itemId;
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

    @Override
    public String toString() {
        return name + ":" + price;
    }
}
