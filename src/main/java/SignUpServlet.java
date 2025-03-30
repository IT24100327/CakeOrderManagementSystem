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
    private static final long serialVersionUID = 1L;

    CredsFileHandle credsFileHandle = new CredsFileHandle();
    PasswordUtils passwordUtils = new PasswordUtils();

    public SignUpServlet() {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("signup page accessed");
        RequestDispatcher dispatcher = request.getRequestDispatcher("signup.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("password_repeat");

        System.out.println("First Name: " + firstName);
        System.out.println("Last Name: " + lastName);
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);
        System.out.println("Confirm Password: " + confirmPassword);

        List<String> errorMessages = new ArrayList<>();

        if (firstName == null || firstName.trim().isEmpty()) {
            errorMessages.add("First name is required!");
        }
        if (lastName == null || lastName.trim().isEmpty()) {
            errorMessages.add("Last name is required!");
        }
        if (email == null || email.trim().isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            errorMessages.add("Invalid email format!");
        }
        if (password == null || password.trim().isEmpty()) {
            errorMessages.add("Password is required!");
        }
        if (!password.equals(confirmPassword)) {
            errorMessages.add("Passwords do not match!");
        }


        User existingUser = credsFileHandle.getUserByEmail(email);
        if (existingUser != null) {
            errorMessages.add("An account with this email already exists!");
        }

        if (!errorMessages.isEmpty()) {
            request.setAttribute("errorMessages", errorMessages);
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            // Add user since no errors
            boolean isAdded = credsFileHandle.addUser(firstName, lastName, email, password, "USER");

            if (isAdded) {
                System.out.println("Signup successful!");
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
                errorMessages.add("An error occurred while adding the user.");
                request.setAttribute("errorMessages", errorMessages);
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        }
    }


}
