import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.CredsFileHandle;
import utils.PasswordUtils;

import java.io.IOException;

@WebServlet("/updatepassword")
public class UpdatePasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confNewPassword");
        CredsFileHandle credsFileHandle = new CredsFileHandle();

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New password and Confirm password do not match.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);

        }
        System.out.println(username);
        System.out.println(oldPassword);
        System.out.println(newPassword);
        System.out.println(confirmPassword);

        boolean passwordUpdated = credsFileHandle.updatePassword(username, oldPassword, newPassword);

        if (passwordUpdated) {
            request.setAttribute("successMessage", "Password updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Old password is incorrect or user not found.");
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);

    }
}
