package utils;

import entities.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class CredsFileHandle {

    // change accordingly
    private final String filePath = "E:\\MyWork\\SLIIT\\OneDrive - Sri Lanka Institute of Information Technology\\Y1S2\\OOP\\Project\\backup\\data\\users.txt";


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

    public boolean addUser(String name, String username, String email, String password, String ROLE) {
        if (!checkFile()) {
            System.out.println("File does not exist");
            return false;
        }
        try (FileWriter writer = new FileWriter(filePath, true)) {
            writer.write(name + "," + username + "," + email + "," + password + "," + ROLE + System.lineSeparator());
            return true;
        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
            return false;
        }
    }

    public User getUserByUsername(String username) {
        File file = new File(filePath);
        System.out.println("Checking file at: " + file.getAbsolutePath());
        System.out.println("method "+username);
        if (!file.exists()) {
            return null;
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] userData = line.split(",");
                if (userData.length == 5 && userData[1].equals(username)) {
                    return new User(userData[0], userData[1], userData[2], userData[3], userData[4]);
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }
        return null;
    }

    public boolean deleteUser(String username) {
        try {
            checkFile();
            File file = new File(filePath);
            BufferedReader reader = new BufferedReader(new FileReader(file));
            String line;
            StringBuilder fileContent = new StringBuilder();

            boolean userDeleted = false;

            while ((line = reader.readLine()) != null) {
                String[] userData = line.split(",");
                if (!userData[1].equals(username)) {
                    fileContent.append(line).append(System.lineSeparator());
                } else {
                    userDeleted = true;
                }
            }

            reader.close();

            if (!userDeleted) {
                return false;
            }

            BufferedWriter writer = new BufferedWriter(new FileWriter(file));
            writer.write(fileContent.toString());
            writer.close();

            return true;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUser(String oldUsername, String newName, String newEmail, String newPassword, String newRole) {
        File file = new File(filePath);
        List<String> lines = new ArrayList<>();
        boolean userUpdated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] userFields = line.split(",");
                if (userFields.length == 5) {
                    String username = userFields[1];
                    if (username.equals(oldUsername)) {
                        line = newName + "," + oldUsername + "," + newEmail + "," + newPassword + "," + newRole;
                        userUpdated = true;
                    }
                }
                lines.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        if (userUpdated) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                for (String updatedLine : lines) {
                    writer.write(updatedLine);
                    writer.newLine();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return userUpdated;
    }
}
