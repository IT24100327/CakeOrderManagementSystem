import entities.Order;
import utils.OrderQueue;

import java.io.File;
import java.io.IOException;

public class OrderTest {
    public static void main(String[] args) {
        OrderQueue orderQueue = new OrderQueue();

        // Set the file path (optional)
        orderQueue.setFilePath(new File("data/orders.txt"));

        try {
            // Load existing orders from the file
            orderQueue.loadFromFile();

            Order order = new Order("123", "user1", "Cake", "Pending", 30.0);

            // Add the order to the queue and save it to the file
            orderQueue.add(order);

            // Print all orders in the queue
            for (Order o : orderQueue.getOrderQueue()) {
                System.out.println(o);
            }
        } catch (IOException e) {
            System.err.println("Error: " + e.getMessage());
        }
    }
}