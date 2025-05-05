import entities.Item;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Queue;

import entities.Order;
import org.w3c.dom.ls.LSOutput;
import utils.ItemCatalog;
import utils.OrderQueue;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    ItemCatalog catalog = new ItemCatalog();

    public void init() {

        try {
            OrderQueue.loadFromFile();
            System.out.println("OrderQueue loaded");
            catalog.loadFromFile();
            System.out.println("ItemQueue loaded");

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    } // Load orders on startup

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        Queue<Order> allOrders = OrderQueue.getOrderQueue();

        if ("place".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String itemId = request.getParameter("itemId");
            String status = "pending";
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String deliveryDate = request.getParameter("deliveryDate");
            double itemPrice = Double.parseDouble(request.getParameter("itemPrice"));
            System.out.println("Collected Parameters from Form!");
            System.out.println("User ID: " + userId);
            System.out.println("Item ID: " + itemId);

            double total = quantity * itemPrice;
            request.setAttribute("total", total);
            System.out.println("Total calculated: " + total);

            Order newOrder = new Order(userId, itemId, quantity, status, total, deliveryDate);
            System.out.println("Created Order Object");
            OrderQueue.add(newOrder);
            request.setAttribute("orderId", newOrder.getOrderId());
            System.out.println("Order added: " + newOrder.getOrderId());
            System.out.println("Redirecting...");

            RequestDispatcher dispatcher = request.getRequestDispatcher("payment_details.jsp");
            dispatcher.forward(request, response);

        } else if ("update".equals(action)) {
            String orderId = request.getParameter("orderId");
            int newQuantity = Integer.parseInt(request.getParameter("quantity"));
            String newDeliveryDate = request.getParameter("deliveryDate");
            String itemId = request.getParameter("itemId");

            System.out.println("Collected Parameters from Form");

            Item orderItem = catalog.findItemById(itemId);
            System.out.println("Item Found: " + orderItem.getName());

            double newPrice = orderItem.getPrice() * newQuantity;
            System.out.println("New Total calculated: " + newPrice);

            OrderQueue.updateItem(orderId, newQuantity, newDeliveryDate, newPrice);
            System.out.println("Order Successfully Updated: " + orderId);
            System.out.println("Redirecting...");
            response.sendRedirect("admin/");

        } else if ("to-process".equals(action)) {

            // Find the first order with status "to-process"
            Order orderToProcess = null;
            for (Order order : allOrders) {
                if ("to-process".equals(order.getStatus())) {
                    orderToProcess = order;
                    System.out.println("Found Order to Process: " + order.getOrderId());
                    break;
                }
            }

            OrderQueue.processOrder(orderToProcess);
            System.out.println(orderToProcess.getOrderId() + " was Successfully processed");
            System.out.println(orderToProcess.getOrderId() + " : Status Changed to " + orderToProcess.getStatus());

            response.sendRedirect("admin/");

        } else if ("baking".equals(action)) {

            // Find the first order with status "to-process"
            Order orderToProcess = null;
            for (Order order : allOrders) {
                if ("baking".equals(order.getStatus())) {
                    orderToProcess = order;
                    System.out.println("Found Order to Process: " + order.getOrderId());
                    break;
                }
            }

            OrderQueue.processOrder(orderToProcess);
            System.out.println(orderToProcess.getOrderId() + " was Successfully processed");
            System.out.println(orderToProcess.getOrderId() + " : Status Changed to " + orderToProcess.getStatus());

            response.sendRedirect("admin/");

        } else if ("cancel".equals(action)) {
            String orderId = request.getParameter("orderId");
            System.out.println("Canceling Order: " + orderId);
            OrderQueue.cancelOrder(orderId);
            System.out.println("Order: " + orderId + " was Successfully cancelled");
            System.out.println("Redirecting...");
            response.sendRedirect("admin/");
        }
    }
}