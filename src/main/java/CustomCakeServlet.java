import entities.CustomCakeOrder;
import entities.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.CredsFileHandle;
import utils.CustomOrderQueue;


import java.io.IOException;

@WebServlet("/customcake")
public class CustomCakeServlet extends HttpServlet {

    CredsFileHandle ch = new CredsFileHandle();

    public void init(){
       try{
           CustomOrderQueue.loadFromFile();
        } catch (IOException e) {
            System.err.println("Error load from file");
            e.printStackTrace();
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("customCake.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String occasion = request.getParameter("occasion");
        String flavour = request.getParameter("flavor");
        String filling = request.getParameter("filling");
        String status = request.getParameter("status");
        String shape = request.getParameter("shape");
        String size = request.getParameter("size");
        String deliveryDate = request.getParameter("deliveryDate");
        String instructions = request.getParameter("instructions");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        User user = ch.getUserByEmail(email);
        String id = String.valueOf(user.getID());
        System.out.println("User Id :" + id);

        CustomCakeOrder cco = new CustomCakeOrder(id,null, 1, "pending", 0, deliveryDate, occasion, flavour, filling, size, shape,instructions);
        CustomOrderQueue.add(cco);





    }
}



