<%@ page import="java.util.Queue" %>
<%@ page import="entities.Item" %>
<%@ page import="utils.OrderQueue" %>
<%@ page import="utils.ItemCatalog" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    ItemCatalog catalog = new ItemCatalog();
    catalog.loadFromFile();

    List<Item> items = catalog.getAllItems();
    ArrayList<Item> cakes = new ArrayList<>();
    ArrayList<Item> cookies = new ArrayList<>();
    ArrayList<Item> pastries = new ArrayList<>();

    for (Item item : items) {
        if(item.getCategory().equalsIgnoreCase("cakes")) {
            cakes.add(item);
        } else if(item.getCategory().equalsIgnoreCase("cookies")){
            cookies.add(item);
        } else if(item.getCategory().equalsIgnoreCase("pastries")){
            pastries.add(item);
        }
    }

%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Heavenly Bakery</title>

    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Abril%20Fatface.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Alex%20Brush.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Montserrat.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Raleway.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/bs-theme-overrides.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Banner-Heading-Image-images.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Navbar-Centered-Links-icons.css">
</head>

<body class="text-secondary" style="background: var(--bs-secondary);">

<%
String email = (String) session.getAttribute("email");
String ROLE = (String) session.getAttribute("ROLE");
String userId = (String) session.getAttribute("ID");
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
                        <a class="nav-link me-5" href="profile.jsp" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">PROFILE</a>
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

    <!-- Hero Section -->
    <div class="container">
        <section class="py-4 py-xl-5">
            <div class="container">
                <div class="row g-0">
                    <div class="col-xl-7">
                        <div class="text-white p-4 p-md-5">
                            <h1 class="display-1 me-0 pb-0 pe-5" style="font-size: 67px;font-family: 'Abril Fatface', serif;text-align: left;">
                                <strong><span style="color: rgb(136, 80, 48); background-color: rgba(255, 226, 187, 0);">Freshly Baked Delights, Made with Love!</span></strong>
                            </h1>
                            <p class="mb-4 mt-4" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);">
                                Indulge in the finest artisanal pastries, cakes, and cookies, crafted daily with the freshest ingredients. Every bite is a celebration of flavor and tradition.
                            </p>
                            <div class="my-3">
                                <a class="btn btn-primary border-0 shadow-none me-2 mt-5 pt-3 pb-3 pe-5 ps-5" role="button" href="#cakes" style="font-family: Raleway, sans-serif;font-size: 14px;border-radius: 0px;">Explore Our Menu</a>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <img class="img-fluid d-flex w-100 h-100 fit-cover ms-xl-0" src="assets/img/7495417.png" width="800" height="658">
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Customer Reviews Section -->
    <div class="container-fluid py-4 py-xl-5 mt-5" style="background: var(--bs-primary);">
        <div class="row mb-5">
            <div class="col-md-8 col-xl-6 col-xxl-10 text-center mx-auto">
                <h2 style="font-family: 'Abril Fatface', serif;font-size: 72px;">What Our Customers Are Saying!</h2>
                <p style="font-family: Montserrat, sans-serif;">Don’t just take our word for it—here’s what our happy customers have to say about their experience with us.</p>
            </div>
        </div>
        <div class="row gy-4 row-cols-1 row-cols-sm-2 row-cols-lg-3">
            <!-- Review 1 -->
            <div class="col">
                <div>
                    <p class="bg-body-tertiary border rounded border-0 p-4" style="color: var(--bs-primary);font-family: Montserrat, sans-serif;">Nisi sit justo faucibus nec ornare amet, tortor torquent. Blandit class dapibus, aliquet morbi.</p>
                    <div class="d-flex">
                        <img class="rounded-circle flex-shrink-0 me-3 fit-cover" width="50" height="50" src="https://cdn.bootstrapstudio.io/placeholders/1400x800.png">
                        <div>
                            <p class="fw-bold text-primary mb-0" style="font-family: Raleway, sans-serif;"><span style="color: rgba(255, 226, 187, 0.86);">John Smith</span></p>
                            <p class="text-muted mb-0" style="font-family: Montserrat, sans-serif;"><span style="color: rgb(255, 226, 187);">Erat netus</span></p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Review 2 -->
            <div class="col">
                <div>
                    <p class="bg-body-tertiary border rounded border-0 p-4" style="color: var(--bs-primary);font-family: Montserrat, sans-serif;">Nisi sit justo faucibus nec ornare amet, tortor torquent. Blandit class dapibus, aliquet morbi.</p>
                    <div class="d-flex">
                        <img class="rounded-circle flex-shrink-0 me-3 fit-cover" width="50" height="50" src="https://cdn.bootstrapstudio.io/placeholders/1400x800.png">
                        <div>
                            <p class="fw-bold text-primary mb-0" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;"><span style="color: rgb(255, 226, 187);">John Smith</span></p>
                            <p class="text-muted mb-0" style="font-family: Montserrat, sans-serif;"><span style="color: rgb(255, 226, 187);">Erat netus</span></p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Review 3 -->
            <div class="col">
                <div>
                    <p class="bg-body-tertiary border rounded border-0 p-4" style="color: var(--bs-primary);font-family: Montserrat, sans-serif;">Nisi sit justo faucibus nec ornare amet, tortor torquent. Blandit class dapibus, aliquet morbi.</p>
                    <div class="d-flex">
                        <img class="rounded-circle flex-shrink-0 me-3 fit-cover" width="50" height="50" src="https://cdn.bootstrapstudio.io/placeholders/1400x800.png">
                        <div>
                            <p class="fw-bold text-primary mb-0"><span style="color: rgb(255, 226, 187);">John Smith</span></p>
                            <p class="text-muted mb-0"><span style="color: rgb(255, 226, 187);">Erat netus</span></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<!-- Cakes Section -->

