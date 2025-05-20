package utils;

import entities.CustomCakeOrder;
import entities.ItemOrder;
import entities.Order;
import entities.Payment;
//import entities.Payment;

import java.util.LinkedList;
import java.util.Queue;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class BubbleSorter {

    // Date formatter for parsing the string dates
    private static final DateTimeFormatter DATE_FORMATTER =
            DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public static void bubbleSortByDeliveryDate(Queue<ItemOrder> orders) {
        if (orders == null || orders.size() <= 1) {
            return;
        }

        // Convert queue to array for easier sorting
        ItemOrder[] orderArray =  orders.toArray(new ItemOrder[0]);

        int n = orderArray.length;
        boolean swapped;

        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - i - 1; j++) {

                // Parse the string dates to LocalDate for proper comparison
                LocalDate date1 = orderArray[j].getDeliveryDate();
                LocalDate date2 = orderArray[j + 1].getDeliveryDate();

                /*
                   -----compareTo Method----------
                   It returns 0 if both the dates are equal.
                   It returns positive value if “this date” is greater than the otherDate.
                   It returns negative value if “this date” is less than the otherDate.
                */

                if (date1.compareTo(date2) > 0) {
                    // Swap if they're in the wrong order
                    ItemOrder temp = orderArray[j];
                    orderArray[j] = orderArray[j + 1];
                    orderArray[j + 1] = temp;
                    swapped = true;
                }
            }

            // If no swaps occurred in inner loop, the array is sorted
            if (!swapped) {
                break;
            }
        }

        // Clear the original queue and add the sorted elements back
        orders.clear();

        for (ItemOrder order : orderArray) {
            orders.add(order);
        }
    }

    public static void bubbleSortCustomOrdersByDate(Queue<CustomCakeOrder> orders) {
        if (orders == null || orders.size() <= 1) {
            return;
        }

        // Convert queue to array for easier sorting
        CustomCakeOrder[] orderArr = orders.toArray(new CustomCakeOrder[0]);

        int n = orderArr.length;
        boolean swapped;

        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - i - 1; j++) {
                // Parse the string dates to LocalDate for proper comparison
                LocalDate date1 = orderArr[j].getDeliveryDate();
                LocalDate date2 = orderArr[j + 1].getDeliveryDate();

                /*
                   -----compareTo Method----------
                   It returns 0 if both the dates are equal.
                   It returns positive value if “this date” is greater than the otherDate.
                   It returns negative value if “this date” is less than the otherDate.
                */

                if (date1.compareTo(date2) > 0) {
                    // Swap if they're in the wrong order
                    CustomCakeOrder temp = orderArr[j];
                    orderArr[j] = orderArr[j + 1];
                    orderArr[j + 1] = temp;
                    swapped = true;
                }
            }

            // If no swaps occurred in inner loop, the array is sorted
            if (!swapped) {
                break;
            }
        }

        // Clear the original queue and add the sorted elements back
        orders.clear();

        for (CustomCakeOrder order : orderArr) {
            orders.add(order);
        }
    }

    public static void bubbleSortByDeliveryDate(LinkedList<Payment> payments) {
        if (payments == null || payments.size() <= 1) {
            return;
        }

         //Convert queue to array for easier sorting
        Payment[] paymentArray = payments.toArray(new Payment[0]);

        int n = paymentArray.length;
        boolean swapped;

        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - i - 1; j++) {
                // Parse the string dates to LocalDate for proper comparison
                LocalDate date1 = LocalDate.parse(paymentArray[j].getPaymentDate(), DATE_FORMATTER);
                LocalDate date2 = LocalDate.parse(paymentArray[j + 1].getPaymentDate(), DATE_FORMATTER);

                /*
                   -----compareTo Method----------
                   It returns 0 if both the dates are equal.
                   It returns positive value if “this date” is greater than the otherDate.
                   returns negative value if “this date” is less than the otherDate.
                */

                if (date1.compareTo(date2) > 0) {
                    // Swap if they're in the wrong order
                    Payment temp = paymentArray[j];
                    paymentArray[j] = paymentArray[j + 1];
                    paymentArray[j + 1] = temp;
                    swapped = true;
                }
            }

            // If no swaps occurred in inner loop, the array is sorted
            if (!swapped) {
                break;
            }
        }

        // Clear the original linkedlist and add the sorted elements back
        payments.clear();

        for (Payment payment : paymentArray) {
            payments.add(payment);
        }
    }
}