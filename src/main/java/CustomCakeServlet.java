import entities.CustomCakeOrder;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/customcake")
public class CustomCakeServlet extends HttpServlet {
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
        String size = request.getParameter("size");
        String shape = request.getParameter("shape");
        String deliveryDate = request.getParameter("deliveryDate");



        CustomCakeOrder co = new CustomCakeOrder("O1",1,occasion,flavour,filling,size,shape,deliveryDate);

        co.saveInFile();


    }
}



