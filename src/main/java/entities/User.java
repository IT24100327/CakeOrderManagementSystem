package entities;

public class User {
    private int ID;
    private String name;
    private String username;
    private String email;
    private String password;
    private String ROLE;

    public User(int ID, String name, String username, String email, String password, String ROLE) {
        this.ID = ID;
        this.name = name;
        this.username = username;
        this.email = email;
        this.password = password;
        this.ROLE = ROLE;
    }

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getROLE() {
        return ROLE;
    }

    public void setROLE(String ROLE) {
        this.ROLE = ROLE;
    }
}
