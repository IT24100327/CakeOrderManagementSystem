import entities.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.CredsFileHandle;
import utils.PasswordUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig
@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {

    CredsFileHandle credsFileHandle = new CredsFileHandle();
    PasswordUtils passwordUtils = new PasswordUtils();

    public SignUpServlet() {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("signup");
        RequestDispatcher dispatcher = request.getRequestDispatcher("signup.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        System.out.println(name);
        System.out.println(username);
        System.out.println(email);
        System.out.println(password);
        System.out.println(confirmPassword);

        User existingUser = credsFileHandle.getUserByUsername(username);
        List<String> errorMessages = new ArrayList<>();

        // Check for empty fields and other conditions
        if (name == null || name.trim().isEmpty()) {
            errorMessages.add("Name is required!");
        }
        if (username == null || username.trim().isEmpty()) {
            errorMessages.add("Username is required!");
        }
        if (existingUser != null) {
            errorMessages.add("Username already exists!");
        }
        if (email == null || email.trim().isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            errorMessages.add("Invalid email format!");
        }
        // Use the isEmailExists method to check if the email already exists
        if (credsFileHandle.isEmailExists(email)) {
            errorMessages.add("Email is already in use!");
        }
        if (password == null || password.trim().isEmpty()) {
            errorMessages.add("Password is required!");
        }
        if (!password.equals(confirmPassword)) {
            errorMessages.add("Passwords do not match!");
        }

        // If there are any errors, set the errorMessages list as a request attribute and forward back to the signup page
        if (!errorMessages.isEmpty()) {
            request.setAttribute("errorMessages", errorMessages);
            request.setAttribute("name", name);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            credsFileHandle.addUser(name, username, email, passwordUtils.hashPassword(password), "USER");
            response.sendRedirect(request.getContextPath() + "/signin");  // Redirect to signin page after successful registration
        }
    }
}
