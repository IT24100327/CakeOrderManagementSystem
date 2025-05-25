package utils;

import java.util.Iterator;
import java.util.NoSuchElementException;

public class CustomQueue<E> implements Iterable<E> {

    private static class Node<E> {
        E item;
        Node<E> next;

        Node(E item) {
            this.item = item;
            this.next = null;
        }
    }

    private Node<E> head; // front of the queue
    private Node<E> tail; // end of the queue
    private int size;

    public CustomQueue() {
        head = null;
        tail = null;
        size = 0;
    }

    /**
     * Adds an item to the end of the queue.
     * @param item the item to add
     */
    public void add(E item) {
        if (item == null) {
            throw new IllegalArgumentException("Item cannot be null");
        }
        Node<E> newNode = new Node<>(item);
        if (isEmpty()) {
            head = newNode;
        } else {
            tail.next = newNode;
        }
        tail = newNode;
        size++;
    }

    /**
     * Removes and returns the item from the front of the queue.
     * @return the item from the front of the queue
     * @throws NoSuchElementException if the queue is empty
     */
    public E remove() {
        if (isEmpty()) {
            throw new NoSuchElementException("Queue is empty");
        }
        E item = head.item;
        head = head.next;
        size--;
        if (isEmpty()) {
            tail = null; // Important: if queue becomes empty, tail must also be null
        }
        return item;
    }

    /**
     * Returns the item from the front of the queue without removing it.
     * @return the item from the front of the queue
     * @throws NoSuchElementException if the queue is empty
     */
    public E peek() {
        if (isEmpty()) {
            throw new NoSuchElementException("Queue is empty");
        }
        return head.item;
    }

    /**
     * Checks if the queue is empty.
     * @return true if the queue is empty, false otherwise
     */
    public boolean isEmpty() {
        return size == 0;
    }

    /**
     * Returns the number of items in the queue.
     * @return the number of items in the queue
     */
    public int size() {
        return size;
    }

    /**
     * Removes all items from the queue.
     */
    public void clear() {
        head = null;
        tail = null;
        size = 0;
    }

    /**
     * Returns an array containing all of the elements in this queue
     * in proper sequence (from first to last element).
     *
     * @param a the array into which the elements of the queue are to
     *          be stored, if it is big enough; otherwise, a new array of the
     *          same runtime type is allocated for this purpose.
     * @return an array containing all of the elements in this queue
     * @throws ArrayStoreException if the runtime type of the specified array
     *         is not a supertype of the runtime type of every element in
     *         this queue
     * @throws NullPointerException if the specified array is null
     */
    @SuppressWarnings("unchecked")
    public <T> T[] toArray(T[] a) {
        if (a.length < size)
            a = (T[])java.lang.reflect.Array.newInstance(
                    a.getClass().getComponentType(), size);
        int i = 0;
        Object[] result = a;
        for (Node<E> x = head; x != null; x = x.next)
            result[i++] = x.item;

        if (a.length > size)
            a[size] = null;

        return a;
    }
    
    /**
     * Removes all of the elements of this collection that satisfy the given
     * predicate.
     *
     * @param filter a predicate which returns {@code true} for elements to be
     *        removed
     * @return {@code true} if any elements were removed
     * @throws NullPointerException if the specified filter is null
     */
    public boolean removeIf(java.util.function.Predicate<? super E> filter) {
        if (filter == null) {
            throw new NullPointerException();
        }
        boolean removed = false;
        Node<E> current = head;
        Node<E> previous = null;

        while (current != null) {
            if (filter.test(current.item)) {
                removed = true;
                size--;
                if (previous == null) { // Removing the head
                    head = current.next;
                } else {
                    previous.next = current.next;
                }
                if (current == tail) { // Removing the tail
                    tail = previous;
                }
                current = current.next; // Move to next node before continuing loop
            } else {
                previous = current;
                current = current.next;
            }
        }
        // If the queue becomes empty after removals, ensure tail is null
        if (head == null) {
            tail = null;
        }
        return removed;
    }

    /**
     * Creates a shallow copy of this queue.
     * @return a new CustomQueue instance containing all elements of this queue.
     */
    public CustomQueue<E> copy() {
        CustomQueue<E> newQueue = new CustomQueue<>();
        for (E item : this) {
            newQueue.add(item);
        }
        return newQueue;
    }


    @Override
    public Iterator<E> iterator() {
        return new CustomQueueIterator();
    }

    private class CustomQueueIterator implements Iterator<E> {
        private Node<E> current = head;

        @Override
        public boolean hasNext() {
            return current != null;
        }

        @Override
        public E next() {
            if (!hasNext()) {
                throw new NoSuchElementException();
            }
            E item = current.item;
            current = current.next;
            return item;
        }
    }
} 