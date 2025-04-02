package entities;

public class CustomCakeOrder extends Order{

    private String occasion;
    private String cakeFlavour;
    private String filling;
    private String cakeSize;
    private String cakeShape;
    private double basePrice;
    private double priceWithFlavour;
    private double priceWithSize;

    public CustomCakeOrder(String  orderId,int userId,String occasion,String cakeFlavour,String filling,String cakeSize,String cakeShape,String deliveryDate){
        super(orderId,userId);
        this.occasion = occasion;
        this.cakeFlavour = cakeFlavour;
        this.filling = filling;
        this.cakeSize = cakeSize;
        this.cakeShape = cakeShape;
        this.deliveryDate = deliveryDate;
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



    }




