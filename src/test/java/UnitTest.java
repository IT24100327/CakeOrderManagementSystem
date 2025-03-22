import entities.User;
import org.junit.Test;
import utils.CredsFileHandle;

import java.io.File;
import java.io.IOException;

import static org.junit.Assert.*;

public class UnitTest {

    CredsFileHandle credsFileHandle = new CredsFileHandle();

    @Test
    public void testAddUser() throws IOException {
        File file = new File("data/users.txt");
        String name = "Heshan";
        String username = "heshank";
        String email = "heshan@example.com";
        String password = "heshan123";
        String role = "ADMIN";

        assertTrue("User should be added successfully", credsFileHandle.addUser(name, username, email, password, role));

        // Check if the user details are written to the file
        String fileContent = new String(java.nio.file.Files.readAllBytes(file.toPath()));
        assertTrue("File should contain the user's name", fileContent.contains(name));
        assertTrue("File should contain the user's username", fileContent.contains(username));
        assertTrue("File should contain the user's email", fileContent.contains(email));
        assertTrue("File should contain the user's password", fileContent.contains(password));
        assertTrue("File should contain the user's role", fileContent.contains(role));
    }

    @Test
    public void testGetUserByUsername() {
        String username = "heshan";
        User user = credsFileHandle.getUserByUsername(username);
        assertNotNull("User should be found", user);
        assertEquals("Name should match", "Heshan K", user.getName());
//        assertEquals("Username should match", username, user.getUsername());
//        assertEquals("Email should match", "heshan@example.com", user.getEmail());
//        assertEquals("Role should match", "ADMIN", user.getROLE());
    }

//    @Test
//    public void testUpdateUser() {
//        // Define test user details
//        String oldUsername = "heshank";
//        String newName = "Heshan Tk";
//        String newEmail = "heshan.tk@example.com";
//        String newPassword = "newpassword123";
//        String newRole = "ADMIN";
//
//        boolean result = credsFileHandle.updateUser(oldUsername, newName, newEmail, newPassword, newRole);
//        assertTrue("User should be updated successfully", result);
//        File file = new File("data/users.txt");
//
//        try {
//            String fileContent = new String(java.nio.file.Files.readAllBytes(file.toPath()));
//            assertTrue("File should contain the updated user's name", fileContent.contains(newName));
//            assertTrue("File should contain the updated email", fileContent.contains(newEmail));
//            assertTrue("File should contain the updated password", fileContent.contains(newPassword));
//            assertTrue("File should contain the updated role", fileContent.contains(newRole));
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }

    @Test
    public void testDeleteUser() {
        String username = "heshank";
        boolean result = credsFileHandle.deleteUser(username);

        assertTrue("User should be deleted successfully", result);

        File file = new File("data/users.txt");
        try {
            String fileContent = new String(java.nio.file.Files.readAllBytes(file.toPath()));
            assertFalse("File should not contain the deleted user's username", fileContent.contains(username));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testGetID(){
        System.out.println(credsFileHandle.getID());
    }

    @Test
    public void testIsEmailExists(){
        System.out.println(credsFileHandle.isEmailExists("heshan@gmail.com"));
    }

    @Test
    public void testPasswordChange(){
        credsFileHandle.updatePassword("user1","1234","12345");
    }
}