<div class="container" id = "cakes">
    <h6 class="display-2 mt-5 mb-2" style="font-family: 'Abril Fatface', serif;font-size: 62px;"><span style="color: rgb(136, 80, 48);">Cakes That Make Every Occasion Special!</span></h6>
    <p style="font-family: Montserrat, sans-serif;" class="mb-xl-5"><span style="color: rgb(136, 80, 48);">From classic vanilla sponges to rich chocolate decadence, our cakes are baked to perfection. Whether it’s a birthday, anniversary, or just a Tuesday, we’ve got the perfect cake for you.</span></p>
    <div class="row gx-3 gy-3 d-flex flex-column flex-wrap flex-sm-column flex-md-row flex-lg-row flex-xl-row flex-xxl-row">

        <% for (Item item : cakes) { %>

        <div class="col d-flex">
            <div class="card border rounded-0" style="min-height: 600px;">
                <img class="card-img-top w-100 d-block" src="assets/img/clipboard-image.png" />
                <div class="card-body">
                    <h4 class="card-title" style="font-family: 'Abril Fatface', serif; color: var(--bs-primary);"><%=item.getName()%></h4>
                    <p class="card-text" style="font-family: Montserrat, sans-serif; color: var(--bs-primary);"><%=item.getDescription()%>></p>
                    <p class="price">Rs. <%= String.format("%.2f", item.getPrice()) %></p>
                </div>
                <button class="btn btn-primary border rounded-0" type="button" data-bs-toggle="modal" data-bs-target="#<%= item.getItemId() %>">Order Now</button>

                <!-- Modal -->
                <div id="<%= item.getItemId() %>" class="modal fade" role="dialog" tabindex="-1">
                    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header mb-0 pb-0" style="border-top-left-radius: 0px; border-top-right-radius: 0px; border-right-style: none; border-bottom-style: none;">
                                <button class="btn-close" type="button" aria-label="Close" data-bs-dismiss="modal" style="border-right-style: none;"></button>
                            </div>
                            <div class="modal-body p-4" style="border-right-style: none;">
                                <div class="row align-items-center">
                                    <div class="col-md-5 text-center">
                                        <img class="img-fluid rounded" src="assets/img/clipboard-image.png" alt="Chocolate Ganache Cake" style="max-width: 100%; height: auto;">
                                    </div>
                                    <div class="col-md-7">
                                        <h1 class="display-4" style="font-family: 'Abril Fatface', serif; color: var(--bs-primary);"><%=item.getName()%></h1>
                                        <p class="lead" style="color: rgb(136, 80, 48);"><%=item.getDescription()%>></p>
                                        <p class="price">Rs. <%= String.format("%.2f", item.getPrice()) %></p>

                                        <form action="OrderServlet" method="POST">
                                            <input type="hidden" name="action" value="place">
                                            <input type="hidden" name="itemPrice" value="<%= item.getPrice() %>">
                                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                            <input type="hidden" name="userId" value=<%=userId%>>

                                            <div class="mb-3">
                                                <label for="quantity" class="form-label">Quantity:</label>
                                                <input type="number" class="form-control" id="quantity" name="quantity" min="1" value="1" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="deliveryDate" class="form-label">Delivery Date:</label>
                                                <%
                                                    // Set min date to tomorrow
                                                    LocalDate tomorrow = LocalDate.now().plusDays(1);
                                                    String tomorrowStr = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                                                %>
                                                <input type="date" class="form-control" id="deliveryDate" name="deliveryDate" min="<%= tomorrowStr %>" required>
                                            </div>

                                            <button class="btn btn-primary py-2 px-4 fw-bold" type="submit">Order Now</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <% } %>

    </div>
