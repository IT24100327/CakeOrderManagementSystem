import entities.User;
import utils.CredsFileHandle;

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
        System.out.println("Received Username: " + username + " Password: " + password);
        if (username != null && !username.trim().isEmpty() && password != null && !password.trim().isEmpty()) {
            System.out.println("Username: " + username);
            System.out.println("Password: " + password);
            User user = credsFileHandle.getUserByUsername(username);
            if (user !=null){
                System.out.println("User found");
                response.sendRedirect(request.getContextPath() + "/");
            }else{
                System.out.println("User not found");
                request.setAttribute("errorMessage", "User not found");
                request.getRequestDispatcher("signin.jsp").forward(request, response);
            }


        } else {
            request.setAttribute("errorMessage", "Username or Password cannot be empty.");
            request.getRequestDispatcher("signin.jsp").forward(request, response);
        }


    }
}
