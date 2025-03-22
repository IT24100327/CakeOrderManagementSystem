package utils;

import entities.User;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class CredsFileHandle {

    private final String filePath = "E:\\MyWork\\SLIIT\\OneDrive - Sri Lanka Institute of Information Technology\\Y1S2\\OOP\\Project\\backup\\data\\users.txt";

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

    public boolean addUser(String name, String username, String email, String password, String ROLE) {
        if (!checkFile()) {
            System.out.println("File does not exist");
            return false;
        }
        try (FileWriter writer = new FileWriter(filePath, true)) {
            System.out.println(getID());
            writer.write(getID() + "," + name + "," + username + "," + email + "," + password + "," + ROLE + System.lineSeparator());
            return true;
        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
            return false;
        }
    }

    public User getUserByUsername(String username) {
        File file = new File(filePath);
        System.out.println("Checking file at: " + file.getAbsolutePath());
        System.out.println("Method: " + username);
        if (!file.exists()) {
            return null;
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] userData = line.split(",");
                if (userData[2].equals(username)) {
                    int ID = Integer.parseInt(userData[0].trim());
                    return new User(ID, userData[1], userData[2], userData[3], userData[4], userData[5]);
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        } catch (NumberFormatException e) {
            System.out.println("Invalid ID format in the file.");
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
                System.out.println(userData[2]);
                if (!userData[2].equals(username)) {
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

    public boolean updateUser(String oldUsername, String newUsername, String newName, String newEmail, String newPassword, String newRole) {
        File file = new File(filePath);
        List<String> lines = new ArrayList<>();
        boolean userUpdated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] userFields = line.split(",");
                if (userFields.length >= 5) {
                    String username = userFields[2]; // Fixed index to 2
                    if (username.equals(oldUsername)) {
                        line = userFields[0] + "," + newName + "," + newUsername + "," + newEmail + "," + newPassword + "," + newRole;
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

    public String getID() {
        File file = new File(filePath);
        if (!file.exists()) {
            System.out.println("File does not exist.");
            return "0001";  // Return the first ID if file doesn't exist
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            int lineCount = 0;

            // Count the number of lines in the file
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

    public boolean isEmailExists(String email) {
        File file = new File(filePath);
        if (!file.exists()) {
            return false;
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] userData = line.split(",");
                if (userData.length >= 4 && userData[3].equals(email)) {
                    return true;
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }
        return false;
    }

    public boolean updatePassword(String username, String oldPassword, String newPassword) {
        File file = new File(filePath);
        List<String> lines = new ArrayList<>();
        boolean passwordUpdated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] userFields = line.split(",");
                if (userFields.length >= 5) {
                    String storedUsername = userFields[2];
                    String storedPassword = userFields[4];
                    System.out.println("su"+storedUsername);
                    System.out.println("s"+username);
                    System.out.println(storedUsername.equals(username));
                    System.out.println("op"+oldPassword);
                    System.out.println("op"+oldPassword);
                    System.out.println("sp"+storedPassword);
                    System.out.println(passwordUtils.hashPassword(oldPassword));
                    System.out.println(passwordUtils.hashPassword("1234"));
                    System.out.println(passwordUtils.verifyPassword("1234",storedPassword));
                    if (storedUsername.equals(username) && passwordUtils.verifyPassword(oldPassword, storedPassword)) {
                        line = userFields[0] + "," + userFields[1] + "," + storedUsername + "," + userFields[3] + "," + passwordUtils.hashPassword(newPassword) + "," + userFields[5];
                        System.out.println("updated");
                        passwordUpdated = true;
                    }
                }
                lines.add(line);
            }
            System.out.println(passwordUpdated);
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (passwordUpdated) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
                for (String updatedLine : lines) {
                    writer.write(updatedLine);
                    writer.newLine();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return passwordUpdated;
    }

}
