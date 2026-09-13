<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.servlet.CarModel, com.servlet.CarSpecsModel" %>

<%
    CarModel      car      = (CarModel)      request.getAttribute("car");
    CarSpecsModel carSpecs = (CarSpecsModel) request.getAttribute("carSpecs");
    String        errorMsg = (String)        request.getAttribute("error");

    /* Display name: strip brand prefix from model_name */
    String modelDisplayName = "";
    if (car != null) {
        String mn    = (car.getModelName() != null ? car.getModelName() : "");
        String brand = (car.getBrand()     != null ? car.getBrand().trim() : "");
        mn = mn.trim();
        if (!brand.isEmpty() && mn.toLowerCase().startsWith(brand.toLowerCase())) {
            mn = mn.substring(brand.length()).trim();
        }
        modelDisplayName = mn;
    }

    /* Helper: show value or em-dash */
%>
<%! private String sv(String s) { return (s != null && !s.trim().isEmpty()) ? s.trim() : "—"; } %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= car != null ? modelDisplayName + " Specifications | CarVerse" : "Car Specifications | CarVerse" %></title>
    <meta name="description" content="Full technical specifications for the <%= modelDisplayName %>. Dimensions, engine, transmission, suspension, brakes and more.">
    <link rel="stylesheet" href="assets/css/carverse.css">
</head>

