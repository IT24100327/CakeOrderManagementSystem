package utils;

import entities.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class CredsFileHandle {

    private static final String filePath = "E:\\MyWork\\SLIIT\\OneDrive - Sri Lanka Institute of Information Technology\\Y1S2\\OOP\\Project\\CakeOrderManagementSystem\\data\\users.txt";

    PasswordUtils passwordUtils = new PasswordUtils();

    private boolean checkFile() {
        File file = new File(filePath);
        File folder = file.getParentFile();


        if (folder != null && !folder.exists()) {
            if (!folder.mkdirs()) {
                System.out.println("Failed to create folder: " + folder.getAbsolutePath());
                return false;
            }
        }

        if (!file.exists()) {
            try {
                if (!file.createNewFile()) {
                    System.out.println("Failed to create file: " + file.getAbsolutePath());
                    return false;
                }
            } catch (IOException e) {
                System.out.println("Error creating file: " + e.getMessage());
                return false;
            }
        }

        return true;
    }

    public boolean addUser(String firstName, String lastName, String email, String password, String role) {
        if (!checkFile()) {
            System.out.println("File does not exist");
            return false;
        }

        try (FileWriter writer = new FileWriter(filePath, true)) {
            String hashedPassword = passwordUtils.hashPassword(password);
            String userID = getID();

            writer.write(userID + "," + firstName + "," + lastName + "," + email + "," + hashedPassword + "," + role + System.lineSeparator());
            System.out.println("User added successfully!");
            return true;
        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
            return false;
        }
    }

    public User getUserByEmail(String email) {
        File file = new File(filePath);
        System.out.println("Checking file at: " + file.getAbsolutePath());

        if (!file.exists()) {
            return null;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] userData = line.split(",");
                if (userData.length >= 6 && userData[3].equals(email)) {
                    int ID = Integer.parseInt(userData[0].trim());
                    return new User(ID, userData[1], userData[2], userData[3], userData[4], userData[5]);
                }
            }
        } catch (IOException | NumberFormatException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }
        return null;
    }

    public boolean deleteUser(String email) {
        File file = new File(filePath);
        List<String> updatedLines = new ArrayList<>();
        boolean userDeleted = false;

        if (!file.exists()) return false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] userData = line.split(",");
                if (!userData[3].equals(email)) {
                    updatedLines.add(line);
                } else {
                    userDeleted = true;
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }

        if (!userDeleted) return false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String updatedLine : updatedLines) {
                writer.write(updatedLine);
                writer.newLine();
            }
        } catch (IOException e) {
            System.out.println("Error writing file: " + e.getMessage());
        }

        return true;
    }

    public boolean updateUser(String email, String newFirstName, String newLastName, String newEmail, String newPassword, String newRole) {
        File file = new File(filePath);
        List<String> updatedLines = new ArrayList<>();
        boolean userUpdated = false;

        if (!file.exists()) return false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] userData = line.split(",");
                if (userData[3].equals(email)) {
                    line = userData[0] + "," + newFirstName + "," + newLastName + "," + newEmail + "," + passwordUtils.hashPassword(newPassword) + "," + newRole;
                    userUpdated = true;
                }
                updatedLines.add(line);
            }
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }

        if (!userUpdated) return false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String updatedLine : updatedLines) {
                writer.write(updatedLine);
                writer.newLine();
            }
        } catch (IOException e) {
            System.out.println("Error writing file: " + e.getMessage());
        }

        return userUpdated;
    }

    public static String getID() {
        File file = new File(filePath);
        if (!file.exists()) {
            System.out.println("File does not exist.");
            return "0001";
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            int lineCount = 0;

            while (reader.readLine() != null) {
                lineCount++;
            }

            // Increment the line count by 1
            int incrementedNumber = lineCount + 1;

            // Return the incremented line count as a 4-digit formatted string
            return String.format("%04d", incrementedNumber);

        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }
        return null;
    }

    public boolean updatePassword(String email, String oldPassword, String newPassword) {
        File file = new File(filePath);
        List<String> updatedLines = new ArrayList<>();
        boolean passwordUpdated = false;

        if (!file.exists()) return false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] userData = line.split(",");
                if (userData[3].equals(email) && passwordUtils.verifyPassword(oldPassword, userData[4])) {
                    line = userData[0] + "," + userData[1] + "," + userData[2] + "," + email + "," + passwordUtils.hashPassword(newPassword) + "," + userData[5];
                    passwordUpdated = true;
                }
                updatedLines.add(line);
            }
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }

        if (!passwordUpdated) return false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String updatedLine : updatedLines) {
                writer.write(updatedLine);
                writer.newLine();
            }
        } catch (IOException e) {
            System.out.println("Error writing file: " + e.getMessage());
        }

        return passwordUpdated;
    }
}
