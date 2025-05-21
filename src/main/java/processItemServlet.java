import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import entities.Item;
import utils.ItemCatalog;

@WebServlet("/processItem")

public class processItemServlet extends HttpServlet {
    ItemCatalog catalog = new ItemCatalog();

    public void init() {
        try {
            ItemCatalog.loadFromFile();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("place".equals(action)) {
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");


            Item newItem = new Item(name, price, null, category, description);
            ItemCatalog.addItem(newItem);

            response.sendRedirect(request.getContextPath() + "/admin/ManageItems.jsp");

        } else if ("remove".equals(action)) {
            String itemId = request.getParameter("itemId");
            ItemCatalog.removeItem(itemId);

            response.sendRedirect(request.getContextPath() + "/admin/ManageItems.jsp");

        } else if ("update".equals(action)) {

            String itemId = request.getParameter("itemId");
            ItemCatalog.removeItem(itemId);

            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");
            String description = request.getParameter("description");

            Item newItem = new Item(name, price, itemId, category,description);
            ItemCatalog.addItem(newItem);

            response.sendRedirect(request.getContextPath() + "/admin/ManageItems.jsp");

        }

    }

}