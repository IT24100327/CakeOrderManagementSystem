import entities.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.CredsFileHandle;
import utils.PasswordUtils;

import java.io.IOException;

@WebServlet("/deleteprofile")
public class DeleteProfileServlet extends HttpServlet {
    private CredsFileHandle credsFileHandle = new CredsFileHandle();
    private PasswordUtils passwordUtils = new PasswordUtils();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String currentEmail = (String) session.getAttribute("email");
        String confirmPassword = request.getParameter("confirmPassword");

        // Get current user
        User currentUser = credsFileHandle.getUserByEmail(currentEmail);
        
        if (currentUser == null) {
            session.setAttribute("errorMessage", "User not found!");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        // Verify password
        if (!passwordUtils.verifyPassword(confirmPassword, currentUser.getPassword())) {
            session.setAttribute("errorMessage", "Incorrect password!");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        boolean deleted = credsFileHandle.deleteUser(currentEmail);
        
        if (deleted) {
            // Invalidate session
            session.invalidate();
            // Create new session for message
            session = request.getSession();
            session.setAttribute("successMessage", "Profile deleted successfully!");
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            session.setAttribute("errorMessage", "Failed to delete profile!");
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }
}
