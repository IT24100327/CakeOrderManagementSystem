package entities;

import utils.OrderQueue;

public class CardPayment extends Payment {

    public CardPayment(Order order, Double paymentAmount, String paymentMethod) {
        super(order, paymentAmount, paymentMethod);
    }

    public CardPayment(String paymentId, String status, Order order, Double paymentAmount,String paymentDate, String paymentMethod) {

        super(paymentId, status, order, paymentDate, paymentAmount, paymentMethod);
    }

    @Override
    public String toString() {
        return "CardPayment" + "|" + paymentId  + "|" + paymentStatus + "|" + order.getOrderId() + "|" + paymentAmount + "|" + paymentDate + "|" + paymentMethod;
    }

    public static CardPayment fromString(String string) {
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

        return new CardPayment(paymentId, paymentStatus, order, paymentAmount, paymentDate, paymentMethod);
    }
}
