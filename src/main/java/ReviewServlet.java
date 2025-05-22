import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import utils.ReviewFileHandler;
import entities.Review;

@MultipartConfig
@WebServlet("/review")
public class ReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReviewFileHandler reviewFileHandler;

    public ReviewServlet() {
        super();
        reviewFileHandler = new ReviewFileHandler();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("review - GET request");
        RequestDispatcher dispatcher = request.getRequestDispatcher("review.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("review - POST request");
        
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            String reviewId = request.getParameter("reviewId");
            if (reviewFileHandler.deleteReview(reviewId)) {
                request.setAttribute("successMessage", "Review deleted successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to delete review!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/ManageReviews.jsp");
            return;
        }
        
        try {
            // Create new Review object using constructor
            Review review = new Review(
                request.getParameter("name"),
                request.getParameter("email"),
                request.getParameter("message")
            );
            
            // Print the received data to console
            System.out.println("Received Review/Feedback:");
            System.out.println(review.toString());
            
            // Write review to file
            reviewFileHandler.writeReview(review);
            
            // Set success message and redirect back to index page
            request.setAttribute("successMessage", "Thank you for your feedback!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
            
        } catch (IllegalArgumentException e) {
            // Handle validation errors
            request.setAttribute("errorMessage", "Invalid input: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        }
    }
} 