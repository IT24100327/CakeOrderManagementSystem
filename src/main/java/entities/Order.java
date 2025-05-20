package entities;

import java.io.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.time.LocalDateTime;
import java.time.format.*;
import utils.ItemCatalog;

public abstract class Order {
    protected String orderId;
    protected User user;
    protected String status;
    protected Payment payment;
    protected LocalDate orderDate;
    protected LocalDate deliveryDate;

    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public Order(User user, Payment payment, LocalDate deliveryDate) {
        orderId = null;
        this.user = user;
        this.status = "pending";
        this.payment = payment;
        this.orderDate = LocalDate.now();
        this.deliveryDate = deliveryDate;
    }

    // constructor for make object from string
    public Order(String orderId, User user, String status, Payment payment, LocalDate orderDate, LocalDate deliveryDate) {
        this.orderId = orderId;
        this.user = user;
        this.status = status;
        this.payment = payment;
        this.orderDate = orderDate;
        this.deliveryDate = deliveryDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDate getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(LocalDate deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public LocalDate getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDate orderDate) {
        this.orderDate = orderDate;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setTotal(Payment payment) {
        this.payment = payment;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    @Override
    public abstract String toString();

}

