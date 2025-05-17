import entities.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.CredsFileHandle;

import java.io.IOException;

@WebServlet("/updateprofile")
public class UpdateProfileServlet extends HttpServlet {
    private CredsFileHandle credsFileHandle = new CredsFileHandle();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String currentEmail = (String) session.getAttribute("email");
        
        // Get form data
        String newFirstName = request.getParameter("firstName");
        String newLastName = request.getParameter("lastName");
        String newEmail = request.getParameter("email");

        // Basic validation
        if (newFirstName == null || newLastName == null || newEmail == null ||
            newFirstName.trim().isEmpty() || newLastName.trim().isEmpty() || newEmail.trim().isEmpty()) {
            session.setAttribute("errorMessage", "All fields are required!");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        // Get current user
        User currentUser = credsFileHandle.getUserByEmail(currentEmail);
        if (currentUser == null) {
            session.setAttribute("errorMessage", "User not found!");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        // Update user
        boolean updated = credsFileHandle.updateUser(
            currentEmail,
            newFirstName,
            newLastName,
            newEmail,
            currentUser.getPassword(),
            currentUser.getROLE()
        );

        if (updated) {
            // Update session attributes
            session.setAttribute("email", newEmail);
            session.setAttribute("fname", newFirstName);
            session.setAttribute("lname", newLastName);
            session.setAttribute("successMessage", "Profile updated successfully!");
        } else {
            session.setAttribute("errorMessage", "Failed to update profile!");
        }
        
        response.sendRedirect(request.getContextPath() + "/profile");
    }
}
