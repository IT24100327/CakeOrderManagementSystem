// test class to test my order class
//                             - Prageeth

package entities;

public class TestItem {
    private String name;
    private double price;

    public TestItem(String name, double price) {
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    @Override
    public String toString() {
        return name + ":" + price;
    }
}
