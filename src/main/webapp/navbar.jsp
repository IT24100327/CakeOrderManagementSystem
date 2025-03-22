<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("ROLE");
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
                    <a class="nav-link active" aria-current="page" href="<%= request.getContextPath() %>/about">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="<%= request.getContextPath() %>/contact">Contact</a>
                </li>

                <% if (username != null) { %>
                <li class="nav-item">
                    <a class="nav-link active" href="<%= request.getContextPath() %>/profile">Profile</a>
                </li>
                <% } %>

                <% if (role != null && role.equals("ADMIN")) { %>
                <li class="nav-item">
                    <a class="nav-link active" href="<%= request.getContextPath() %>/admin">Admin</a>
                </li>
                <% } %>
            </ul>

            <div class="d-flex ms-auto">
                <% if (username != null) { %>
                <button class="btn">
                    <a href="<%= request.getContextPath() %>/logout">Logout</a>
                </button>
                <% } else { %>
                <button class="btn">
                    <a href="<%= request.getContextPath() %>/signin">Sign In</a>
                </button>
                <button class="btn">
                    <a href="<%= request.getContextPath() %>/signup">Sign Up</a>
                </button>
                <% } %>
            </div>
        </div>
    </div>
</nav>
