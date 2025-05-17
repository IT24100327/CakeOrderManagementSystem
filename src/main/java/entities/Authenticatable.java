package entities;

public interface Authenticatable {
    boolean authenticate(String password);
    void setPassword(String password);
    String getPassword();
    String getROLE();
    void setROLE(String ROLE);
    

    default boolean isAdmin() {
        return "ADMIN".equals(getROLE());
    }
} 