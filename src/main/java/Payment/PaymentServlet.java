import entities.CardPayment;
import entities.CashPayment;
import entities.Order;
import entities.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.ItemCatalog;
import utils.OrderQueue;
import utils.PaymentHandle;


import java.io.IOException;


@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    ItemCatalog catalog = new ItemCatalog();

    public void init() {

        try {
            OrderQueue.loadFromFile();
            System.out.println("OrderQueue loaded");
            catalog.loadFromFile();
            System.out.println("ItemQueue loaded");
            PaymentHandle.loadFromFile();
            System.out.println("payments loaded");

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    } // Load orders on startup

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("pay".equals(action)) {
            String orderId = request.getParameter("orderId");

            Order order = OrderQueue.findOrderById(orderId);

            Double paymentAmount = Double.parseDouble(request.getParameter("paymentAmount"));
            String paymentMethod = request.getParameter("paymentMethod");

            Payment newPayment = null;

            if (paymentMethod.equals("cash")) {
                newPayment = new CashPayment(order, paymentAmount, paymentMethod);
                PaymentHandle.addPayment(newPayment);
            }

            if (paymentMethod.equals("card")) {
                newPayment = new CardPayment(order, paymentAmount, paymentMethod);
                PaymentHandle.addPayment(newPayment);
            }

            if (newPayment != null) {
                PaymentHandle.pay(newPayment.getPaymentId());
                System.out.println("Changed Payment Status: " + newPayment.getPaymentStatus());
                OrderQueue.processOrder(order);
                System.out.println("Order [" + orderId + "] status changed to \"To Process\" ");
                System.out.println("Payment added: " + newPayment.getPaymentId());
            } else {
                System.out.println("Payment not Created");
            }

            System.out.println("Redirecting...");
            response.sendRedirect("profile");

        } else if ("cancel".equals(action)) {
            System.out.println("Cancelling Payment...");
            System.out.println("Redirecting...");
            response.sendRedirect("profile");

        } else if ("refund".equals(action)) {
            System.out.println("Refunding Payment...");
            System.out.println("Redirecting...");

            Payment payment = PaymentHandle.findPaymentById(request.getParameter("paymentId"));
            PaymentHandle.removePayment(payment);

            response.sendRedirect("admin/");

        }
    }
}