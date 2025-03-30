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
        try {
            OrderQueue.loadFromFile();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    } // Load orders on startup

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("place".equals(action)) {
            String userId = request.getParameter("userId");
            String itemId = request.getParameter("itemList");
            String status = request.getParameter("status");
            double total = Double.parseDouble(request.getParameter("total"));

            Order newOrder = new Order(userId, itemId, status, total);
            OrderQueue.add(newOrder);
            response.sendRedirect("orders.jsp");

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