</div>

<!-- Custom Cakes Section -->
<section class="py-4 py-xl-5">
    <div class="container">
        <div class="text-white bg-primary border rounded border-0 border-primary d-flex flex-column justify-content-between flex-lg-row p-4 p-md-5 pb-xl-5">
            <div class="col-lg-8">
                <h1 style="font-family: 'Abril Fatface', serif;">Dream It, We’ll Bake It!</h1>
                <p style="font-family: Montserrat, sans-serif;">Celebrate life’s sweetest moments with a custom cake designed just for you. Whether it’s a birthday, wedding, or just because, we’ll bring your vision to life with delicious, handcrafted perfection.</p>
            </div>
            <div class="col d-lg-flex d-xl-flex d-xxl-flex justify-content-lg-center align-items-lg-center justify-content-xl-center align-items-xl-center justify-content-xxl-center align-items-xxl-center">
                <button class="btn btn-primary d-flex" type="button" style="background: var(--bs-secondary);color: var(--bs-primary);font-family: Raleway, sans-serif;font-weight: bold;font-size: 12px;padding: 12px 18px;">DESIGN YOUR CAKE</button>
            </div>
        </div>
    </div>
</section>

<!-- Pastries Section -->
<div class="container">
    <h6 class="display-2 pt-0 mt-5 pb-0 mb-2" style="font-family: 'Abril Fatface', serif;"><span style="color: rgb(136, 80, 48);">Flaky, Buttery, Irresistible Pastries</span></h6>
    <p style="font-family: Montserrat, sans-serif;color: var(--bs-primary);" class="mb-xl-5">Wake up to the aroma of freshly baked croissants, danishes, and muffins. Perfect with your morning coffee or as an afternoon treat.</p>
    <div class="row gx-3 gy-3 d-flex flex-column flex-wrap flex-sm-column flex-md-row flex-lg-row flex-xl-row flex-xxl-row">

        <% for (Item item : pastries) { %>

        <div class="col d-flex">
            <div class="card border rounded-0" style="min-height: 600px;">
                <img class="card-img-top w-100 d-block" src="assets/img/clipboard-image-4.png">
                <div class="card-body">
                    <h4 class="card-title" style="font-family: 'Abril Fatface', serif;color: var(--bs-primary);"><%=item.getName()%></h4>
                    <p class="card-text" style="color: var(--bs-primary);font-family: Montserrat, sans-serif;"><%=item.getDescription()%></p>
                    <p class="price">Rs. <%= String.format("%.2f", item.getPrice()) %></p>
                </div>
                <button class="btn btn-primary border rounded-0" type="button" data-bs-toggle="modal" data-bs-target="#<%= item.getItemId() %>">Order Now</button>

                <!-- Modal -->
                <div id="<%= item.getItemId() %>" class="modal fade" role="dialog" tabindex="-1">
                    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header mb-0 pb-0" style="border-top-left-radius: 0px; border-top-right-radius: 0px; border-right-style: none; border-bottom-style: none;">
                                <button class="btn-close" type="button" aria-label="Close" data-bs-dismiss="modal" style="border-right-style: none;"></button>
                            </div>
                            <div class="modal-body p-4" style="border-right-style: none;">
                                <div class="row align-items-center">
                                    <div class="col-md-5 text-center">
                                        <img class="img-fluid rounded" src="assets/img/clipboard-image-4.png" alt="Chicken Puffs" style="max-width: 100%; height: auto;">
                                    </div>
                                    <div class="col-md-7">
                                        <h1 class="display-4" style="font-family: 'Abril Fatface', serif; color: var(--bs-primary);"><%=item.getName()%></h1>
                                        <p class="lead" style="color: rgb(136, 80, 48);"><%=item.getDescription()%></p>
                                        <p class="price">Rs. <%= String.format("%.2f", item.getPrice()) %></p>


                                        <form action="OrderServlet" method="POST">
                                            <input type="hidden" name="action" value="place">
                                            <input type="hidden" name="itemPrice" value="<%= item.getPrice() %>">
                                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                            <input type="hidden" name="userId" value=<%=userId%>>

                                            <div class="mb-3">
                                                <label for="quantity" class="form-label">Quantity:</label>
                                                <input type="number" class="form-control" id="quantity" name="quantity" min="1" value="1" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="deliveryDate" class="form-label">Delivery Date:</label>
                                                <%
                                                    // Set min date to tomorrow
                                                    LocalDate tomorrow = LocalDate.now().plusDays(1);
                                                    String tomorrowStr = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                                                %>
                                                <input type="date" class="form-control" id="deliveryDate" name="deliveryDate" min="<%= tomorrowStr %>" required>
                                            </div>

                                            <button class="btn btn-primary py-2 px-4 fw-bold" type="submit">Order Now</button>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <% } %>

    </div>
