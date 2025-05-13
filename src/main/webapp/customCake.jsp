<!DOCTYPE html>
<html data-bs-theme="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Heavenly Bakery - Custom Cake Order</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">

    <!--  Change to local fonts Later -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Abril+Fatface&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Alex+Brush&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat&amp;display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway&amp;display=swap">
    <link rel="stylesheet" href="assets/css/bs-theme-overrides.css">
    <link rel="stylesheet" href="assets/css/Banner-Heading-Image-images.css">
    <link rel="stylesheet" href="assets/css/Navbar-Centered-Links-icons.css">
    <link rel="stylesheet" href="assets/css/Signup-page-with-overlay.css">
</head>

<body style="background: var(--bs-secondary);">
    <nav class="navbar navbar-expand-md bg-primary py-3 mb-5" style="background: var(--bs-secondary);color: var(--bs-primary);">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <span class="fs-5 fw-light text-start" style="color: var(--bs-secondary);font-family: 'Alex Brush', serif;font-size: 29px;">Heavenly Bakery</span>
            </a>
            <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navcol-3">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div id="navcol-3" class="collapse navbar-collapse">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item" style="font-size: 12px;text-align: center;">
                        <a class="nav-link active me-5" href="#" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-weight: bold;">HOME</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link me-5" href="#" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">ABOUT</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link me-5" href="#" style="color: var(--bs-secondary);font-family: Raleway, sans-serif;font-size: 12px;font-weight: bold;">CUSTOM CAKES</a>
                    </li>
                </ul>
                <button class="btn btn-secondary fw-light" type="button" style="font-family: Raleway, sans-serif;font-size: 12px;border-radius: 0px;">LOGIN</button>
            </div>
        </div>
    </nav>
    
    <div class="container-md focus-ring flex-column" style="background: rgba(255,226,187,0);">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-xl-6">
                <div class="row d-flex">
                    <div class="col mb-4 text-center"> <!-- Added text-center -->
                        <h1 style="font-family: 'Abril Fatface', serif;font-size: 62px;">
                            <span style="color: rgb(136, 80, 48);">Order a Custom Cake</span>
                        </h1>
                    </div>
                </div>
                
                <!-- JSP NOTE: This form will be converted to JSP form with action attribute -->
                <form method="post" action="/customcake">
                    <div class="row mb-5">
                        <div class="col">
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="form-label" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);font-size: 20px;">Occasion:</label>
                                    <select class="focus-ring focus-ring-primary form-select mb-3" name="occasion">
                                        <option value="Birthday" selected>Birthday</option>
                                        <option value="Wedding">Wedding</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);font-size: 20px;">Cake Flavor:</label>
                                    <select class="form-select mb-3" name="flavor">
                                        <option value="Chocolate" selected>Chocolate</option>
                                        <option value="Vanilla">Vanilla</option>
                                        <option value="Strawberry">Strawberry</option>
                                        <option value="Red-velvet">Red Velvet</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="form-label" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);font-size: 20px;">Filling/Topping:</label>
                                    <select class="form-select mb-3" name="filling">
                                        <option value="Buttercream" selected>Buttercream</option>
                                        <option value="Ganache">Ganache</option>
                                        <option value="Fruit">Fruit</option>
                                        <option value="None">None</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);font-size: 20px;">Cake Size:</label>
                                    <select class="form-select mb-3" name="size">
                                        <option value="Small" selected>Small (h:6",w:500g)</option>
                                        <option value="Medium">Medium (h:12",w:1kg)</option>
                                        <option value="Large">Large (h:18",w:1.5kg)</option>
                                        <option value="Extra-large">Extra Large (h:24",w:2kg)</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="form-label" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);font-size: 20px;">Cake Shape:</label>
                                    <select class="form-select mb-3" name="shape">
                                        <option value="Round" selected>Round</option>
                                        <option value="Square">Square</option>
                                        <option value="Heart">Heart</option>
                                        <option value="Custom">Custom</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);font-size: 20px;">Delivery Date:</label>
                                    <input
                                        type="date"
                                        id="start"
                                        name="deliveryDate"/>
                                </div>
                                <div class="col-md-6">
                                    <!-- JSP NOTE: Can add additional fields here if needed -->
                                </div>
                            </div>
                            <label class="form-label" style="font-family: Montserrat, sans-serif;font-weight: bold;color: var(--bs-primary);font-size: 20px;">Special Instructions:</label>
                            <textarea class="border-primary focus-ring focus-ring-primary form-control mb-3" rows="3" name="instructions"></textarea>
                            
                            <!-- JSP NOTE: Button type will be changed to submit for form processing -->
                            <div class="text-center">
                                <button class="btn btn-primary" type="submit">Place Order</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>

</html>