package entities;

import utils.PasswordUtils;

public class User extends Person implements Authenticatable {
    private String password;
    private String ROLE;
    private static final PasswordUtils passwordUtils = new PasswordUtils();

    public User(int ID, String fName, String lName, String email, String password, String ROLE) {
        super(ID, fName, lName, email);
        this.password = password;
        this.ROLE = ROLE;
    }

    @Override
    public String getFullName() {
        return fName + " " + lName;
    }

    @Override
    public boolean authenticate(String inputPassword) {
        return passwordUtils.verifyPassword(inputPassword, this.password);
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public void setPassword(String password) {
        this.password = passwordUtils.hashPassword(password);
    }

    @Override
    public String getROLE() {
        return ROLE;
    }

    @Override
    public void setROLE(String ROLE) {
        this.ROLE = ROLE;
    }


    public String toFileString() {
        return ID + "," + fName + "," + lName + "," + email + "," + password + "," + ROLE;
    }


    public static User fromFileString(String str) {
        String[] parts = str.split(",");
        if (parts.length < 6) {
            throw new IllegalArgumentException("Invalid user string format");
        }
        return new User(
            Integer.parseInt(parts[0]),
            parts[1],
            parts[2],
            parts[3],
            parts[4],
            parts[5]
        );
    }

    @Override
    public String toString() {
        return "User{" +
                "ID=" + ID +
                ", firstName='" + fName + '\'' +
                ", lastName='" + lName + '\'' +
                ", email='" + email + '\'' +
                ", role='" + ROLE + '\'' +
                '}';
    }
}
