//import entities.User;
//import utils.CredsFileHandle;
//import utils.PasswordUtils;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//
//@WebServlet("/deleteprofile")
//public class DeleteProfileServlet extends HttpServlet {
//    CredsFileHandle credsFileHandle = new CredsFileHandle();
//    PasswordUtils passwordUtils = new PasswordUtils();
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        System.out.println("Get");
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//        System.out.println("Deletion came");
//
//        User user = credsFileHandle.getUserByUsername(username);
//        System.out.println(user.getName());
//        System.out.println(user);
//        System.out.println(passwordUtils.verifyPassword(password, user.getPassword()));
//        if (user != null && passwordUtils.verifyPassword(password, user.getPassword())) {
//             credsFileHandle.deleteUser(username);
//            System.out.println("removed");
//            response.sendRedirect(request.getContextPath() + "/logout");
//        } else {
//
//            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
//            response.getWriter().write("Incorrect password. Please try again.");
//        }
//    }
//
//}
