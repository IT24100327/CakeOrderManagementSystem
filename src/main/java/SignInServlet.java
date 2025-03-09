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
@WebServlet("/signin")
public class SignInServlet extends HttpServlet {

    CredsFileHandle credsFileHandle = new CredsFileHandle();
    PasswordUtils passwordUtils = new PasswordUtils();

    public SignInServlet() {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("signin - GET request");
        RequestDispatcher dispatcher = request.getRequestDispatcher("signin.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("signin - POST request");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("Received Username: " + username);
        System.out.println("Received Password: " + password);

        if (username != null && !username.trim().isEmpty() && password != null && !password.trim().isEmpty()) {
            User user = credsFileHandle.getUserByUsername(username);
            System.out.println(user.getPassword());
            if (user != null) {
                if (passwordUtils.verifyPassword(password, user.getPassword())) {
                    System.out.println("Login successful for user: " + username);
                    request.getSession().setAttribute("name", user.getName());
                    request.getSession().setAttribute("username", user.getUsername());
                    request.getSession().setAttribute("ROLE", user.getROLE());
                    response.sendRedirect(request.getContextPath() + "/");
                } else {
                    System.out.println("Incorrect password for user: " + username);
                    request.setAttribute("errorMessage", "Incorrect password!");
                    request.getRequestDispatcher("signin.jsp").forward(request, response);
                }
            } else {
                System.out.println("User not found: " + username);
                request.setAttribute("errorMessage", "User not found!");
                request.getRequestDispatcher("signin.jsp").forward(request, response);
            }
        } else {
            System.out.println("Username or Password cannot be empty.");
            request.setAttribute("errorMessage", "Username or Password cannot be empty.");
            request.getRequestDispatcher("signin.jsp").forward(request, response);
        }
    }
}
