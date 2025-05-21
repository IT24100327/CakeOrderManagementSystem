<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entities.Item" %>
<%@ page import="java.util.List" %>
<%@ page import="utils.ItemCatalog" %>

<%
    ItemCatalog.loadFromFile();
    List<Item> items = ItemCatalog.getAllItems();
%>

<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Item Management - Heavenly Bakery</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Abril%20Fatface.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Alex%20Brush.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/Montserrat.css">
    <style>
        :root {
            --bs-primary: #885030;
            --bs-secondary: #ffe2bb;
            --bs-light: #f8f9fa;
            --bs-dark: #212529;
            --sidebar-width: 280px;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f5f5f5;
            overflow-x: hidden;
        }

        /* Sidebar styles */
        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            background: var(--bs-primary);
            color: white;
            z-index: 1000;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
        }

        .sidebar-brand {
            padding: 1.5rem;
            font-family: 'Alex Brush', cursive;
            font-size: 2rem;
            color: var(--bs-secondary);
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-nav {
            padding: 0;
            list-style: none;
        }

        .sidebar-nav-item {
            position: relative;
        }

        .sidebar-nav-link {
            display: flex;
            align-items: center;
            padding: 1rem 1.5rem;
            color: var(--bs-secondary);
            text-decoration: none;
            transition: all 0.3s;
        }

        .sidebar-nav-link:hover, .sidebar-nav-link.active {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .sidebar-nav-link i {
            margin-right: 0.75rem;
            font-size: 1.1rem;
        }

        /* Main content area */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 20px;
            min-height: 100vh;
            transition: all 0.3s;
        }

        /* Navbar styles */
        .top-navbar {
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 1rem 1.5rem;
            position: sticky;
            top: 0;
            z-index: 999;
        }

        /* Card styles */
        .dashboard-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 20px;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        /* Table styles */
        .table {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .table thead th {
            background-color: var(--bs-primary);
            color: white;
            border: none;
        }

        /* Button styles */
        .btn-primary {
            background-color: var(--bs-primary);
            border-color: var(--bs-primary);
        }

        .btn-primary:hover {
            background-color: #6a3d24;
            border-color: #6a3d24;
        }

        /* Modal styles */
        .modal-header {
            background-color: var(--bs-primary);
            color: white;
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .main-content, .top-navbar {
                margin-left: 0;
            }
        }

        /* Custom scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }
        ::-webkit-scrollbar-thumb {
            background: var(--bs-primary);
            border-radius: 4px;
        }

        /* Badge for categories */
        .badge-category {
            background-color: #e9ecef;
            color: #495057;
            font-weight: normal;
        }
    </style>
</head>

<body>

<div class="sidebar">
    <div class="sidebar-brand">Heavenly Bakery</div>
    <ul class="sidebar-nav">
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/index.jsp" class="sidebar-nav-link">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/ManageOrders.jsp" class="sidebar-nav-link">
                <i class="fas fa-clipboard-list"></i> Orders
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/ManageCustomOrders.jsp" class="sidebar-nav-link" >
                <i class="fas fa-star"></i> Custom Orders
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/ManageItems.jsp" class="sidebar-nav-link active">
                <i class="fas fa-bread-slice"></i> Items
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/ManagePayments.jsp" class="sidebar-nav-link" >
                <i class="fas fa-credit-card"></i> Payments
            </a>
        </li>
        <li class="sidebar-nav-item">
            <a href="<%=request.getContextPath()%>/admin/ManageReviews.jsp" class="sidebar-nav-link">
                <i class="fas fa-comment-alt"></i> Reviews
            </a>
        </li>
    </ul>
</div>


<div class="main-content">
    
    <nav class="top-navbar navbar navbar-expand-lg navbar-light bg-white shadow-sm mb-4">
        <div class="container-fluid">
            <button class="navbar-toggler d-lg-none" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
                <i class="fas fa-bars"></i>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <div class="d-flex justify-content-between w-100 align-items-center">
                    <span class="d-none d-sm-inline">Welcome, Admin</span>
                    <div>
                        <a href="<%= request.getContextPath() %>/logout" class="btn btn-outline-danger">
                            <i class="fas fa-sign-out-alt me-1"></i> Logout
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Content -->
    <div class="container-fluid">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4>Item Management</h4>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addItemModal">
                <i class="fas fa-plus me-2"></i>Add New Item
            </button>
        </div>

        <div class="card dashboard-card">
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>Item ID</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (Item item : items) { %>
                        <tr>
                            <td><%= item.getItemId() %></td>
                            <td><%= item.getName() %></td>
                            <td class="text-truncate" style="max-width: 200px;"><%= item.getDescription() %></td>
                            <td>
                                <span class="badge badge-category"><%= item.getCategory() %></span>
                            </td>
                            <td>Rs. <%= item.getPrice() %></td>
                            <td>
                                <div class="btn-group" role="group">
                                    <button type="button" class="btn btn-outline-primary btn-sm me-2"
                                            data-bs-toggle="modal" data-bs-target="#editItemModal"
                                            data-item-id="<%= item.getItemId() %>"
                                            data-item-name="<%= item.getName() %>"
                                            data-item-description="<%= item.getDescription() %>"
                                            data-item-category="<%= item.getCategory() %>"
                                            data-item-price="<%= item.getPrice() %>">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <form action="<%= request.getContextPath() %>/processItem" method="POST">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                        <button type="submit" class="btn btn-outline-danger btn-sm">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Item Modal -->
<div class="modal fade" id="addItemModal" tabindex="-1" aria-labelledby="addItemModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addItemModalLabel"><i class="fas fa-plus-circle me-2"></i>Add New Item</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%= request.getContextPath() %>/processItem" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" value="place">

                    <div class="mb-3">
                        <label for="addName" class="form-label">Item Name</label>
                        <input type="text" class="form-control" id="addName" name="name" required>
                    </div>

                    <div class="mb-3">
                        <label for="addDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="addDescription" name="description" rows="3"></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="addCategory" class="form-label">Category</label>
                        <select class="form-select" id="addCategory" name="category">
                            <option value="cakes" selected>Cakes</option>
                            <option value="pastries">Pastries</option>
                            <option value="cookies">Cookies</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="addPrice" class="form-label">Price</label>
                        <div class="input-group">
                            <span class="input-group-text">Rs. </span>
                            <input type="number" class="form-control" id="addPrice" name="price" step="0.01" min="0" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Save Item
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Item Modal -->
<div class="modal fade" id="editItemModal" tabindex="-1" aria-labelledby="editItemModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editItemModalLabel"><i class="fas fa-edit me-2"></i>Edit Item</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%= request.getContextPath() %>/processItem" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" id="editItemId" name="itemId">

                    <div class="mb-3">
                        <label for="editName" class="form-label">Item Name</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>

                    <div class="mb-3">
                        <label for="editDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="editDescription" name="description" rows="3"></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="editCategory" class="form-label">Category</label>
                        <select class="form-select" id="editCategory" name="category">
                            <option value="cakes">Cakes</option>
                            <option value="pastries">Pastries</option>
                            <option value="cookies">Cookies</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="editPrice" class="form-label">Price</label>
                        <div class="input-group">
                            <span class="input-group-text">Rs. </span>
                            <input type="number" class="form-control" id="editPrice" name="price" step="0.01" min="0" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Update Item
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="<%= request.getContextPath() %>/assets/bootstrap/js/bootstrap.min.js"></script>
<script>
    // Toggle sidebar on mobile
    document.querySelector('.navbar-toggler').addEventListener('click', function() {
        document.querySelector('.sidebar').classList.toggle('active');
    });

    // Handle edit modal data
    document.getElementById('editItemModal').addEventListener('show.bs.modal', function(event) {
        var button = event.relatedTarget;
        var itemId = button.getAttribute('data-item-id');
        var itemName = button.getAttribute('data-item-name');
        var itemDescription = button.getAttribute('data-item-description');
        var itemCategory = button.getAttribute('data-item-category');
        var itemPrice = button.getAttribute('data-item-price');

        var modal = this;
        modal.querySelector('#editItemId').value = itemId;
        modal.querySelector('#editName').value = itemName;
        modal.querySelector('#editDescription').value = itemDescription;
        modal.querySelector('#editCategory').value = itemCategory;
        modal.querySelector('#editPrice').value = itemPrice;
    });

    // Clear add modal when closed
    document.getElementById('addItemModal').addEventListener('hidden.bs.modal', function() {
        this.querySelector('form').reset();
    });
</script>
</body>
</html>