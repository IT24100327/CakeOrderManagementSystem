package utils;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.NoSuchElementException;

public class CustomQueue<E> implements Iterable<E> {
    private ArrayList<E> queue;
    private int size;

    public CustomQueue() {
        queue = new ArrayList<>();
        size = 0;
    }

    public void add(E item) {
        if (item == null) {
            throw new IllegalArgumentException("Item cannot be null");
        }
        queue.add(item);
        size++;
    }

    public E pop() {
        if (isEmpty()) {
            throw new NoSuchElementException("Queue is empty");
        }
        E item = queue.remove(0);
        size--;
        return item;
    }

    public E peek() {
        if (isEmpty()) {
            throw new NoSuchElementException("Queue is empty");
        }
        return queue.get(0);
    }

    public boolean isEmpty() {
        return size == 0;
    }

    public int size() {
        return size;
    }

    public void clear() {
        queue.clear();
        size = 0;
    }

    @Override
    public Iterator<E> iterator() {
        return queue.iterator();
    }
}