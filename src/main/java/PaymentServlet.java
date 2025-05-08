import entities.Item;
import entities.Order;
import entities.Payment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Queue;

//import entities.Order;
import org.w3c.dom.ls.LSOutput;
import utils.ItemCatalog;
import utils.OrderQueue;
import utils.paymentHandle;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    ItemCatalog catalog = new ItemCatalog();

    public void init() {

        try {
            OrderQueue.loadFromFile();
            System.out.println("OrderQueue loaded");
            catalog.loadFromFile();
            System.out.println("ItemQueue loaded");
            paymentHandle.loadFromFile();
            System.out.println("payments loaded");

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    } // Load orders on startup

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("pay".equals(action)) {
            String orderId = request.getParameter("orderId");
            Double paymentAmount = Double.parseDouble(request.getParameter("paymentAmount"));
            String paymentMethod = request.getParameter("paymentMethod");

            Payment newPayment = new Payment(orderId, paymentAmount, paymentMethod);
            System.out.println("Created Payment Object");
            paymentHandle.addPayment(newPayment);
            System.out.println("Payment Added");
            paymentHandle.pay(newPayment.getPaymentId());
            System.out.println("Changed Payment Status: " + newPayment.getPaymentStatus());

            OrderQueue.processOrder(OrderQueue.findOrderById(orderId));
            System.out.println("Order [" + orderId + "] status changed to \"To Process\" ");

            System.out.println("Payment added: " + newPayment.getPaymentId());
            System.out.println("Redirecting...");
            response.sendRedirect("profile");

        } else if ("cancel".equals(action)) {
            System.out.println("Cancelling Payment...");
            System.out.println("Redirecting...");
            response.sendRedirect("profile");

        } else if ("refund".equals(action)) {
            System.out.println("Refunding Payment...");
            System.out.println("Redirecting...");

            Payment payment = paymentHandle.findPaymentById(request.getParameter("paymentId"));
            paymentHandle.removePayment(payment);

            response.sendRedirect("admin/");

        }
    }
}