<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Bakery Item</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .form-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            background-color: white;
        }
        .form-title {
            color: #6c757d;
            margin-bottom: 1.5rem;
            text-align: center;
            font-weight: 600;
        }
        .form-label {
            font-weight: 500;
            color: #495057;
        }
        .btn-submit {
            background-color: #28a745;
            border: none;
            padding: 0.5rem 1.5rem;
            transition: all 0.3s;
        }
        .btn-submit:hover {
            background-color: #218838;
        }
    </style>
</head>
<body class="bg-light">
<div class="container">
    <div class="form-container">
        <h2 class="form-title"><i class="bi bi-plus-circle"></i> Add New Bakery Item</h2>

        <form action="../processItem" method="post">
            <input type="hidden" name="action" value="place">

            <div class="mb-3">
                <label for="name" class="form-label">Item Name</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>

            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
            </div>

            <div class="mb-3">
                <label for="category" class="form-label">Category</label>
                <select class="form-select" id="category" name="category">
                    <option value="cakes" selected>Cakes</option>
                    <option value="pastries">Pastries</option>
                    <option value="cookies">Cookies</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="price" class="form-label">Price</label>
                <div class="input-group">
                    <span class="input-group-text">Rs. </span>
                    <input type="number" class="form-control" id="price" name="price" step="0.01" min="0" required>
                </div>
            </div>

            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-submit text-white">
                    <i class="bi bi-save"></i> Add Item
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>