package utils;

import entities.CustomCakeOrder;

import java.io.*;
import java.util.LinkedList;
import java.util.Queue;

public class CustomOrderQueue extends OrderQueue{

    public static int lastOrderId = 0;
    public static String filepath = "E:\\customCakeOrder\\customOrders.txt";
    public static Queue<CustomCakeOrder> customQueue = new LinkedList<>();


    public static String generateOrderId() {
        lastOrderId++;
        return String.format("ORD%04d", lastOrderId);
    }

    public static void add(CustomCakeOrder customCake) throws IOException {

        if (customCake.getCustomCakeId() == null || customCake.getCustomCakeId().isEmpty()) {
            customCake.setCustomCakeId(generateOrderId());
        }
        customQueue.add(customCake);
        saveToFile();
        System.out.println("Added a Custom Cake");
    }

    public static int getLastOrderId() {
        return lastOrderId;
    }

    public static Queue<CustomCakeOrder> getCustomQueue() {
        return customQueue;
    }


    public static void loadFromFile() throws IOException {
        File file = new File(filepath);
        System.out.println("File Created");

        customQueue.clear();

        try (BufferedReader read = new BufferedReader(new FileReader(file))) {
            String line;

            while((line = read.readLine()) != null){

                CustomCakeOrder order = CustomCakeOrder.fromStringToObject(line);
                if (order.getCustomCakeId() == null || order.getCustomCakeId().isEmpty() || order.getCustomCakeId().equals("null")) {
                    order.setCustomCakeId(generateOrderId());
                    System.out.println("Loaded from file and Saved");
                }
                customQueue.add(order);
            }
        }

    }

    private static void saveToFile() throws IOException {
        try(BufferedWriter write = new BufferedWriter(new FileWriter(filepath))){
            for(CustomCakeOrder co : customQueue){
                if (co != null) {
                    write.write(co.toString());
                    write.newLine();;
                }
            }
        }  catch (IOException e){
            System.err.println("Error order not saved in file");
            e.printStackTrace();
        }
    }
}
