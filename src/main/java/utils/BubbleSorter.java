package utils;

import entities.CustomCakeOrder;
import entities.ItemOrder;
import entities.Payment;

import java.util.LinkedList;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class BubbleSorter {

    private static final DateTimeFormatter DATE_FORMATTER =
            DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public static void bubbleSortByDeliveryDate(CustomQueue<ItemOrder> orders) {
        if (orders == null || orders.size() <= 1) {
            return;
        }

        LinkedList<ItemOrder> tempList = new LinkedList<>();
        while (!orders.isEmpty()) {
            tempList.add(orders.pop());
        }

        int n = tempList.size();
        boolean swapped;

        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - i - 1; j++) {
                LocalDate date1 = tempList.get(j).getDeliveryDate();
                LocalDate date2 = tempList.get(j + 1).getDeliveryDate();

                if (date1.compareTo(date2) > 0) {
                    // Swap elements
                    ItemOrder temp = tempList.get(j);
                    tempList.set(j, tempList.get(j + 1));
                    tempList.set(j + 1, temp);
                    swapped = true;
                }
            }

            if (!swapped) {
                break;
            }
        }

        orders.clear();
        for (ItemOrder order : tempList) {
            orders.add(order);
        }
    }

    public static void bubbleSortCustomOrdersByDate(CustomQueue<CustomCakeOrder> orders) {
        if (orders == null || orders.size() <= 1) {
            return;
        }

        LinkedList<CustomCakeOrder> tempList = new LinkedList<>();
        while (!orders.isEmpty()) {
            tempList.add(orders.pop());
        }

        int n = tempList.size();
        boolean swapped;

        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - i - 1; j++) {
                LocalDate date1 = tempList.get(j).getDeliveryDate();
                LocalDate date2 = tempList.get(j + 1).getDeliveryDate();

                if (date1.compareTo(date2) > 0) {
                    // Swap elements
                    CustomCakeOrder temp = tempList.get(j);
                    tempList.set(j, tempList.get(j + 1));
                    tempList.set(j + 1, temp);
                    swapped = true;
                }
            }

            if (!swapped) {
                break;
            }
        }

        // Rebuild the original queue
        orders.clear();
        for (CustomCakeOrder order : tempList) {
            orders.add(order);
        }
    }

    public static void bubbleSortByDeliveryDate(LinkedList<Payment> payments) {
        if (payments == null || payments.size() <= 1) {
            return;
        }

        Payment[] paymentArray = payments.toArray(new Payment[0]);

        int n = paymentArray.length;
        boolean swapped;

        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - i - 1; j++) {

                LocalDate date1 = LocalDate.parse(paymentArray[j].getPaymentDate(), DATE_FORMATTER);
                LocalDate date2 = LocalDate.parse(paymentArray[j + 1].getPaymentDate(), DATE_FORMATTER);

                if (date1.compareTo(date2) > 0) {
                    Payment temp = paymentArray[j];
                    paymentArray[j] = paymentArray[j + 1];
                    paymentArray[j + 1] = temp;
                    swapped = true;
                }
            }

            if (!swapped) {
                break;
            }
        }

        payments.clear();

        for (Payment payment : paymentArray) {
            payments.add(payment);
        }
    }
}