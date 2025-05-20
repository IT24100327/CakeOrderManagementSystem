package entities;

import utils.CredsFileHandle;
import utils.ItemCatalog;
import utils.PaymentHandle;

import java.time.LocalDate;

public class ItemOrder extends Order {
    Item item;
    protected int quantity;

    public ItemOrder(Item item, User user, int quantity, Payment payment, LocalDate deliveryDate) {
        super(user, payment, deliveryDate);
        this.item = item;
        this.quantity = quantity;
    }

    public ItemOrder(Item item, String orderId, User user, int quantity, String status, Payment payment, LocalDate orderDate, LocalDate deliveryDate) {
        super(orderId, user, status, payment, orderDate, deliveryDate);
        this.item = item;
        this.quantity = quantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public String toString() {
        String itemId = (item == null) ? null : item.getItemId();
        String paymentId = (payment == null) ? null : payment.getPaymentId();
        String userId = String.valueOf((user == null)? null : user.getID());

        return "ItemOrder" + "|" + itemId + "|" + orderId + "|" + userId + "|" + quantity + "|" + status + "|" + paymentId + "|" + orderDate + "|" + deliveryDate;
    }

    public static ItemOrder fromString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length == 9) {
            return new ItemOrder (
                    ItemCatalog.findItemById(parts[1]),
                    parts[2],
                    CredsFileHandle.getUserByID(Integer.parseInt(parts[3])),
                    Integer.parseInt(parts[4]),
                    parts[5],
                    PaymentHandle.findPaymentById(parts[6]),
                    LocalDate.parse(parts[7]),
                    LocalDate.parse(parts[8])
            );
        }
        return null;
    }

}
