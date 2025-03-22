import entities.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.CredsFileHandle;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;


@WebServlet("/updateprofile")
public class UpdateProfileServlet extends HttpServlet {

    CredsFileHandle credsFileHandle = new CredsFileHandle();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String oldUsername = (String) request.getSession().getAttribute("username");
        String oldEmail = (String) request.getSession().getAttribute("email");
        String newUsername = request.getParameter("newUsername");
        String newFullName = request.getParameter("newFullName");
        String newEmail = request.getParameter("newEmail");

        if (newUsername.equals(oldUsername) && newEmail.equals(oldEmail)) {
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        }

        User oldUser = credsFileHandle.getUserByUsername(oldUsername);
        List<String> errors = new ArrayList<>();

        if (newUsername == null || newUsername.trim().isEmpty()) {
            errors.add("Username cannot be empty.");
        } else {
            if (credsFileHandle.getUserByUsername(newUsername) != null && !newUsername.equals(oldUsername)) {
                errors.add("Username already exists.");
            }
        }

        if (newEmail == null || newEmail.trim().isEmpty()) {
            errors.add("Email cannot be empty.");
        } else {
            if (credsFileHandle.isEmailExists(newEmail) && !newEmail.equals(oldEmail)) {
                errors.add("Email is already in use.");
            } else {
                String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
                if (!newEmail.matches(emailRegex)) {
                    errors.add("Invalid email format.");
                }
            }
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
            return;
        }


        boolean updated = credsFileHandle.updateUser(oldUsername, newUsername, newFullName, newEmail, oldUser.getPassword(), oldUser.getROLE());
        if (updated) {
            request.getSession().setAttribute("username", newUsername);
            request.getSession().setAttribute("email", newEmail);
            request.getSession().setAttribute("name", newFullName);

            response.sendRedirect(request.getContextPath() + "/profile");
        } else {
            request.setAttribute("error", "Failed to update the user details.");
            request.getRequestDispatcher("/profile.jsp").forward(request, response);
        }
    }
}
