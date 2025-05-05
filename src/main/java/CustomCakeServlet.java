import entities.CustomCakeOrder;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utils.CredsFileHandle;
import utils.CustomOrderQueue;
import utils.OrderQueue;

import java.io.IOException;

@WebServlet("/customcake")
public class CustomCakeServlet extends HttpServlet {



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

        CustomCakeOrder cco = new CustomCakeOrder("1",null, 1, "pending", 0, deliveryDate, occasion, flavour, filling, size, shape);
        CustomOrderQueue.add(cco);




    }
}



