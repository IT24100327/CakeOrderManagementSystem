package entities;

import org.w3c.dom.ls.LSOutput;

import java.io.*;


public class CustomCakeOrder extends Order {
    private String occasion;
    private String cakeFlavour;
    private String filling;
    private String cakeSize;
    private String cakeShape;
    private String instructions;
    private double basePrice;
    private double priceWithFlavour;
    private double totalPrice;


    public CustomCakeOrder(String userId,
                           int quantity,
                           String status,
                           double total,
                           String deliveryDate,
                           String occasion,
                           String cakeFlavour,
                           String filling,
                           String cakeSize,
                           String cakeShape,
                           String instructions
    ) throws IOException {

        super(Integer.parseInt(userId),"CUSTOMCAKE", quantity, total, deliveryDate);
        this.occasion = occasion;
        this.cakeFlavour = cakeFlavour;
        this.filling = filling;
        this.cakeSize = cakeSize;
        this.cakeShape = cakeShape;
        this.deliveryDate = deliveryDate;
        this.instructions = instructions;
        this.status = status;

    }

    public CustomCakeOrder(String orderId,
                           int userId,
                           int quantity,
                           String status,
                           double total,
                           String orderDate,
                           String deliveryDate,
                           String occasion,
                           String cakeFlavour,
                           String filling,
                           String cakeSize,
                           String cakeShape,
                           String instructions
    ) throws IOException {

        super(orderId, userId, "CUSTOMCAKE", quantity, status, total, orderDate, deliveryDate);
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

    public double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }

    public void setPriceWithFlavour(double priceWithFlavour) {
        this.priceWithFlavour = priceWithFlavour;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public double getPriceWithFlavour() {

        switch (getOccasion()) {

            case "Birthday":
                basePrice = 12000;
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
    public  double total(){

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
                return-1;

        }
        System.out.println("Total : " + total);
        return total;
    }




    // Converting object in to readable object
    @Override
    public String toString(){
        return "customOrder" + "|" + orderId + "|" + userId + "|" + quantity + "|" + status + "|" + total + "|" + orderDate + "|" + occasion + "|" + cakeFlavour + "|" + filling + "|" + cakeSize + "|" + cakeShape + "|" + deliveryDate + "|" + instructions;
    }


    public static CustomCakeOrder fromStringToObject(String order) throws IOException {
        String[] customOrder = order.split("\\|");
        if(customOrder.length < 14){
            throw new IllegalArgumentException("Invalid order string format");
        }
        int userId = Integer.parseInt(customOrder[2]);
        String orderId = customOrder[1];
        int quantity = Integer.parseInt(customOrder[3]);
        String occasion = customOrder[7];
        String status = customOrder[4];
        double total = Double.parseDouble(customOrder[5]);
        String orderDate = customOrder[6];
        String cakeFlavour = customOrder[8];
        String filling = customOrder[9];
        String cakeSize = customOrder[10];
        String cakeShape = customOrder[11];
        String deliveryDate = customOrder[12];
        String instructions = customOrder[13];




        return  new CustomCakeOrder(orderId,userId,1,status,total,orderDate,deliveryDate,occasion,cakeFlavour,filling,cakeSize,cakeShape,instructions);
    }
}




