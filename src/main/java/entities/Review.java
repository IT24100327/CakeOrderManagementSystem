package entities;

import java.io.Serializable;

public class Review implements Serializable {
    private String id;
    private String name;
    private String email;
    private String message;

    // Default constructor with validation
    public Review(String name, String email, String message) {
        validateName(name);
        validateEmail(email);
        validateMessage(message);
        
        this.name = name.trim();
        this.email = email.toLowerCase().trim();
        this.message = message.trim();
    }

    // Full constructor with ID
    public Review(String id, String name, String email, String message) {
        this(name, email, message); // Call the basic constructor for validation
        validateId(id);
        this.id = id;
    }

    // Copy constructor
    public Review(Review other) {
        this(other.id, other.name, other.email, other.message);
    }

    // Private validation methods
    private void validateId(String id) {
        if (id == null || id.trim().isEmpty()) {
            throw new IllegalArgumentException("ID cannot be null or empty");
        }
    }

    private void validateName(String name) {
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("Name cannot be null or empty");
        }
    }

    private void validateEmail(String email) {
        if (email == null || !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            throw new IllegalArgumentException("Invalid email format");
        }
    }

    private void validateMessage(String message) {
        if (message == null || message.trim().isEmpty()) {
            throw new IllegalArgumentException("Message cannot be null or empty");
        }
    }

    // Getters
    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getMessage() {
        return message;
    }

    // Only ID can be set after construction (for file storage purposes)
    public void setId(String id) {
        validateId(id);
        this.id = id;
    }

    // Utility methods
    public String toFileString() {
        return String.format("%s|%s|%s|%s", 
            id, name, email, message);
    }

    public static Review fromFileString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length < 4) {
            throw new IllegalArgumentException("Invalid review data format");
        }

        return new Review(
            parts[0],    // id
            parts[1],    // name
            parts[2],    // email
            parts[3]     // message
        );
    }

    // Override toString() for debugging and logging
    @Override
    public String toString() {
        return "Review{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", message='" + message + '\'' +
                '}';
    }

    // Override equals() and hashCode() for proper object comparison
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Review review = (Review) o;
        return id.equals(review.id);
    }

    @Override
    public int hashCode() {
        return id.hashCode();
    }
} 