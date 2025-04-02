import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import entities.Order;
import utils.OrderQueue;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    public void init() {
        OrderQueue orderQueue = new OrderQueue();

        try {

            OrderQueue.loadFromFile();

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

        } else if ("process".equals(action)) {
            OrderQueue.processNextOrder();
            response.sendRedirect("orders.jsp");

        } else if ("cancel".equals(action)) {
            String orderId = request.getParameter("orderId");
            OrderQueue.cancelOrder(orderId);
            response.sendRedirect("orders.jsp");
        }
    }
}