</div>

<!-- Cookies Section -->
<div class="container">
    <h6 class="display-2 mt-5 mb-2" style="font-family: 'Abril Fatface', serif;color: var(--bs-primary);">Cookies That Bring Joy to Every Bite!</h6>
    <p style="color: var(--bs-primary);" class="mb-xl-5">Chewy, crunchy, or dipped in chocolate—our cookies are baked to perfection. Perfect for sharing (or not)!</p>
    <div class="row gx-3 gy-3 d-flex flex-column flex-wrap flex-sm-column flex-md-row flex-lg-row flex-xl-row flex-xxl-row">

        <% for (Item item : cookies) { %>

        <div class="col d-flex">
            <div class="card border rounded-0" style="min-height: 600px;">
                <img class="card-img-top w-100 d-block" src="assets/img/clipboard-image-9.png">
                <div class="card-body">
                    <h4 class="card-title" style="font-family: 'Abril Fatface', serif;color: var(--bs-primary);"><%=item.getName()%></h4>
                    <p class="card-text" style="font-family: Montserrat, sans-serif;color: var(--bs-primary);"><%=item.getDescription()%></p>
                    <p class="price">Rs. <%= String.format("%.2f", item.getPrice()) %></p>
                </div>
                <button class="btn btn-primary border rounded-0" type="button" data-bs-toggle="modal" data-bs-target="#<%= item.getItemId() %>">Order Now</button>

                <!-- Modal -->
                <div id="<%= item.getItemId() %>" class="modal fade" role="dialog" tabindex="-1">
                    <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header mb-0 pb-0" style="border-top-left-radius: 0px; border-top-right-radius: 0px; border-right-style: none; border-bottom-style: none;">
                                <button class="btn-close" type="button" aria-label="Close" data-bs-dismiss="modal" style="border-right-style: none;"></button>
                            </div>
                            <div class="modal-body p-4" style="border-right-style: none;">
                                <div class="row align-items-center">
                                    <div class="col-md-5 text-center">
                                        <img class="img-fluid rounded" src="assets/img/clipboard-image-9.png" alt="Chocolate Chip Cookies" style="max-width: 100%; height: auto;">
                                    </div>
                                    <div class="col-md-7">
                                        <h1 class="display-4" style="font-family: 'Abril Fatface', serif; color: var(--bs-primary);"><%=item.getName()%></h1>
                                        <p class="lead" style="color: rgb(136, 80, 48);"><%=item.getDescription()%></p>
                                        <p class="price">Rs. <%= String.format("%.2f", item.getPrice()) %></p>

                                        <form action="OrderServlet" method="POST">
                                            <input type="hidden" name="action" value="place">
                                            <input type="hidden" name="itemPrice" value="<%= item.getPrice() %>">
                                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                            <input type="hidden" name="userId" value=<%=userId%>>

                                            <div class="mb-3">
                                                <label for="quantity" class="form-label">Quantity:</label>
                                                <input type="number" class="form-control" id="quantity" name="quantity" min="1" value="1" required>
                                            </div>

                                            <div class="mb-3">
                                                <label for="deliveryDate" class="form-label">Delivery Date:</label>
                                                <%
                                                    // Set min date to tomorrow
                                                    LocalDate tomorrow = LocalDate.now().plusDays(1);
                                                    String tomorrowStr = tomorrow.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
                                                %>
                                                <input type="date" class="form-control" id="deliveryDate" name="deliveryDate" min="<%= tomorrowStr %>" required>
                                            </div>

                                            <button class="btn btn-primary py-2 px-4 fw-bold" type="submit">Order Now</button>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <% } %>

    </div>
