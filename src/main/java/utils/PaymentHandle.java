package utils;

import entities.CardPayment;
import entities.CashPayment;
import entities.Payment;

import java.io.*;
import java.util.LinkedList;

public class PaymentHandle {
    private static final LinkedList<Payment> payments = new LinkedList<>();
    private static final String FILE_PATH = "C:/Data/payments.txt";
    private static int lastPaymentId = 0;

    private static String generatePaymentId() {
        lastPaymentId++;
        return String.format("PAY%04d", lastPaymentId);
    }

    public static LinkedList<Payment> getPayments() {
        return payments;
    }

    public static void addPayment(Payment payment) throws IOException {
        if (payment == null) {
            throw new IllegalArgumentException("Order cannot be null");
        }

        if (payment.getPaymentId() == null || payment.getPaymentId().isEmpty()) {
            payment.setPaymentId(generatePaymentId());
        }

        payments.add(payment);
        saveToFile();
    }

    public static void pay(String paymentId) throws IOException {
        Payment payment = findPaymentById(paymentId);
        if (payment != null) {
            payment.setPaymentStatus("PAID");
        }

        saveToFile();

    }

    public static void removePayment(Payment payment) throws IOException {
        if (payment == null) {
            throw new IllegalArgumentException("Order cannot be null");
        }

        payments.remove(payment);
        saveToFile();
    }

    public static Payment findPaymentById(String paymentId) {
        for (Payment payment : payments) {
            if (payment.getPaymentId().equals(paymentId)) {
                return payment;
            }
        }
        return null;
    }

    public static void setPaymentStatus(String paymentId, String paymentStatus) throws IOException {
        for (Payment payment : payments) {
            if (payment.getPaymentId().equals(paymentId)) {
                payment.setPaymentStatus(paymentStatus);
            }
        }
        saveToFile();
    }

    public static void setPaymentDetails(String paymentId, double paymentAmount, String paymentStatus, String paymentMethod) throws IOException {
        for (Payment payment : payments) {
            if (payment.getPaymentId().equals(paymentId)) {
                payment.setPaymentStatus(paymentStatus);
                payment.setPaymentMethod(paymentMethod);
                payment.setPaymentAmount(paymentAmount);
            }
        }
        saveToFile();
    }


    public static void sortOrderByPaymentDate() {
        BubbleSorter.bubbleSortByDeliveryDate(payments);
    }

    public static void saveToFile() throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Payment payment : payments) {
                writer.write(payment.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error saving orders to file: " + e.getMessage());
            e.printStackTrace();
        }

    }

    public static void loadFromFile() throws IOException {
        File file = new File(FILE_PATH);

        // Create file if doesn't exist
        if (!file.exists()) {
            file.createNewFile();
            return;
        }

        payments.clear();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                if (parts[0].equals("CardPayment")) {
                    CardPayment cardPayment = CardPayment.fromString(line);
                    payments.add(cardPayment);

                    String idNumStr = cardPayment.getPaymentId().replace("PAY", "");
                    int idNum = Integer.parseInt(idNumStr);
                    lastPaymentId = Math.max(lastPaymentId, idNum);
                }

                if (parts[0].equals("CashPayment")) {
                    CashPayment cashPayment = CashPayment.fromString(line);
                    payments.add(cashPayment);

                    String idNumStr = cashPayment.getPaymentId().replace("PAY", "");
                    int idNum = Integer.parseInt(idNumStr);
                    lastPaymentId = Math.max(lastPaymentId, idNum);
                }
            }
        }
    }


}