<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/profile.css" />
</head>
<body>
<%@ include file="./navbar.jsp" %>

<%
    String fullName = (String) session.getAttribute("name");
    String email = (String) session.getAttribute("email");

    if (username == null) {
        response.sendRedirect(request.getContextPath() + "/signin");
        return;
    }
%>

<div class="profile-wrap">
    <h1 class="welcome-msg">Welcome, <%= fullName %> </h1>
    <hr />



    <div class="orders-wrap">
        <div class="orders-container">
            <h1>Your Orders</h1>
            <div class="orders">asds</div>
        </div>
    </div>
    <hr />
    <div class="reviews-wrap">
        <div class="reviews-container">
            <h1>Your Reviews</h1>
            <div class="reviews">asds</div>
        </div>
    </div>
    <hr />

    <div class="user-details-wrap">
        <div class="user-details">
            <!-- Error Display Block -->
            <%
                List<String> errors = (List<String>) request.getAttribute("errors");
                if (errors != null && !errors.isEmpty()) {
            %>
            <div class="alert alert-danger" role="alert">
                <ul>
                    <% for (String error : errors) { %>
                    <li><%= error %></li>
                    <% } %>
                </ul>
            </div>
            <% } %>
            <h1 class="text-center mb-4">Your Details</h1>

            <form action="<%= request.getContextPath() %>/updateprofile" method="POST" class="detailsform">
                <div class="mb-3">
                    <label for="newUsername" class="form-label">Username</label>
                    <input type="text" class="form-control" id="newUsername" name="newUsername" value="<%= username %>" required />
                </div>

                <div class="mb-3">
                    <label for="newFullName" class="form-label">Full Name</label>
                    <input type="text" class="form-control" name="newFullName" id="newFullName" value="<%= fullName %>" required />
                </div>

                <div class="mb-3">
                    <label for="newEmail" class="form-label">Email</label>
                    <input type="email" class="form-control" id="newEmail" name="newEmail" value="<%= email %>" required />
                </div>

                <div class="text-center">
                    <input type="submit" value="UPDATE DETAILS" class="btn btn-primary" />
                </div>
            </form>
        </div>
    </div>
    <hr />

    <div class="password-wrap">
        <div class="password-details">
            <div>
                <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger">
                    <%= request.getAttribute("errorMessage") %>
                </div>
                <% } %>

                <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert alert-success">
                    <%= request.getAttribute("successMessage") %>
                </div>
                <% } %>
            </div>
            <h1 class="text-center mb-4">Change Password</h1>
            <form action="<%= request.getContextPath() %>/updatepassword" method="POST" class="passwordform">
                <div class="mb-3">
                    <label for="oldPassword" class="form-label">Old Password</label>
                    <input type="password" class="form-control" id="oldPassword" name="oldPassword" required />
                </div>

                <div class="mb-3">
                    <label for="newPassword" class="form-label">New Password</label>
                    <input type="password" class="form-control" id="newPassword" name="newPassword" required />
                </div>

                <div class="mb-3">
                    <label for="confNewPassword" class="form-label">Confirm New Password</label>
                    <input type="password" class="form-control" id="confNewPassword" name="confNewPassword" required />
                </div>




                <div class="text-center">
                    <input type="submit" value="Change Password" class="btn btn-primary" />
                </div>
            </form>
        </div>
    </div>
    <div class="text-center">
        <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteModal">
            Delete Profile
        </button>
    </div>
</div>

<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Profile Deletion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Enter your password to confirm profile deletion:</p>
                <input type="password" id="passwordInput" class="form-control" placeholder="Enter password" />
                <p id="deleteError" class="text-danger mt-2"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="confirmDelete()">Delete</button>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmDelete() {
        const enteredPassword = document.getElementById("passwordInput").value;
        const user = "<%= session.getAttribute("username") %>";
        const xhttp = new XMLHttpRequest();
        const url = "<%= request.getContextPath() %>/deleteprofile";
        xhttp.open("POST", url, true);
        xhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhttp.onreadystatechange = function () {
            if (this.readyState === 4) {
                if (this.status === 200) {
                    window.location.href = "<%= request.getContextPath() %>/logout";
                } else if (this.status === 401) {
                    document.getElementById("deleteError").innerText = this.responseText;
                } else {
                    document.getElementById("deleteError").innerText = "An error occurred. Please try again.";
                }
            }
        };
        xhttp.send("username=" + encodeURIComponent(user) + "&password=" + encodeURIComponent(enteredPassword));
    }
</script>

</body>
</html>
