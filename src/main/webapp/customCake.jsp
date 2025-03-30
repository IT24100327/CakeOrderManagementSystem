<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Heavenly Bakery - Custom Cake Order</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Abril+Fatface&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Alex+Brush&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway&amp;display=swap">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bs-theme-overrides.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Banner-Heading-Image-images.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Navbar-Centered-Links-icons.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Signup-page-with-overlay.css">
</head>

<body style="background: var(--bs-secondary);">
<%
    String email = (String) session.getAttribute("email");
    String ROLE = (String) session.getAttribute("ROLE");
%>
<nav class="navbar navbar-expand-md bg-primary py-3" style="background: var(--bs-secondary);color: var(--bs-primary);">
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
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/customcake" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">CUSTOM CAKES</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/reviews" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">REVIEWS</a>
                </li>
                <%
                    if(email != null){
                %>
                <li class="nav-item">
                    <a class="nav-link me-5" href="#" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">PROFILE</a>
                </li>
                <%
                    }
                %>

                <%if(ROLE != null){
                    if(ROLE.equals("ADMIN")){
                %>
                <li class="nav-item">
                    <a class="nav-link me-5" href="<%= request.getContextPath() %>/admin" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">ADMIN PANEL</a>
                </li>
                <%
                        }
                    }
                %>

            </ul>
            <%
                if(email == null){
            %>
            <button class="btn btn-secondary fw-light me-2" type="button" style="font-family: Raleway, sans-serif;font-size: 12px;border-radius: 0px;"><a class="nav-link" href="<%= request.getContextPath() %>/login">LOGIN</a></button>
            <button class="btn btn-secondary fw-light" type="button" style="font-family: Raleway, sans-serif;font-size: 12px;border-radius: 0px;"><a class="nav-link" href="<%= request.getContextPath() %>/signup">SIGN UP</a></button>

            <%
            }else{
            %>
            <button class="btn btn-secondary fw-light me-2" type="button" style="font-family: Raleway, sans-serif;font-size: 12px;border-radius: 0px;"><a class="nav-link" href="<%= request.getContextPath() %>/logout">LOGOUT</a></button>
            <%
                }
            %>
        </div>
    </div>
</nav>

    <div class="container-md focus-ring flex-column" style="background: rgba(255,226,187,0);">
        <div class="row">
            <div class="col">
                <div class="row d-flex">
                    <div class="col mb-4">
                        <h1 style="font-family: 'Abril Fatface', serif;font-size: 62px;">
                            <span style="color: rgb(136, 80, 48);">Order a Custom Cake</span>
                        </h1>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <form>
                    <div class="row mb-5">
                        <div class="col-xxl-5">
                            <!-- Placeholder for an image -->
                            <img src="assets/img/recipe.png" alt="Custom Cake Example" class="img-fluid" />
                        </div>
                        <div class="col">
                            <div class="row">
                                <div class="col">
                                    <label class="form-label" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);font-size: 20px;">Occasion:</label>
                                    <select class="focus-ring focus-ring-primary form-select mb-3">
                                        <option value="birthday" selected>Birthday</option>
                                        <option value="wedding">Wedding</option>
                                        <option value="anniversary">Anniversary</option>
                                        <option value="other">Other</option>
                                    </select>
                                </div>
                                <div class="col">
                                    <label class="form-label" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);font-size: 20px;">Cake Flavor:</label>
                                    <select class="form-select mb-3">
                                        <option value="chocolate" selected>Chocolate</option>
                                        <option value="vanilla">Vanilla</option>
                                        <option value="strawberry">Strawberry</option>
                                        <option value="red-velvet">Red Velvet</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <label class="form-label" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);font-size: 20px;">Filling/Topping:</label>
                                    <select class="form-select mb-3">
                                        <option value="buttercream" selected>Buttercream</option>
                                        <option value="ganache">Ganache</option>
                                        <option value="fruit">Fruit</option>
                                        <option value="none">None</option>
                                    </select>
                                </div>
                                <div class="col">
                                    <label class="form-label" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);font-size: 20px;">Cake Size:</label>
                                    <select class="form-select mb-3">
                                        <option value="small" selected>Small (6")</option>
                                        <option value="medium">Medium (8")</option>
                                        <option value="large">Large (10")</option>
                                        <option value="x-large">Extra Large (12")</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <label class="form-label" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);font-size: 20px;">Cake Shape:</label>
                                    <select class="form-select mb-3">
                                        <option value="round" selected>Round</option>
                                        <option value="square">Square</option>
                                        <option value="heart">Heart</option>
                                        <option value="custom">Custom</option>
                                    </select>
                                </div>
                                <div class="col"></div>
                            </div>
                            <label class="form-label" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);font-size: 20px;">Special Instructions:</label>
                            <textarea class="border-primary focus-ring focus-ring-primary form-control mb-3" rows="3"></textarea>
                            <button class="btn btn-primary" type="button">Place Order</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>

</html>