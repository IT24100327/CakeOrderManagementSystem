import entities.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

//import entities.Order;
import utils.ItemCatalog;
import utils.OrderQueue;
import utils.PaymentHandle;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    public void init() {

        try {
            OrderQueue.loadFromFile();
            System.out.println("OrderQueue loaded");
            ItemCatalog.loadFromFile();
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
            Order order = OrderQueue.findOrderById(request.getParameter("orderId"));
            String paymentMethod = request.getParameter("paymentMethod");

            if (order instanceof ItemOrder) {
                ItemOrder itemOrder = (ItemOrder) order;
                Double paymentAmount = itemOrder.getItem().getPrice() * itemOrder.getQuantity();

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
                    OrderQueue.setOrderPayment(newPayment.getOrder().getOrderId(), newPayment);
                    OrderQueue.setOrderStatus(order.getOrderId(), "confirmed");
                } else {
                    System.out.println("Payment not Created");
                }

            }

            if (order instanceof CustomCakeOrder) {
                CustomCakeOrder customCakeOrder = (CustomCakeOrder) order;
                Double payAmount = customCakeOrder.total();

                Payment newPayment = null;

                if (paymentMethod.equals("cash")) {
                    newPayment = new CashPayment(order, payAmount, paymentMethod);
                    PaymentHandle.addPayment(newPayment);
                }

                if (paymentMethod.equals("card")) {
                    newPayment = new CardPayment(order, payAmount, paymentMethod);
                    PaymentHandle.addPayment(newPayment);
                }

                if (newPayment != null) {
                    PaymentHandle.pay(newPayment.getPaymentId());
                    OrderQueue.setOrderPayment(newPayment.getOrder().getOrderId(), newPayment);
                    OrderQueue.setOrderStatus(order.getOrderId(), "to-process");
                }

            }

            response.sendRedirect(request.getContextPath() + "/profile");

        } else if ("cancel".equals(action)) {
            Order order = OrderQueue.findOrderById(request.getParameter("orderId"));

            if (order instanceof ItemOrder) {
                ItemOrder itemOrder = (ItemOrder) order;

                Double paymentAmount = itemOrder.getItem().getPrice() * itemOrder.getQuantity();
                Payment newPayment = new CashPayment(itemOrder, paymentAmount, null);
                System.out.println("Created Payment Object");

                PaymentHandle.addPayment(newPayment);
                OrderQueue.setOrderPayment(itemOrder.getOrderId(), newPayment);
            }

            if (order instanceof CustomCakeOrder) {
                CustomCakeOrder customCakeOrder = (CustomCakeOrder) order;

                Double paymentAmount = customCakeOrder.total();
                Payment newPayment = new CashPayment(customCakeOrder, paymentAmount, null);
                System.out.println("Created Payment Object");
                PaymentHandle.addPayment(newPayment);

                OrderQueue.setOrderPayment(customCakeOrder.getOrderId(), newPayment);
                System.out.println("Custom Cake Order Added");
            }

            System.out.println("Payment Added");
            System.out.println("Cancelling Payment...");
            System.out.println("Redirecting...");
            response.sendRedirect("profile");

        } else if ("refund".equals(action)) {
            System.out.println("Refunding Payment...");
            System.out.println("Redirecting...");

            Payment payment = PaymentHandle.findPaymentById(request.getParameter("paymentId"));
            PaymentHandle.setPaymentStatus(payment.getPaymentId(), "REFUNDED");

            response.sendRedirect("admin/");

        }

    }
}