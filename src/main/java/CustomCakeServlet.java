import entities.CustomCakeOrder;
import entities.Order;
import entities.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utils.CredsFileHandle;
import utils.OrderQueue;


import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/CustomOrder")
public class CustomCakeServlet extends HttpServlet {

    CredsFileHandle ch = new CredsFileHandle();

    public void init(){
       try{
           OrderQueue.loadFromFile();
        } catch (IOException e) {
            System.err.println("Error load from file");
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String occasion = request.getParameter("occasion");
        String flavour = request.getParameter("flavor");
        String filling = request.getParameter("filling");
        String status = request.getParameter("status");
        String shape = request.getParameter("shape");
        String size = request.getParameter("size");
        LocalDate deliveryDate = LocalDate.parse(request.getParameter("deliveryDate"));
        String instructions = request.getParameter("instructions");

        User user = (User) request.getSession().getAttribute("USER");

        CustomCakeOrder cco = new CustomCakeOrder(user,null, deliveryDate, occasion, flavour, filling, size, shape,instructions);
        OrderQueue.add(cco);
        System.out.println("Order added");

        request.setAttribute("cco", cco);

        RequestDispatcher dispatcher = request.getRequestDispatcher("Custom_payment_details.jsp");
        dispatcher.forward(request, response);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String orderId = request.getParameter("orderId");

        if (action.equals("to-process")) {
            OrderQueue.processOrder(OrderQueue.findOrderById(orderId));
            response.sendRedirect(request.getContextPath() + "/admin/ManageCustomOrders.jsp");
        }

    }
}



