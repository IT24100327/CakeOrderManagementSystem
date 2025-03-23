<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/signin.css" />
  </head>
  <body>
  <% String username = (String) session.getAttribute("username"); %>
  <%
      if (username != null) {
          response.sendRedirect(request.getContextPath() + "/");
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

    <div class="signin-wrap">
      <form class="signin-form" action="<%= request.getContextPath() %>/signin" method="post" enctype="multipart/form-data">
        <h1 class="form-title">Sign In</h1>

        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) { %>
        <div class="alert alert-danger" role="alert">
          <%= errorMessage %>
        </div>
        <% } %>

        <label class="form-label" for="username">Username</label>
        <input
          class="form-input"
          type="text"
          id="username"
          name="username"
          required
        />

        <label class="form-label" for="password">Password</label>
        <input
          class="form-input"
          type="password"
          id="password"
          name="password"

        />

        <a class="form-forgot" href="#">Forgot Password?</a>

        <button class="form-button" type="submit">Sign In</button>

        <p class="form-signup">
          Don't have an account? <a class="form-link" href="#">Sign Up</a>
        </p>
      </form>
    </div>
  </body>
</html>
