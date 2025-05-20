package entities;

import utils.OrderQueue;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public abstract class Payment {
    protected String paymentId;
    protected String paymentStatus;
    protected Order order;
    protected String paymentDate;
    protected Double paymentAmount;
    protected String paymentMethod;

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public Payment(Order order, Double paymentAmount, String paymentMethod) {
        this.paymentId = null;
        this.paymentStatus = "PENDING";
        this.order = order;
        this.paymentDate = LocalDateTime.now().format(formatter);
        this.paymentAmount = paymentAmount;
        this.paymentMethod = paymentMethod;
    }

    // Constructor for fromString Method
    public Payment(String paymentId, String paymentStatus, Order order, String paymentDate, Double paymentAmount, String paymentMethod) {
        this.paymentId = paymentId;
        this.paymentStatus = paymentStatus;
        this.order = order;
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

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
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

    public abstract String toString();

}
