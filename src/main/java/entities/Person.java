package entities;

public abstract class Person {
    protected int ID;
    protected String fName;
    protected String lName;
    protected String email;

    public Person(int ID, String fName, String lName, String email) {
        this.ID = ID;
        this.fName = fName;
        this.lName = lName;
        this.email = email;
    }


    public abstract String getFullName();


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

    @Override
    public String toString() {
        return "Person{" +
                "ID=" + ID +
                ", fName='" + fName + '\'' +
                ", lName='" + lName + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
} 