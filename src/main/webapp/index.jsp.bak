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
<%@ include file="./navbar.jsp" %>



<div
        class="w-100 d-flex justify-content-center align-items-center"
        style="background-color: aqua"
>
    <div id="carouselExample" class="carousel slide" data-bs-ride="carousel" style="width: 80%">
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
        <% for (int i = 1; i <= 8; i++) { %>
        <div class="col">
            <div class="card">
                <img src="<%= request.getContextPath() %>/images/image.png" class="card-img-top" alt="Image"/>
                <div class="card-body">
                    <h5 class="card-title">Card Title <%= i %></h5>
                    <p class="card-text">Some text about this card.</p>
                    <a href="#" class="btn btn-primary">More</a>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>
