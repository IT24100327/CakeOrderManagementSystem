<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Document</title>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
            crossorigin="anonymous"
    />
    <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"
    ></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/index.css"/>
</head>
<body>
<% String username = (String) session.getAttribute("username"); %>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%= request.getContextPath() %>">Navbar</a>
        <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav"
                aria-controls="navbarNav"
                aria-expanded="false"
                aria-label="Toggle navigation"
        >
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="<%= request.getContextPath() %>">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page"
                       href="<%= request.getContextPath() %>/about">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="<%= request.getContextPath() %>/contact"
                    >Contact</a
                    >
                </li>

                <% if (username != null) { %>

                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="<%= request.getContextPath() %>/profile">Profile</a>
                </li>
                <% } %>

            </ul>

            <div class="d-flex ms-auto">
            <% if (username != null) { %>
                <button class="btn">
                    <a href="<%= request.getContextPath() %>/logout">Logout</a>
                </button>
            <% } else {%>
                <button class="btn">
                    <a href="<%= request.getContextPath() %>/signin">Sign In</a>
                </button>
                <button class="btn">
                    <a href="<%= request.getContextPath() %>/signup">Sign Up</a>
                </button>
            <% }%>
            </div>

        </div>
    </div>
</nav>

<div
        class="w-100 d-flex justify-content-center align-items-center"
        style="background-color: aqua"
>
    <div
            id="carouselExample"
            class="carousel slide"
            data-bs-ride="carousel"
            style="width: 80%"
    >
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="<%= request.getContextPath() %>/images/image.png" class="d-block w-100" alt="First Slide"/>
            </div>
            <div class="carousel-item">
                <img src="<%= request.getContextPath() %>/images/image.png" class="d-block w-100" alt="Second Slide"/>
            </div>
            <div class="carousel-item">
                <img src="<%= request.getContextPath() %>/images/image.png" class="d-block w-100" alt="Third Slide"/>
            </div>
        </div>
        <button
                class="carousel-control-prev"
                type="button"
                data-bs-target="#carouselExample"
                data-bs-slide="prev"
        >
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button
                class="carousel-control-next"
                type="button"
                data-bs-target="#carouselExample"
                data-bs-slide="next"
        >
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</div>

<div class="container mt-4">
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
        <div class="col">
            <div class="card">
                <img src="<%= request.getContextPath() %>/images/image.png" class="card-img-top" alt="Image"/>
                <div class="card-body">
                    <h5 class="card-title">Card Title 1</h5>
                    <p class="card-text">Some text about this card.</p>
                    <a href="#" class="btn btn-primary">More</a>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="card">
                <img src="<%= request.getContextPath() %>/images/image.png" class="card-img-top" alt="Image"/>
                <div class="card-body">
                    <h5 class="card-title">Card Title 2</h5>
                    <p class="card-text">Some text about this card.</p>
                    <a href="#" class="btn btn-primary">More</a>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="card">
                <img src="<%= request.getContextPath() %>/images/image.png" class="card-img-top" alt="Image"/>
                <div class="card-body">
                    <h5 class="card-title">Card Title 3</h5>
                    <p class="card-text">Some text about this card.</p>
                    <a href="#" class="btn btn-primary">More</a>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="card">
                <img src="<%= request.getContextPath() %>/images/image.png" class="card-img-top" alt="Image"/>
                <div class="card-body">
                    <h5 class="card-title">Card Title 4</h5>
                    <p class="card-text">Some text about this card.</p>
                    <a href="#" class="btn btn-primary">More</a>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card">
                <img src="<%= request.getContextPath() %>/images/image.png" class="card-img-top" alt="Image"/>
                <div class="card-body">
                    <h5 class="card-title">Card Title 4</h5>
                    <p class="card-text">Some text about this card.</p>
                    <a href="#" class="btn btn-primary">More</a>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card">
                <img src="<%= request.getContextPath() %>/images/image.png" class="card-img-top" alt="Image"/>
                <div class="card-body">
                    <h5 class="card-title">Card Title 4</h5>
                    <p class="card-text">Some text about this card.</p>
                    <a href="#" class="btn btn-primary">More</a>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card">
                <img src="<%= request.getContextPath() %>/images/image.png" class="card-img-top" alt="Image"/>
                <div class="card-body">
                    <h5 class="card-title">Card Title 4</h5>
                    <p class="card-text">Some text about this card.</p>
                    <a href="#" class="btn btn-primary">More</a>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card">
                <img src="<%= request.getContextPath() %>/images/image.png" class="card-img-top" alt="Image"/>
                <div class="card-body">
                    <h5 class="card-title">Card Title 4</h5>
                    <p class="card-text">Some text about this card.</p>
                    <a href="#" class="btn btn-primary">More</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
