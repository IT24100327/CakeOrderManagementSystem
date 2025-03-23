package entities;

public class User {
    private int ID;
    private String fName;
    private String lName;
    private String email;
    private String password;
    private String ROLE;

    public User(int ID, String fName, String lName, String email, String password, String ROLE) {
        this.ID = ID;
        this.fName = fName;
        this.lName = lName;
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

    public String getfName() {
        return fName;
    }

    public void setfName(String fName) {
        this.fName = fName;
    }

    public String getlName() {
        return lName;
    }

    public void setlName(String lName) {
        this.lName = lName;
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
