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

    private Node<E> head;
    private Node<E> tail;
    private int size;

    public CustomQueue() {
        head = null;
        tail = null;
        size = 0;
    }

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

    public E pop() {
        if (isEmpty()) {
            throw new NoSuchElementException("Queue is empty");
        }
        E item = head.item;
        head = head.next;
        size--;
        if (isEmpty()) {
            tail = null;
        }
        return item;
    }

    public E peek() {
        if (isEmpty()) {
            throw new NoSuchElementException("Queue is empty");
        }
        return head.item;
    }

    public boolean isEmpty() {
        return size == 0;
    }

    public int size() {
        return size;
    }

    public void clear() {
        head = null;
        tail = null;
        size = 0;
    }



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