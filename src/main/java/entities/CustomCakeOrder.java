package entities;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.*;


public class CustomCakeOrder extends Order{
    private String customCakeId;
    private String occasion;
    private String cakeFlavour;
    private String filling;
    private String cakeSize;
    private String cakeShape;
    private String instructions;
    private double basePrice;
    private double priceWithFlavour;
    public static String filepath ="E:\\customCakeOrder\\Orders.txt";
    private String[] customOrder;




    public CustomCakeOrder(String userId, String customCakeId, int quantity, String status, double total, String deliveryDate, String occasion, String cakeFlavour, String filling ,String cakeSize, String cakeShape,String instructions) throws IOException {
        super(Integer.parseInt(userId), customCakeId,  quantity,  status, total, deliveryDate);
        this.occasion = occasion;
        this.cakeFlavour = cakeFlavour;
        this.filling = filling;
        this.cakeSize = cakeSize;
        this.cakeShape = cakeShape;
        this.deliveryDate = deliveryDate;
        this.instructions = instructions;

    }

    public CustomCakeOrder(int userId,String orderId,String occasion,String cakeFlavour,String filling,String cakeSize,String cakeShape,String deliveryDate) throws IOException {
        super(orderId, userId);
        this.occasion = occasion;
        this.cakeFlavour = cakeFlavour;
        this.filling = filling;
        this.cakeSize = cakeSize;
        this.cakeShape = cakeShape;
        this.deliveryDate = deliveryDate;

    }

    public String getOccasion() {
        return occasion;
    }

    public void setOccasion(String occasion) {
        this.occasion = occasion;
    }

    public String getCustomCakeId() {
        return customCakeId;
    }

    public void setCustomCakeId(String customCakeId) {
        this.customCakeId = customCakeId;
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

    public double getPriceWithFlavour() {

        switch (occasion) {

            case "birthday":
                basePrice = 12000;
                switch (cakeFlavour) {
                    case "chocolate":
                        priceWithFlavour = basePrice + 300;
                        break;
                    case "vanilla":
                        priceWithFlavour = basePrice + 200;
                        break;
                    case "strawberry":
                        priceWithFlavour = basePrice + 500;
                        break;
                    case "red-velvet":
                        priceWithFlavour = basePrice + 700;
                        break;
                    default:
                        System.out.println("Error");
                        return -1;

                }

                break;
            case "wedding":
                basePrice = 20000;
                switch (cakeFlavour) {
                    case "chocolate":
                        priceWithFlavour = basePrice + 500;
                        break;
                    case "vanilla":
                        priceWithFlavour = basePrice + 400;
                        break;
                    case "strawberry":
                        priceWithFlavour = basePrice + 800;
                        break;
                    case "red-velvet":
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
    public double getTotalPrice(){

        switch (cakeSize){
            case "small":
                total = getPriceWithFlavour() + 1000;
                break;
            case "medium":
                total = getPriceWithFlavour() + 3000;
                break;
            case "large":
                total = getPriceWithFlavour() + 5000;
                break;
            case "x-large":
                total = getPriceWithFlavour() + 7000;
                break;
            default:
                System.out.println("Error");
                return-1;

        }
        return total;
    }

    // Converting object in to readable object
    @Override
    public String toString(){
        return customCakeId + "|" + userId + "|" + occasion + "|" + cakeFlavour + "|" + filling + "|" + cakeSize + "|" + cakeShape + "|" + deliveryDate + "|" + instructions;
    }


    public static CustomCakeOrder fromStringToObject(String order) throws IOException {
        String[] customOrder = order.split("\\|");
        if(customOrder.length < 8){
            throw new IllegalArgumentException("Invalid order string format");
        }
        int userId = Integer.parseInt(customOrder[1]);
        String orderId = customOrder[0];
        String occasion = customOrder[2];
        String cakeFlavour = customOrder[3];
        String filling = customOrder[4];
        String cakeSize = customOrder[5];
        String cakeShape = customOrder[6];
        String deliveryDate = customOrder[7];


        return  new CustomCakeOrder(userId,orderId,occasion,cakeFlavour,filling,cakeSize,cakeShape,deliveryDate);
    }


    // Write in a file
    public  void saveInFile() throws IOException{
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filepath,true))){
            writer.write(this.toString());
            writer.newLine();
        }
    }
}




