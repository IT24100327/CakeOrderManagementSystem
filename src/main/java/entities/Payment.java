package entities;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Payment {
    private String paymentId;
    private String paymentStatus;
    private String orderId;
    private String paymentDate;
    private Double paymentAmount;
    private String paymentMethod;

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public Payment(String orderId, Double paymentAmount, String paymentMethod) {
        this.paymentId = null;
        this.paymentStatus = "PENDING";
        this.orderId = orderId;
        this.paymentDate = LocalDateTime.now().format(formatter);
        this.paymentAmount = paymentAmount;
        this.paymentMethod = paymentMethod;
    }

    // Constructor for fromString Method
    public Payment(String paymentId, String paymentStatus, String orderId, String paymentDate, Double paymentAmount, String paymentMethod) {
        this.paymentId = paymentId;
        this.paymentStatus = paymentStatus;
        this.orderId = orderId;
        this.paymentDate = paymentDate;
        this.paymentAmount = paymentAmount;
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }

    public double getPaymentAmount() {
        return paymentAmount;
    }

    public void setPaymentAmount(double paymentAmount) {
        this.paymentAmount = paymentAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String toString() {
        return paymentId + "|" + paymentStatus + "|" + orderId + "|" + paymentDate + "|" + paymentAmount + "|" + paymentMethod;
    }

    public static Payment fromString(String string) {
        String[] parts = string.split("\\|");

        if (parts.length < 6) {
            throw new IllegalArgumentException("Invalid order string format");
        }

        String paymentId = parts[0];
        String paymentStatus = parts[1];
        String orderId = parts[2];
        String paymentDate = parts[3];
        Double paymentAmount = Double.parseDouble(parts[4]);
        String paymentMethod = parts[5];

        return new Payment(paymentId, paymentStatus, orderId, paymentDate, paymentAmount, paymentMethod);
    }

}
