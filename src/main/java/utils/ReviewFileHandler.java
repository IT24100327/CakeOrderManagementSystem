package utils;

import entities.Review;
import java.io.*;
import java.util.*;

public class ReviewFileHandler {
    private static final String REVIEWS_FILE = "E:/Data/reviews.txt";

    public void writeReview(Review review) {
        try {
            // Count existing lines to determine new ID
            int nextId = 1;
            File file = new File(REVIEWS_FILE);
            
            if (file.exists()) {
                BufferedReader reader = new BufferedReader(new FileReader(file));
                while (reader.readLine() != null) {
                    nextId++;
                }
                reader.close();
            }

            // Set the ID and write to file
            review.setId("id" + nextId);
            
            // Write to file using BufferedWriter
            BufferedWriter writer = new BufferedWriter(new FileWriter(file, true));
            writer.write(review.toFileString());
            writer.newLine();
            writer.close();

            System.out.println("Review successfully written to file with ID: " + review.getId());
            
        } catch (IOException e) {
            System.err.println("Error writing review to file: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        File file = new File(REVIEWS_FILE);
        
        if (!file.exists()) {
            return reviews;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    Review review = Review.fromFileString(line);
                    reviews.add(review);
                } catch (IllegalArgumentException e) {
                    System.err.println("Error parsing review: " + e.getMessage());
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading reviews: " + e.getMessage());
            e.printStackTrace();
        }
        
        return reviews;
    }

    public boolean deleteReview(String reviewId) {
        File file = new File(REVIEWS_FILE);
        File tempFile = new File(file.getAbsolutePath() + ".tmp");
        boolean found = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {

            String line;
            while ((line = reader.readLine()) != null) {
                Review review = Review.fromFileString(line);
                if (!review.getId().equals(reviewId)) {
                    writer.write(review.toFileString());
                    writer.newLine();
                } else {
                    found = true;
                }
            }

        } catch (IOException e) {
            System.err.println("Error deleting review: " + e.getMessage());
            e.printStackTrace();
            return false;
        }

        if (found) {
            if (file.delete() && tempFile.renameTo(file)) {
                return true;
            }
        } else {
            tempFile.delete();
        }
        return false;
    }
} 