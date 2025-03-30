<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/profile.css" />
</head>
<body>
<% String username = (String) session.getAttribute("username"); %>
<%
    if (username == null) {
        response.sendRedirect(request.getContextPath() + "/signin");
        return;
    }
%>
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

</body>
</html>