<body>

    <!-- =========================================================
         NAVIGATION
         ========================================================= -->

    <nav class="nav">
        <div class="shell">
            <a class="brand" href="index.jsp">CARVERSE</a>

            <div class="navlinks">
                <a href="index.jsp">Explore</a>
                <a class="active" href="<%= request.getContextPath() %>/car-search">New Cars</a>
                <a href="compare.jsp">Compare</a>
                <a href="index.jsp#ownership">Ownership</a>
            </div>

            <%
                String userName = (String) session.getAttribute("USERNAME");
                String userId   = (String) session.getAttribute("USERID");
                if (userName == null || userId == null) {
            %>
                <a class="btn btn-outline" href="login.html">Sign in</a>
                <a class="btn btn-primary" href="user_registration.html">Sign up →</a>
            <% } else { %>
                <a class="user-name" href="view_profile">Welcome, <%= userName %></a>
            <% } %>
        </div>
    </nav>

    <% if (errorMsg != null) { %>

        <main class="specs-page">
            <div class="shell">
                <div class="detail-section" style="text-align:center;padding:60px 28px;">
                    <h2>Something went wrong</h2>
                    <p style="color:var(--muted);margin:12px 0 24px;"><%= errorMsg %></p>
                    <a class="btn btn-primary" href="<%= request.getContextPath() %>/car-search">← Back to search</a>
                </div>
            </div>
        </main>

    <% } else if (car != null) { %>

    <!-- =========================================================
         SPECS PAGE
         ========================================================= -->

    <main class="specs-page">
        <div class="shell">

            <!-- Breadcrumbs -->
            <div class="breadcrumbs">
                <a href="index.jsp">Home</a>
                <span>/</span>
                <a href="<%= request.getContextPath() %>/car-search">New cars</a>
                <span>/</span>
                <a href="<%= request.getContextPath() %>/car-details?carId=<%= car.getCarId() %>"><%= modelDisplayName %></a>
                <span>/</span>
                Specifications
            </div>

            <!-- Page header -->
            <div class="specs-hero">
                <div>
                    <span class="tag"><%= sv(car.getBodyType()) %><% if (car.getFuelTypes() != null && !car.getFuelTypes().trim().isEmpty()) { %> · <%= car.getFuelTypes() %><% } %></span>
                    <h1><%= modelDisplayName %> — Full Specifications</h1>
                    <p class="specs-hero-sub">Complete technical data for the <%= car.getBrand() != null ? car.getBrand() : "" %> <%= modelDisplayName %></p>
                </div>
                <a class="btn btn-outline" href="<%= request.getContextPath() %>/car-details?carId=<%= car.getCarId() %>">← Back to overview</a>
            </div>

            <% if (carSpecs == null) { %>
                <div class="specs-no-data">
                    <span>📋</span>
                    <p>Detailed specifications are not yet available for this model.</p>
                    <a class="btn btn-primary" href="<%= request.getContextPath() %>/car-details?carId=<%= car.getCarId() %>">Back to car details</a>
                </div>
            <% } else { %>

            <!-- Specs grid of section cards -->
            <div class="specs-grid">

                <!-- ── Dimensions ── -->
                <div class="specs-section-card">
                    <div class="specs-section-header">
                        <span class="specs-section-icon">📐</span>
                        <h2>Dimensions</h2>
                    </div>
                    <table class="specs-table">
                        <tbody>
                            <tr><th>Length</th><td><%= sv(carSpecs.getLength()) %></td></tr>
                            <tr><th>Width</th><td><%= sv(carSpecs.getWidth()) %></td></tr>
                            <tr><th>Height</th><td><%= sv(carSpecs.getHeight()) %></td></tr>
                            <tr><th>Wheelbase</th><td><%= sv(carSpecs.getWheelbase()) %></td></tr>
                        </tbody>
                    </table>
                </div>

                <!-- ── Engine & Performance ── -->
                <div class="specs-section-card">
                    <div class="specs-section-header">
                        <span class="specs-section-icon">⚙️</span>
                        <h2>Engine &amp; Performance</h2>
                    </div>
                    <table class="specs-table">
                        <tbody>
                            <tr><th>Engine Type</th><td><%= sv(carSpecs.getEngineType()) %></td></tr>
                            <tr><th>Displacement</th><td><%= sv(carSpecs.getDisplacement()) %></td></tr>
                            <tr><th>Motor Type</th><td><%= sv(carSpecs.getMotorType()) %></td></tr>
                            <tr><th>Max Power</th><td><%= sv(carSpecs.getMaxPower()) %></td></tr>
                            <tr><th>Max Torque</th><td><%= sv(carSpecs.getMaxTorque()) %></td></tr>
                            <tr><th>No. of Cylinders</th><td><%= sv(carSpecs.getNoOfCylinders()) %></td></tr>
                            <tr><th>Valves per Cylinder</th><td><%= sv(carSpecs.getValvesPerCylinder()) %></td></tr>
                        </tbody>
                    </table>
                </div>

                <!-- ── Transmission ── -->
                <div class="specs-section-card">
                    <div class="specs-section-header">
                        <span class="specs-section-icon">🔧</span>
                        <h2>Transmission</h2>
                    </div>
                    <table class="specs-table">
                        <tbody>
                            <tr><th>Transmission Type</th><td><%= sv(carSpecs.getTransmissionType()) %></td></tr>
                            <tr><th>Gearbox</th><td><%= sv(carSpecs.getGearbox()) %></td></tr>
                            <tr><th>Drive Type</th><td><%= sv(carSpecs.getDriveType()) %></td></tr>
                            <tr><th>Hybrid Type</th><td><%= sv(carSpecs.getHybridType()) %></td></tr>
                        </tbody>
                    </table>
                </div>

                <!-- ── Fuel & Efficiency ── -->
                <div class="specs-section-card">
                    <div class="specs-section-header">
                        <span class="specs-section-icon">⛽</span>
                        <h2>Fuel &amp; Efficiency</h2>
                    </div>
                    <table class="specs-table">
                        <tbody>
                            <tr><th>Fuel Type</th><td><%= sv(carSpecs.getFuelType()) %></td></tr>
                            <tr><th>Mileage (ARAI)</th><td><%= sv(carSpecs.getPetrolMileageArai()) %></td></tr>
                            <tr><th>Fuel Tank Capacity</th><td><%= sv(carSpecs.getPetrolFuelTankCapacity()) %></td></tr>
                            <tr><th>Emission Norm</th><td><%= sv(carSpecs.getEmissionNormCompliance()) %></td></tr>
                        </tbody>
                    </table>
                </div>

                <!-- ── Electric / Battery ── -->
                <div class="specs-section-card">
                    <div class="specs-section-header">
                        <span class="specs-section-icon">⚡</span>
                        <h2>Electric &amp; Battery</h2>
                    </div>
                    <table class="specs-table">
                        <tbody>
                            <tr><th>Battery Type</th><td><%= sv(carSpecs.getBatteryType()) %></td></tr>
                            <tr><th>Regenerative Braking</th><td><%= sv(carSpecs.getRegenerativeBraking()) %></td></tr>
                            <tr><th>Wireless Charging</th><td><%= sv(carSpecs.getWirelessCharging()) %></td></tr>
                        </tbody>
                    </table>
                </div>

                <!-- ── Suspension & Steering ── -->
                <div class="specs-section-card">
                    <div class="specs-section-header">
                        <span class="specs-section-icon">🛞</span>
                        <h2>Suspension &amp; Steering</h2>
                    </div>
                    <table class="specs-table">
                        <tbody>
                            <tr><th>Front Suspension</th><td><%= sv(carSpecs.getFrontSuspension()) %></td></tr>
                            <tr><th>Rear Suspension</th><td><%= sv(carSpecs.getRearSuspension()) %></td></tr>
                            <tr><th>Steering Type</th><td><%= sv(carSpecs.getSteeringType()) %></td></tr>
                            <tr><th>Steering Column</th><td><%= sv(carSpecs.getSteeringColumn()) %></td></tr>
                            <tr><th>Steering Gear Type</th><td><%= sv(carSpecs.getSteeringGearType()) %></td></tr>
                            <tr><th>Turning Radius</th><td><%= sv(carSpecs.getTurningRadius()) %></td></tr>
                        </tbody>
                    </table>
                </div>

                <!-- ── Brakes ── -->
                <div class="specs-section-card">
                    <div class="specs-section-header">
                        <span class="specs-section-icon">🛑</span>
                        <h2>Brakes</h2>
                    </div>
                    <table class="specs-table">
                        <tbody>
                            <tr><th>Front Brake Type</th><td><%= sv(carSpecs.getFrontBrakeType()) %></td></tr>
                            <tr><th>Rear Brake Type</th><td><%= sv(carSpecs.getRearBrakeType()) %></td></tr>
                        </tbody>
                    </table>
                </div>

                <!-- ── General ── -->
                <div class="specs-section-card">
                    <div class="specs-section-header">
                        <span class="specs-section-icon">ℹ️</span>
                        <h2>General</h2>
                    </div>
                    <table class="specs-table">
                        <tbody>
                            <tr><th>Seating Capacity</th><td><%= sv(carSpecs.getSeatingCapacity()) %></td></tr>
                            <tr><th>Gross Weight</th><td><%= sv(carSpecs.getGrossWeight()) %></td></tr>
                        </tbody>
                    </table>
                    <% if (carSpecs.getSourceUrl() != null && !carSpecs.getSourceUrl().trim().isEmpty()) { %>
                        <div style="margin-top:16px;">
                            <a href="<%= carSpecs.getSourceUrl() %>" target="_blank" rel="noopener noreferrer" class="specs-source-link">
                                View official source →
                            </a>
                        </div>
                    <% } %>
                </div>

            </div><!-- /.specs-grid -->
            <% } %>

        </div><!-- /.shell -->
    </main>

    <% } %>

    <!-- =========================================================
         FOOTER
         ========================================================= -->

    <footer class="footer">
        <div class="shell">
            <div>
                <a class="brand" href="index.jsp">CARVERSE</a>
                <p>Drive your next decision with confidence.</p>
            </div>
            <div>Explore · Compare · Book · Maintenance · Support</div>
            <div>© 2026 CarVerse</div>
        </div>
    </footer>

    <div class="toast"></div>
    <script src="assets/js/carverse.js"></script>

</body>
</html>
