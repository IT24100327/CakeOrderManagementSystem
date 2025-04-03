import entities.Item;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Queue;

import entities.Order;
import utils.ItemCatalog;
import utils.OrderQueue;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    OrderQueue orderQueue = new OrderQueue();
    ItemCatalog catalog = new ItemCatalog();

    public void init() {

        try {
            OrderQueue.loadFromFile();
            catalog.loadFromFile();

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    } // Load orders on startup

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("place".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String itemId = request.getParameter("itemId");
            String status = "pending";
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String deliveryDate = request.getParameter("deliveryDate");
            double itemPrice = Double.parseDouble(request.getParameter("itemPrice"));

            double total = quantity * itemPrice;

            Order newOrder = new Order(userId, itemId, quantity, status, total, deliveryDate);
            OrderQueue.add(newOrder);
            response.sendRedirect("index.jsp");

        } else if ("update".equals(action)) {
            String orderId = request.getParameter("orderId");
            int newQuantity = Integer.parseInt(request.getParameter("quantity"));
            String newDeliveryDate = request.getParameter("deliveryDate");
            String itemId = request.getParameter("itemId");

            Item orderItem = catalog.findItemById(itemId);
            System.out.println(orderItem.getName());

            double newPrice = orderItem.getPrice() * newQuantity;

            OrderQueue.updateItem(orderId, newQuantity, newDeliveryDate, newPrice);
            response.sendRedirect("admin/");

        } else if ("to-process".equals(action)) {
            Queue<Order> allOrders = OrderQueue.getOrderQueue();
            // Find the first order with status "to-process"
            Order orderToProcess = null;
            for (Order order : allOrders) {
                if ("to-process".equals(order.getStatus())) {
                    orderToProcess = order;
                    break;
                }
            }

            OrderQueue.processOrder(orderToProcess);
            System.out.println(orderToProcess.getOrderId() + "Successfully processed");

            response.sendRedirect("admin/");

        } else if ("cancel".equals(action)) {
            String orderId = request.getParameter("orderId");
            OrderQueue.cancelOrder(orderId);
            response.sendRedirect("admin/");
        }
    }
}