</div>

    <!-- Footer Section -->
    <footer class="text-center">
        <div class="container text-muted py-4 py-lg-5">
            <section class="position-relative py-4 py-xl-5 mb-xl-5 pt-xl-5 pb-xl-5 mt-xl-5" style="background: var(--bs-primary);color: var(--bs-secondary);border-radius: 0px;">
                <div class="container position-relative">
                    <div class="row mb-5">
                        <div class="col-md-8 col-xl-6 col-xxl-8 text-center mx-auto pe-2">
                            <h2 style="font-family: 'Abril Fatface', serif;font-size: 72px;">Reviews &amp; Feedback</h2>
                            <p class="w-lg-50" style="font-family: Montserrat, sans-serif;">Have you tried our treats? Share your experience with us and let the world know how we’re doing!</p>
                        </div>
                    </div>
                    <div class="row d-flex justify-content-center">
                        <div class="col-md-6 col-lg-4 col-xl-4">
                            <div class="d-flex flex-column justify-content-center align-items-start h-100">
                                <div class="d-flex align-items-center p-3">
                                    <div class="bs-icon-md bs-icon-rounded bs-icon-primary d-flex flex-shrink-0 justify-content-center align-items-center d-inline-block bs-icon"><svg class="bi bi-telephone" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 16 16">
                                            <path d="M3.654 1.328a.678.678 0 0 0-1.015-.063L1.605 2.3c-.483.484-.661 1.169-.45 1.77a17.568 17.568 0 0 0 4.168 6.608 17.569 17.569 0 0 0 6.608 4.168c.601.211 1.286.033 1.77-.45l1.034-1.034a.678.678 0 0 0-.063-1.015l-2.307-1.794a.678.678 0 0 0-.58-.122l-2.19.547a1.745 1.745 0 0 1-1.657-.459L5.482 8.062a1.745 1.745 0 0 1-.46-1.657l.548-2.19a.678.678 0 0 0-.122-.58L3.654 1.328zM1.884.511a1.745 1.745 0 0 1 2.612.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.678.678 0 0 0 .178.643l2.457 2.457a.678.678 0 0 0 .644.178l2.189-.547a1.745 1.745 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.634 18.634 0 0 1-7.01-4.42 18.634 18.634 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877L1.885.511z"></path>
                                        </svg></div>
                                    <div class="px-2">
                                        <h6 class="mb-0" style="text-align: left;">Phone</h6>
                                        <p class="mb-0">+123456789</p>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center p-3">
                                    <div class="bs-icon-md bs-icon-rounded bs-icon-primary d-flex flex-shrink-0 justify-content-center align-items-center d-inline-block bs-icon"><svg class="bi bi-envelope" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 16 16">
                                            <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z"></path>
                                        </svg></div>
                                    <div class="px-2">
                                        <h6 class="mb-0" style="text-align: left;">Email</h6>
                                        <p class="mb-0">info@example.com</p>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center p-3">
                                    <div class="bs-icon-md bs-icon-rounded bs-icon-primary d-flex flex-shrink-0 justify-content-center align-items-center d-inline-block bs-icon"><svg class="bi bi-pin" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 16 16">
                                            <path d="M4.146.146A.5.5 0 0 1 4.5 0h7a.5.5 0 0 1 .5.5c0 .68-.342 1.174-.646 1.479-.126.125-.25.224-.354.298v4.431l.078.048c.203.127.476.314.751.555C12.36 7.775 13 8.527 13 9.5a.5.5 0 0 1-.5.5h-4v4.5c0 .276-.224 1.5-.5 1.5s-.5-1.224-.5-1.5V10h-4a.5.5 0 0 1-.5-.5c0-.973.64-1.725 1.17-2.189A5.921 5.921 0 0 1 5 6.708V2.277a2.77 2.77 0 0 1-.354-.298C4.342 1.674 4 1.179 4 .5a.5.5 0 0 1 .146-.354zm1.58 1.408-.002-.001.002.001m-.002-.001.002.001A.5.5 0 0 1 6 2v5a.5.5 0 0 1-.276.447h-.002l-.012.007-.054.03a4.922 4.922 0 0 0-.827.58c-.318.278-.585.596-.725.936h7.792c-.14-.34-.407-.658-.725-.936a4.915 4.915 0 0 0-.881-.61l-.012-.006h-.002A.5.5 0 0 1 10 7V2a.5.5 0 0 1 .295-.458 1.775 1.775 0 0 0 .351-.271c.08-.08.155-.17.214-.271H5.14c.06.1.133.191.214.271a1.78 1.78 0 0 0 .37.282"></path>
                                        </svg></div>
                                    <div class="px-2">
                                        <h6 class="mb-0" style="text-align: left;">Location</h6>
                                        <p class="mb-0">12 Example Street</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-5 col-xl-4">
                            <div>
                                <form class="p-3 p-xl-4" method="post">
                                    <div class="mb-3"><input id="name-1" class="form-control" type="text" name="name" placeholder="Name" /></div>
                                    <div class="mb-3"><input id="email-1" class="form-control" type="email" name="email" placeholder="Email" /></div>
                                    <div class="mb-3"><textarea id="message-1" class="form-control" name="message" rows="6" placeholder="Message"></textarea></div>
                                    <div><button class="btn btn-primary d-block w-100" type="submit" style="border-color: var(--bs-primary);background: var(--bs-secondary);color: var(--bs-primary);">Send </button></div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <ul class="list-inline mt-3">
                <li class="list-inline-item me-4"><svg class="bi bi-facebook" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 16 16">
                        <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951"></path>
                    </svg></li>
                <li class="list-inline-item me-4"><svg class="bi bi-twitter" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 16 16">
                        <path d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.14 0-.282-.006-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15"></path>
                    </svg></li>
                <li class="list-inline-item"><svg class="bi bi-instagram" xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 16 16">
                        <path d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.917 3.917 0 0 0-1.417.923A3.927 3.927 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.916 3.916 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.926 3.926 0 0 0-.923-1.417A3.911 3.911 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0h.003zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599.28.28.453.546.598.92.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.47 2.47 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.478 2.478 0 0 1-.92-.598 2.48 2.48 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233 0-2.136.008-2.388.046-3.231.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92.28-.28.546-.453.92-.598.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045v.002zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92zm-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217zm0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334"></path>
                    </svg></li>
            </ul>
            <p class="mb-0">Copyright © 2025 </p>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>

</html>