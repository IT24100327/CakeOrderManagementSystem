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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/signup.css" />
  </head>
  <body>
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
            <a class="nav-link active" aria-current="page" href="<%= request.getContextPath() %>/contact"
            >Contact</a
            >
          </li>
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="#"></a>
          </li>
        </ul>
        <div class="d-flex ms-auto">
          <button class="btn">
            <a href="<%= request.getContextPath() %>/signin">Sign In</a>
          </button>
          <button class="btn">
            <a href="<%= request.getContextPath() %>/signup">Sign Up</a>
          </button>
        </div>
      </div>
    </div>
  </nav>

    <div class="signup-wrap">
      <form class="signup-form" action="">
        <h1>Sign Up</h1>

        <label for="name">Name</label>
        <input type="text" id="name" name="name" required />

        <label for="username">Username</label>
        <input type="text" id="username" name="username" required />

        <label for="email">Email</label>
        <input type="email" id="email" name="email" required />

        <label for="password">Password</label>
        <input type="password" id="password" name="password" required />

        <label for="confirm-password">Confirm Password</label>
        <input
          type="password"
          id="confirm-password"
          name="confirm-password"
          required
        />

        <button type="submit">Sign Up</button>

        <p>Already have an account? <a href="#">Sign In</a></p>
      </form>
    </div>
  </body>
</html>
