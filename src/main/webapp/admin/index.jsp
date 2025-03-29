<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Dashboard - Heavenly Bakery</title>
    <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/Abril%20Fatface.css">
    <link rel="stylesheet" href="../assets/css/Alex%20Brush.css">
    <link rel="stylesheet" href="../assets/css/Montserrat.css">
    <link rel="stylesheet" href="../assets/fonts/fontawesome-all.min.css">
    <style>
        :root {
            --bs-primary: #885030; /* Purple */
            --bs-secondary: #ffe2bb; /* Light gray */
        }
        
        body {
            background: var(--bs-primary);
            font-family: 'Montserrat', sans-serif;
        }
        
        .navbar-brand {
            font-family: 'Alex Brush', cursive;
            font-size: 2rem;
            color: var(--bs-primary) !important;
        }
        
        .nav-tabs {
            background: var(--bs-primary);
            border-bottom: none;
        }
        
        .nav-tabs .nav-link {
            font-family: 'Abril Fatface', serif;
            color: var(--bs-secondary);
            border: none;
            padding: 1rem 1.5rem;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }
        
        .nav-tabs .nav-link:hover {
            color: var(--bs-primary);
            background-color: var(--bs-secondary);
        }
        
        .nav-tabs .nav-link.active {
            color: var(--bs-primary);
            background-color: var(--bs-secondary);
            
        }
        
        .tab-content-container {
            background: var(--bs-secondary);
            border-radius: 0 0 8px 8px;
        }
        
        .dashboard-card {
            transition: transform 0.3s ease;
            border-left: 4px solid;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
        }
        
        .border-left-primary {
            border-left-color: var(--bs-primary) !important;
        }
        
        .border-left-success {
            border-left-color: #28a745 !important;
        }
        
        .border-left-info {
            border-left-color: #17a2b8 !important;
        }
        
        .border-left-warning {
            border-left-color: #ffc107 !important;
        }
        
        .card-icon {
            color: var(--bs-primary);
            opacity: 0.7;
        }
    </style>
</head>

<body id="page-top">
    <nav class="navbar navbar-expand-md py-3" style="background: var(--bs-secondary);">
        <div class="container">
            <a class="navbar-brand" href="#">Heavenly Bakery</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <button class="btn btn-primary" type="button">
                            <i class="fas fa-user me-1"></i> Login
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container py-4">
        <div class="row">
            <div class="col-12">
                <ul class="nav nav-tabs" id="dashboardTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <a class="nav-link active" id="dashboard-tab" data-bs-toggle="tab" href="#dashboard" role="tab" style="font-size: 28px;">Dashboard</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="orders-tab" data-bs-toggle="tab" href="#orders" role="tab" style="font-size: 28px;">Orders</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="items-tab" data-bs-toggle="tab" href="#items" role="tab" style="font-size: 28px;">Items</a>
                    </li>
                    <li class="nav-item" role="presentation">
                        <a class="nav-link" id="reviews-tab" data-bs-toggle="tab" href="#reviews" role="tab" style="font-size: 28px;">Reviews</a>
                    </li>
                </ul>
                
                <div class="tab-content tab-content-container p-4" id="dashboardTabsContent">
                    <div class="tab-pane fade show active" id="dashboard" role="tabpanel">
                        <div class="row">
                            <div class="col-md-6 col-xl-3 mb-4">
                                <div class="card shadow border-left-primary py-2 dashboard-card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col me-2">
                                                <div class="text-uppercase text-primary fw-bold text-xs mb-1">Earnings (monthly)</div>
                                                <div class="text-dark fw-bold h5 mb-0">$40,000</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-xl-3 mb-4">
                                <div class="card shadow border-left-success py-2 dashboard-card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col me-2">
                                                <div class="text-uppercase text-success fw-bold text-xs mb-1">Earnings (annual)</div>
                                                <div class="text-dark fw-bold h5 mb-0">$215,000</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-xl-3 mb-4">
                                <div class="card shadow border-left-info py-2 dashboard-card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col me-2">
                                                <div class="text-uppercase text-info fw-bold text-xs mb-1">Tasks</div>
                                                <div class="row align-items-center g-0">
                                                    <div class="col-auto">
                                                        <div class="text-dark fw-bold h5 mb-0 me-3">50%</div>
                                                    </div>
                                                    <div class="col">
                                                        <div class="progress progress-sm">
                                                            <div class="progress-bar bg-info" style="width: 50%"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-xl-3 mb-4">
                                <div class="card shadow border-left-warning py-2 dashboard-card">
                                    <div class="card-body">
                                        <div class="row align-items-center">
                                            <div class="col me-2">
                                                <div class="text-uppercase text-warning fw-bold text-xs mb-1">Pending Requests</div>
                                                <div class="text-dark fw-bold h5 mb-0">18</div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-comments fa-2x text-gray-300"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="tab-pane fade" id="orders" role="tabpanel">
                        <h4 class="mb-4">Orders Management</h4>
                        <table class="table table-hover table-bordered">
                            <thead class="table-dark">
                                <tr>
                                    <th>Order ID</th>
                                    <th>Customer Name</th>
                                    <th>Status</th>
                                    <th>Total Amount</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>#1001</td>
                                    <td>John Doe</td>
                                    <td>Shipped</td>
                                    <td>$50.00</td>
                                    <td>2023-10-01</td>
                                </tr>
                                <tr>
                                    <td>#1002</td>
                                    <td>Jane Smith</td>
                                    <td>Processing</td>
                                    <td>$75.00</td>
                                    <td>2023-10-02</td>
                                </tr>
                                <!-- Add more orders as needed -->
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="tab-pane fade" id="items" role="tabpanel">
                        <h4 class="mb-4">Menu Items</h4>
                        <table class="table table-hover table-bordered">
                            <thead>
                                <tr>
                                    <th>Item Name</th>
                                    <th>Description</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Chocolate Cake</td>
                                    <td>Rich chocolate cake with ganache</td>
                                    <td>$25.00</td>
                                    <td>10</td>
                                </tr>
                                <tr>
                                    <td>Vanilla Cupcake</td>
                                    <td>Classic vanilla cupcake with buttercream frosting</td>
                                    <td>$3.00</td>
                                    <td>50</td>
                                </tr>
                                <!-- Add more items as needed -->
                            </tbody>
                        </table>
                        <p>Your bakery items content will go here.</p>
                    </div>
                    
                    <div class="tab-pane fade" id="reviews" role="tabpanel">
                        <h4 class="mb-4">Customer Reviews</h4>
                        <p>Your customer reviews content will go here.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="../assets/bootstrap/js/bootstrap.min.js"></script>
</body>

</html>