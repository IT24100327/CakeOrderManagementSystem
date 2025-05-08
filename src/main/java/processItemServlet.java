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
            catalog.loadFromFile();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    } // Load orders on startup

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("place".equals(action)) {
            String name = request.getParameter("name");
            String category = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");

            // itemId is null because catalog.addItem method will assign one
            Item newItem = new Item(name, price, null, category, description);
            catalog.addItem(newItem);
            response.sendRedirect(request.getContextPath() + "/admin/ManageItems.jsp");

        } else if ("remove".equals(action)) {
            String itemId = request.getParameter("itemId");
            catalog.removeItem(itemId);
            response.sendRedirect(request.getContextPath() + "/admin/ManageItems.jsp");

        } else if ("update".equals(action)) {

            String itemId = request.getParameter("itemId");
            catalog.removeItem(itemId);

            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");
            String description = request.getParameter("description");

            Item newItem = new Item(name, price, itemId, category,description);
            catalog.addItem(newItem);

            response.sendRedirect(request.getContextPath() + "/admin/ManageItems.jsp");
        }
    }

}