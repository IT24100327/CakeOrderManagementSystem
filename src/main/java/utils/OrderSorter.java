package utils;

import entities.Order;

import java.util.Queue;
import java.util.LinkedList;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class OrderSorter {

    // Date formatter for parsing the string dates
    private static final DateTimeFormatter DATE_FORMATTER =
            DateTimeFormatter.ofPattern("yyyy-MM-dd");

    public static void bubbleSortByDeliveryDate(Queue<Order> orders) {
        if (orders == null || orders.size() <= 1) {
            return;
        }

        // Convert queue to array for easier sorting
        Order[] orderArray = orders.toArray(new Order[0]);

        int n = orderArray.length;
        boolean swapped;

        for (int i = 0; i < n - 1; i++) {
            swapped = false;
            for (int j = 0; j < n - i - 1; j++) {
                // Parse the string dates to LocalDate for proper comparison
                LocalDate date1 = LocalDate.parse(orderArray[j].getDeliveryDate(), DATE_FORMATTER);
                LocalDate date2 = LocalDate.parse(orderArray[j + 1].getDeliveryDate(), DATE_FORMATTER);

                /*
                   -----compareTo Method----------
                   It returns 0 if both the dates are equal.
                   It returns positive value if “this date” is greater than the otherDate.
                   It returns negative value if “this date” is less than the otherDate.
                */


                if (date1.compareTo(date2) > 0) {
                    // Swap if they're in the wrong order
                    Order temp = orderArray[j];
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

        for (Order order : orderArray) {
            orders.add(order);
        }
    }
}