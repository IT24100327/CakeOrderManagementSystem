package entities;

import utils.CredsFileHandle;
import utils.PaymentHandle;

import java.io.*;
import java.time.LocalDate;


public class CustomCakeOrder extends Order {
    private String occasion;
    private String cakeFlavour;
    private String filling;
    private String cakeSize;
    private String cakeShape;
    private String instructions;

    public CustomCakeOrder(User user,
                           Payment payment,
                           LocalDate deliveryDate,
                           String occasion,
                           String cakeFlavour,
                           String filling,
                           String cakeSize,
                           String cakeShape,
                           String instructions
    ) throws IOException {

        super(user, payment, deliveryDate);
        this.occasion = occasion;
        this.cakeFlavour = cakeFlavour;
        this.filling = filling;
        this.cakeSize = cakeSize;
        this.cakeShape = cakeShape;
        this.deliveryDate = deliveryDate;
        this.instructions = instructions;

    }

    public CustomCakeOrder(String orderId,
                           User user,
                           String status,
                           Payment payment,
                           LocalDate orderDate,
                           LocalDate deliveryDate,
                           String occasion,
                           String cakeFlavour,
                           String filling,
                           String cakeSize,
                           String cakeShape,
                           String instructions
    ) throws IOException {

        super(orderId, user, status, payment, orderDate, deliveryDate);
        this.occasion = occasion;
        this.cakeFlavour = cakeFlavour;
        this.filling = filling;
        this.cakeSize = cakeSize;
        this.cakeShape = cakeShape;
        this.deliveryDate = deliveryDate;
        this.instructions = instructions;
    }


    public String getInstructions() {
        return instructions;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }

    public String getOccasion() {
        return occasion;
    }

    public void setOccasion(String occasion) {
        this.occasion = occasion;
    }

    public String getCakeFlavour() {
        return cakeFlavour;
    }

    public void setCakeFlavour(String cakeFlavour) {
        this.cakeFlavour = cakeFlavour;
    }

    public String getFilling() {
        return filling;
    }

    public void setFilling(String filling) {
        this.filling = filling;
    }

    public String getCakeSize() {
        return cakeSize;
    }

    public void setCakeSize(String cakeSize) {
        this.cakeSize = cakeSize;
    }

    public String getCakeShape() {
        return cakeShape;
    }

    public void setCakeShape(String cakeShape) {
        this.cakeShape = cakeShape;
    }

    public double getPriceWithFlavour() {
        double priceWithFlavour = 0;
        double basePrice = 12000;

        switch (getOccasion()) {

            case "Birthday":
                switch (getCakeFlavour()) {
                    case "Chocolate":
                        priceWithFlavour = basePrice + 300;
                        break;
                    case "Vanilla":
                        priceWithFlavour = basePrice + 200;
                        break;
                    case "Strawberry":
                        priceWithFlavour = basePrice + 500;
                        break;
                    case "Red-velvet":
                        priceWithFlavour = basePrice + 700;
                        break;
                    default:
                        System.out.println("Error");
                        return -1;

                }

                break;
            case "Wedding":
                basePrice = 20000;
                switch (getCakeFlavour()) {
                    case "Chocolate":
                        priceWithFlavour = basePrice + 500;
                        break;
                    case "Vanilla":
                        priceWithFlavour = basePrice + 400;
                        break;
                    case "Strawberry":
                        priceWithFlavour = basePrice + 800;
                        break;
                    case "Red-velvet":
                        priceWithFlavour = basePrice + 1000;
                        break;
                    default:
                        System.out.println("Error");
                        return -1;
                }
                break;
            default:
                System.out.println("Error");
                return -1;

        }
        return priceWithFlavour;

    }

    public double total() {
        double total = 0;
        switch (getCakeSize()){
            case "Small":
                total = getPriceWithFlavour() + 1000;
                break;
            case "Medium":
                total = getPriceWithFlavour() + 3000;
                break;
            case "Large":
                total = getPriceWithFlavour() + 5000;
                break;
            case "Extra-large":
                total = getPriceWithFlavour() + 7000;
                break;
            default:
                System.out.println("Error");
                return -1;

        }
        System.out.println("Total : " + total);

        return total;
    }

    // Converting object in to readable object
    @Override
    public String toString(){
        String paymentId = (payment == null) ? null : payment.getPaymentId();
        String userId = String.valueOf((user == null)? null : user.getID());

        return "customOrder" + "|" + orderId + "|" + userId + "|" + status + "|" + paymentId + "|" + orderDate + "|" + occasion + "|" + cakeFlavour + "|" + filling + "|" + cakeSize + "|" + cakeShape + "|" + deliveryDate + "|" + instructions;
    }

    public static CustomCakeOrder fromStringToObject(String order) throws IOException {
        String[] customOrder = order.split("\\|");

        if (customOrder.length != 13) {
            throw new IOException("Invalid order string format: expected 13 fields, got " + customOrder.length);
        }

        String orderId = customOrder[1];
        User user = CredsFileHandle.getUserByID(Integer.parseInt(customOrder[2]));
        String status = customOrder[3];
        Payment payment = PaymentHandle.findPaymentById(customOrder[4]);
        LocalDate orderDate = LocalDate.parse(customOrder[5]);
        String occasion = customOrder[6];
        String cakeFlavour = customOrder[7];
        String filling = customOrder[8];
        String cakeSize = customOrder[9];
        String cakeShape = customOrder[10];
        LocalDate deliveryDate = LocalDate.parse(customOrder[11]);
        String instructions = customOrder[12];

        return new CustomCakeOrder(orderId, user, status, payment, orderDate, deliveryDate, occasion, cakeFlavour, filling, cakeSize, cakeShape, instructions);
    }

}




