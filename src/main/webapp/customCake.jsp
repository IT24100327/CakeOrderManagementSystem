<%@ page import="entities.User" %>
<!DOCTYPE html>

<% User user = (User) session.getAttribute("USER");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Heavenly Bakery - Custom Cake Order</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">

    <!--  Change to local fonts Later -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Abril+Fatface&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Alex+Brush&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway&amp;display=swap">
    <link rel="stylesheet" href="assets/css/bs-theme-overrides.css">
    <link rel="stylesheet" href="assets/css/Banner-Heading-Image-images.css">
    <link rel="stylesheet" href="assets/css/Navbar-Centered-Links-icons.css">
    <link rel="stylesheet" href="assets/css/Signup-page-with-overlay.css">
    <style>
        body {
            background-color: #FFF2E1;
        }
        .form-container {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 2.5rem;
            margin-bottom: 3rem;
        }
        .form-label {
            color: #5A3921 !important;
            margin-bottom: 0.5rem;
        }
        .form-select, .form-control {
            border: 1px solid #D4A76A;
            border-radius: 8px !important;
            padding: 0.75rem 1rem;
            margin-bottom: 1.5rem;
        }
        .form-select:focus, .form-control:focus {
            border-color: #885030;
            box-shadow: 0 0 0 0.25rem rgba(136, 80, 48, 0.25);
        }
        .btn-primary {
            background-color: #885030;
            border-color: #885030;
            padding: 0.75rem 2.5rem;
            border-radius: 8px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 1rem;
        }
        .btn-primary:hover {
            background-color: #6D3F26;
            border-color: #6D3F26;
        }
        input[type="date"] {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #D4A76A;
            border-radius: 8px;
            color: #495057;
        }
        .nav-link {
            font-size: 14px !important;
        }
        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>

<body>
<nav class="navbar navbar-expand-md bg-primary py-3 mb-4" style="background: var(--bs-secondary);color: var(--bs-primary);">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <span class="fs-5 fw-light text-start" style="color: var(--bs-secondary);font-family: 'Alex Brush', serif;font-size: 29px;">Heavenly Bakery</span>
        </a>
        <button data-bs-toggle="collapse" class="navbar-toggler" data-bs-target="#navcol-3">
            <span class="visually-hidden">Toggle navigation</span>
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navcol-3">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item" style="font-size: 12px;text-align: center;">
                    <a class="nav-link active me-5" href="<%= request.getContextPath() %>/" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-weight: bold;">HOME</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/about" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">ABOUT</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/customCake.jsp" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">CUSTOM CAKES</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/reviews" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">REVIEWS</a>
                </li>
                <%
                    if (user.getEmail() != null) {
                %>
                <li class="nav-item">
                    <a class="nav-link me-5" href="profile.jsp" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">PROFILE</a>
                </li>
                <%
                    }
                %>
                <%
                    if (user.getROLE() != null && user.getROLE().equals("ADMIN")) {
                %>
                <li class="nav-item">
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/admin" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">ADMIN PANEL</a>
                </li>
                <%
                    }
                %>
            </ul>
            <%
                if (user.getEmail() == null) {
            %>
            <button class="btn btn-secondary fw-light me-2" type="button" style="font-family: Raleway, sans-serif;font-size: 12px;border-radius: 0px;"><a class="nav-link" href="<%= request.getContextPath() %>/login">LOGIN</a></button>
            <button class="btn btn-secondary fw-light" type="button" style="font-family: Raleway, sans-serif;font-size: 12px;border-radius: 0px;"><a class="nav-link" href="<%= request.getContextPath() %>/signup">SIGN UP</a></button>
            <%
            } else {
            %>
            <button class="btn btn-secondary fw-light me-2" type="button" style="font-family: Raleway, sans-serif;font-size: 12px;border-radius: 0px;"><a class="nav-link" href="<%= request.getContextPath() %>/logout">LOGOUT</a></button>
            <%
                }
            %>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="text-center mb-5">
                <h1 style="font-family: 'Abril Fatface', serif;font-size: 3.5rem;color: #885030;">
                    Order a Custom Cake
                </h1>
                <p class="lead" style="color: #5A3921; font-family: 'Raleway', sans-serif;">
                    Create your perfect cake for any occasion
                </p>
            </div>

            <div class="form-container">
                <form method="post" action="<%=request.getContextPath()%>/CustomOrder">
                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label">Occasion:</label>
                            <select class="form-select" name="occasion">
                                <option value="Birthday" selected>Birthday</option>
                                <option value="Wedding">Wedding</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Cake Flavor:</label>
                            <select class="form-select" name="flavor">
                                <option value="Chocolate" selected>Chocolate</option>
                                <option value="Vanilla">Vanilla</option>
                                <option value="Strawberry">Strawberry</option>
                                <option value="Red Velvet">Red Velvet</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label">Filling/Topping:</label>
                            <select class="form-select" name="filling">
                                <option value="Buttercream" selected>Buttercream</option>
                                <option value="Ganache">Ganache</option>
                                <option value="Fruit">Fruit</option>
                                <option value="None">None</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Cake Size:</label>
                            <select class="form-select" name="size">
                                <option value="Small" selected>Small (h:6", w:500g)</option>
                                <option value="Medium">Medium (h:12", w:1kg)</option>
                                <option value="Large">Large (h:18", w:1.5kg)</option>
                                <option value="Extra large">Extra Large (h:24", w:2kg)</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label" for="shape">Cake Shape:</label>
                            <select class="form-select" name="shape" id="shape">
                                <option value="Round" selected>Round</option>
                                <option value="Square">Square</option>
                                <option value="Heart">Heart</option>
                                <option value="Custom">Custom</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Delivery Date:</label>
                            <input type="date" class="form-control" id="start" name="deliveryDate">
                        </div>
                    </div>
                    <div class="mb-4">
                        <label for="instructions" class="form-label">Special Instructions:</label>
                        <textarea class="form-control" rows="4" id="instructions" name="instructions" placeholder="Any specific design requests, allergies, or other details..."></textarea>
                    </div>
                    <div class="text-center mt-4">
                        <button class="btn btn-primary btn-lg" type="submit">Place Order</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="assets/bootstrap/js/bootstrap.min.js"></script>
<script>
    // Set minimum date to today
    document.getElementById('start').min = new Date().toISOString().split('T')[0];
</script>
</body>
</html>