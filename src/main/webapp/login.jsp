<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <!-- Meta tags for character set and responsive design -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Login - Heavenly Bakery</title>

    <!-- External CSS files -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Abril%20Fatface.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Alex%20Brush.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Montserrat.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Raleway.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bs-theme-overrides.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Banner-Heading-Image-images.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Navbar-Centered-Links-icons.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Signup-page-with-overlay.css">
</head>

<body style="background: url('assets/img/pattern.svg') bottom / auto round;">

<% String email = (String) session.getAttribute("email"); %>
<%
    if (email != null) {
        response.sendRedirect(request.getContextPath() + "/");
        return;
    }
%>

    <!-- Login Section -->
    <section class="position-relative py-4 py-xl-5">
        <div class="container">
            <div class="row d-flex justify-content-center">
                <div class="col-md-6 col-xl-4" style="background: var(--bs-secondary);">
                    <div class="card d-flex align-items-xl-center mb-5 mb-xl-4 mt-xl-4" style="background: var(--bs-secondary);">
                        <div class="card-body d-flex flex-column align-items-center">
                            <!-- Login Heading -->
                            <h2 style="font-family: 'Abril Fatface', serif; color: var(--bs-primary); font-size: 62px;">Login</h2>
                            <p class="w-lg-50"></p>
                            <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                            <% if (errorMessage != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= errorMessage %>
                            </div>
                            <% } %>
                            <!-- Login Form -->
                            <form class="text-center" method="post" action="<%= request.getContextPath() %>/login" enctype="multipart/form-data">
                                <!-- Email Input -->
                                <div class="mb-3">
                                    <input class="form-control" type="email" name="email" placeholder="Email" style="font-family: Montserrat, sans-serif;" required>
                                </div>
                                <!-- Password Input -->
                                <div class="mb-3">
                                    <input class="form-control" type="password" name="password" placeholder="Password" style="font-family: Montserrat, sans-serif;" required>
                                </div>
                                <!-- Submit Button -->
                                <div class="mb-3">
                                    <button class="btn btn-primary d-block w-100" type="submit" style="font-family: Raleway, sans-serif;">Login</button>
                                </div>
                                <!-- Forgot Password Link -->
                                <p class="text-muted" style="font-family: Montserrat, sans-serif;">Forgot your password?</p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>

</html>