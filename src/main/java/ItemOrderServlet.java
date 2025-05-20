import entities.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.Queue;

import utils.ItemCatalog;
import utils.OrderQueue;
import utils.PaymentHandle;

@WebServlet("/ItemOrderServlet")
public class ItemOrderServlet extends HttpServlet {

    public void init() {

        try {
            OrderQueue.loadFromFile();
            System.out.println("OrderQueue loaded");
            ItemCatalog.loadFromFile();
            System.out.println("ItemQueue loaded");
            PaymentHandle.loadFromFile();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    } // Load orders on startup

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("USER");
        String action = request.getParameter("action");
        Queue<Order> allOrders = OrderQueue.getOrderQueue();

        if ("place".equals(action)) {
            Item item = ItemCatalog.findItemById(request.getParameter("itemId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            LocalDate deliveryDate = LocalDate.parse(request.getParameter("deliveryDate"));

            ItemOrder newOrder = new ItemOrder(item, user, quantity, null, deliveryDate);

            System.out.println("Created Item Order Object");
            OrderQueue.add(newOrder);

            request.setAttribute("order", newOrder);
            System.out.println("Redirecting...");
            RequestDispatcher dispatcher = request.getRequestDispatcher("payment_details.jsp");
            dispatcher.forward(request, response);

        } else if ("update".equals(action)) {
            String orderId = request.getParameter("orderId");
            ItemOrder order = OrderQueue.findItemOrderById(orderId);

            int newQuantity = Integer.parseInt(request.getParameter("quantity"));
            LocalDate newDeliveryDate = LocalDate.parse(request.getParameter("deliveryDate"));

            System.out.println("Collected Parameters from Form");

            Item orderItem = order.getItem();
            System.out.println("Item Found: " + orderItem.getName());

            double newPrice = orderItem.getPrice() * newQuantity;
            System.out.println("New Total calculated: " + newPrice);

            Payment payment = order.getPayment();
            payment.setPaymentAmount(newPrice);
            OrderQueue.setOrderPayment(orderId, payment);

            OrderQueue.updateItemOrder(orderId, newQuantity, newDeliveryDate);
            System.out.println("Order Successfully Updated: " + orderId);
            System.out.println("Redirecting...");

            if (user.getROLE().equals("ADMIN")) {
                response.sendRedirect(request.getContextPath() + "/admin/ManageOrders.jsp");
                return;
            } else {
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }


        } else if ("cancel".equals(action)) {
            String orderId = request.getParameter("orderId");
            OrderQueue.setOrderStatus(orderId, "cancelled");

            response.sendRedirect(request.getContextPath() + "/admin/ManageOrders.jsp");
        }

    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String orderId = request.getParameter("orderId");

        if (action.equals("process")) {
            OrderQueue.setOrderStatus(orderId, "in-progress");
            response.sendRedirect(request.getContextPath() + "/admin/ManageOrders.jsp");
        }

        if(action.equals("finish")) {
            OrderQueue.setOrderStatus(orderId, "finished");
            response.sendRedirect(request.getContextPath() + "/admin/ManageOrders.jsp");
        }

    }
}