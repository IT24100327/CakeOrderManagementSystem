import entities.User;
import utils.CredsFileHandle;
import utils.PasswordUtils;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@MultipartConfig
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    CredsFileHandle credsFileHandle = new CredsFileHandle();
    PasswordUtils passwordUtils = new PasswordUtils();

    public LoginServlet() {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("signin - GET request");
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("signin - POST request");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("Received Email: " + email);
        System.out.println("Received Password: " + password);

        if (email != null && !email.trim().isEmpty() && password != null && !password.trim().isEmpty()) {
            User user = credsFileHandle.getUserByEmail(email);
            if (user != null) {
                if (passwordUtils.verifyPassword(password, user.getPassword())) {
                    System.out.println("Login successful for user: " + email);
                    request.getSession().setAttribute("fname", user.getfName());
                    request.getSession().setAttribute("lname", user.getlName());
                    request.getSession().setAttribute("email", user.getEmail());
                    request.getSession().setAttribute("ROLE", user.getROLE());
                    response.sendRedirect(request.getContextPath() + "/");
                } else {
                    System.out.println("Incorrect password for user: " + email);
                    request.setAttribute("errorMessage", "Incorrect password!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                System.out.println("User not found with email: " + email);
                request.setAttribute("errorMessage", "User not found!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            System.out.println("Email or Password cannot be empty.");
            request.setAttribute("errorMessage", "Email or Password cannot be empty.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
