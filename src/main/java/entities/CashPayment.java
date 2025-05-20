package entities;

import utils.OrderQueue;

public class CashPayment extends Payment {

    public CashPayment(Order order, Double paymentAmount, String paymentMethod) {
        super(order, paymentAmount, paymentMethod);
    }

    public CashPayment(String paymentId, String status, Order order, Double paymentAmount,String paymentDate, String paymentMethod) {
        super(paymentId, status, order, paymentDate, paymentAmount, paymentMethod);
    }

    @Override
    public String toString() {
        return "CashPayment" + "|" + paymentId  + "|" + paymentStatus + "|" + order.getOrderId() + "|" + paymentAmount + "|" + paymentDate + "|" + paymentMethod;
    }

    public static CashPayment fromString(String string) {
        String[] parts = string.split("\\|");

        if (parts.length != 7) {
            throw new IllegalArgumentException("Invalid order string format");
        }

        String paymentId = parts[1];
        String paymentStatus = parts[2];
        Order order = OrderQueue.findOrderById(parts[3]);

        Double paymentAmount = Double.parseDouble(parts[4]);
        String paymentDate = parts[5];
        String paymentMethod = parts[6];

        return new CashPayment(paymentId, paymentStatus, order, paymentAmount, paymentDate, paymentMethod);
    }
}

