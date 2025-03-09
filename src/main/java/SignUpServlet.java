import entities.User;
import utils.CredsFileHandle;
import utils.PasswordUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

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
        String errorMessage = null;

        if (name == null || name.trim().isEmpty()) {
            errorMessage = "Name is required!";
        } else if (username == null || username.trim().isEmpty()) {
            errorMessage = "Username is required!";
        } else if (existingUser != null) {
            errorMessage = "Username already exists!";
        } else if (email == null || email.trim().isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            errorMessage = "Invalid email format!";
        } else if (password == null || password.trim().isEmpty()) {
            errorMessage = "Password is required!";
        } else if (!password.equals(confirmPassword)) {
            errorMessage = "Passwords do not match!";
        }

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            credsFileHandle.addUser(name,username,email,passwordUtils.hashPassword(password),"USER");
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}
