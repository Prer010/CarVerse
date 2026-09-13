<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.util.*" %>
<%@ page import="com.servlet.CarModel" %>

<%
    /* ------------------------------------------------------------------ *
     * Database Connection Setup & Car Fetch
     * ------------------------------------------------------------------ */
    String dbUser = System.getenv("DB_USER");
    if (dbUser == null || dbUser.trim().isEmpty()) dbUser = "CARVERSE";
    String dbPass = System.getenv("DB_PASSWORD");
    if (dbPass == null || dbPass.trim().isEmpty()) dbPass = "manager";
    String dbUrl  = "jdbc:oracle:thin:@localhost:1521:XE";

    List<CarModel> allCars = new ArrayList<>();
    String dbError = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        try (Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass)) {
            String sql = "SELECT car_id, model_name, brand, body_type, price_range, "
                       + "fuel_types, mileage, engine, power, torque, "
                       + "seating_capacity, drive_type, safety_rating, "
                       + "length, width, height, boot_space, wheelbase, "
                       + "features, images, source_url "
                       + "FROM car_details ORDER BY brand ASC, model_name ASC";
            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CarModel c = new CarModel();
                    c.setCarId(rs.getInt("car_id"));
                    c.setModelName(rs.getString("model_name"));
                    c.setBrand(rs.getString("brand"));
                    c.setBodyType(rs.getString("body_type"));
                    c.setPriceRange(rs.getString("price_range"));
                    c.setFuelTypes(rs.getString("fuel_types"));
                    c.setMileage(rs.getString("mileage"));
                    c.setEngine(rs.getString("engine"));
                    c.setPower(rs.getString("power"));
                    c.setTorque(rs.getString("torque"));
                    c.setSeatingCapacity(rs.getString("seating_capacity"));
                    c.setDriveType(rs.getString("drive_type"));
                    c.setSafetyRating(rs.getString("safety_rating"));
                    c.setLength(rs.getString("length"));
                    c.setWidth(rs.getString("width"));
                    c.setHeight(rs.getString("height"));
                    c.setBootSpace(rs.getString("boot_space"));
                    c.setWheelbase(rs.getString("wheelbase"));
                    c.setFeatures(rs.getString("features"));
                    c.setImages(rs.getString("images"));
                    c.setSourceUrl(rs.getString("source_url"));
                    allCars.add(c);
                }
            }
        }
    } catch (Exception e) {
        dbError = e.getMessage();
    }

    /* Map of car by ID for quick lookup */
    Map<Integer, CarModel> carMap = new LinkedHashMap<>();
    Map<String, List<CarModel>> brandMap = new TreeMap<>();
    for (CarModel c : allCars) {
        carMap.put(c.getCarId(), c);
        String b = (c.getBrand() != null && !c.getBrand().trim().isEmpty()) ? c.getBrand().trim() : "Other";
        brandMap.computeIfAbsent(b, k -> new ArrayList<>()).add(c);
    }

    /* Read requested car slots from URL params */
    String c1 = request.getParameter("car1");
    String c2 = request.getParameter("car2");
    String c3 = request.getParameter("car3");
    String c4 = request.getParameter("car4");
    String singleCar = request.getParameter("carId");

    List<Integer> selectedIds = new ArrayList<>();
    if (singleCar != null && !singleCar.trim().isEmpty()) {
        try { selectedIds.add(Integer.parseInt(singleCar.trim())); } catch (NumberFormatException ignored) {}
    } else {
        for (String param : new String[]{c1, c2, c3, c4}) {
            if (param != null && !param.trim().isEmpty()) {
                try {
                    int cid = Integer.parseInt(param.trim());
                    if (carMap.containsKey(cid)) selectedIds.add(cid);
                } catch (NumberFormatException ignored) {}
            }
        }
    }

    /* Default to first 3 cars if none specified and DB has cars */
    if (selectedIds.isEmpty() && allCars.size() >= 2) {
        selectedIds.add(allCars.get(0).getCarId());
        selectedIds.add(allCars.get(1).getCarId());
        if (allCars.size() >= 3) selectedIds.add(allCars.get(2).getCarId());
    }
%>
<%! 
    private String val(String s) {
        return (s != null && !s.trim().isEmpty()) ? s.trim() : "—";
    }
    private String firstImg(String images) {
        if (images != null && !images.trim().isEmpty()) {
            String[] parts = images.split(",");
            if (parts.length > 0 && !parts[0].trim().isEmpty()) return parts[0].trim();
        }
        return "assets/images/car-placeholder.jpg";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>Compare Cars | CarVerse</title>
  <link rel="stylesheet" href="assets/css/carverse.css">
  <style>
    /* ── Compare Page Specific UI Styles ── */
    .compare-container {
      padding: 36px 0 70px;
    }

    .compare-hero {
      background: var(--deep);
      color: #fff;
      padding: 44px 0 40px;
    }
    .compare-hero h1 {
      font-size: 36px;
      letter-spacing: -1.2px;
      margin: 8px 0 6px;
    }
    .compare-hero h1 span {
      color: var(--green);
    }
    .compare-hero p {
      color: #aec5b5;
      font-size: 15px;
      margin: 0;
    }

    /* ── Compare Selection Panel (as per mockup image) ── */
    .compare-card-panel {
      background: #ffffff;
      border: 1px solid #e5e7eb;
      border-radius: 16px;
      padding: 32px 28px;
      margin-top: -30px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
    }

    .compare-slots-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 18px;
      margin-bottom: 28px;
    }

    .compare-slot {
      background: #ffffff;
      border: 1px solid #e5e7eb;
      border-radius: 12px;
      padding: 22px 16px 18px;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: space-between;
      min-height: 250px;
      position: relative;
      transition: border-color 0.2s, box-shadow 0.2s;
    }
    .compare-slot:hover {
      border-color: #cbd5e1;
      box-shadow: 0 4px 14px rgba(0, 0, 0, 0.04);
    }
    .compare-slot.has-car {
      border-color: #8bd024;
      background: #fafdf7;
    }

    /* Slot Top Graphic / Preview */
    .slot-preview {
      display: flex;
      flex-direction: row;
      align-items: center;
      justify-content: center;
      width: 100%;
      min-height: 120px;
      margin-bottom: 14px;
      cursor: pointer;
    }

    .slot-add-circle {
      width: 62px;
      height: 62px;
      border: 1.5px dashed #94a3b8;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 10px;
      color: #64748b;
      font-size: 26px;
      font-weight: 300;
      transition: all 0.2s;
    }
    .slot-preview:hover .slot-add-circle {
      border-color: #f05a28;
      color: #f05a28;
      transform: scale(1.06);
    }

    .slot-add-label {
      font-size: 13px;
      font-weight: 600;
      color: #64748b;
    }

    /* Filled slot graphic */
    .slot-img-wrap {
      width: 100%;
      height: 85px;
      border-radius: 8px;
      overflow: hidden;
      margin-bottom: 8px;
      background: #f1f5f9;
    }
    .slot-img-wrap img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .slot-car-title {
      font-size: 14px;
      font-weight: 800;
      color: var(--ink);
      text-align: center;
      line-height: 1.25;
      margin-bottom: 3px;
    }
    .slot-car-price {
      font-size: 12px;
      font-weight: 700;
      color: #15803d;
    }

    .slot-remove-btn {
      position: absolute;
      top: 8px;
      right: 8px;
      background: #fee2e2;
      color: #dc2626;
      border: none;
      width: 22px;
      height: 22px;
      border-radius: 50%;
      font-size: 13px;
      font-weight: bold;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: background 0.15s;
    }
    .slot-remove-btn:hover {
      background: #fca5a5;
      color: #991b1b;
    }

    /* Slot Dropdowns */
    .slot-controls {
      width: 100%;
      display: flex;
      flex-direction: column;
      gap: 8px;
    }

    .slot-select {
      width: 100%;
      border: 1px solid #e2e8f0;
      border-radius: 8px;
      padding: 9px 10px;
      font-size: 13px;
      font-weight: 600;
      color: #334155;
      background: #ffffff;
      outline: none;
      cursor: pointer;
      transition: border-color 0.18s;
    }
    .slot-select:focus {
      border-color: #f05a28;
    }

    /* ── Compare Now Button (orange CTA as in mockup) ── */
    .compare-btn-wrap {
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .btn-compare-now {
      background: #f05a28;
      color: #ffffff;
      border: none;
      border-radius: 8px;
      padding: 13px 44px;
      font-size: 15px;
      font-weight: 800;
      letter-spacing: 0.3px;
      cursor: pointer;
      box-shadow: 0 4px 14px rgba(240, 90, 40, 0.35);
      transition: background 0.2s, transform 0.15s, box-shadow 0.2s;
    }
    .btn-compare-now:hover {
      background: #dc4a1a;
      transform: translateY(-2px);
      box-shadow: 0 6px 18px rgba(240, 90, 40, 0.45);
    }
    .btn-compare-now:active {
      transform: translateY(0);
    }

    /* ── Comparison Specs Table ── */
    .compare-table-section {
      margin-top: 48px;
    }
    .compare-table-head {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      flex-wrap: wrap;
      gap: 12px;
    }
    .compare-table-head h2 {
      margin: 0;
      font-size: 24px;
      letter-spacing: -0.5px;
    }

    .diff-highlight {
      background: #fffbeb !important;
      font-weight: 700;
      color: #b45309;
    }

    .comp-spec-table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0 8px;
    }
    .comp-spec-table th,
    .comp-spec-table td {
      padding: 14px 16px;
      background: #fff;
      vertical-align: middle;
      font-size: 13px;
      border-top: 1px solid var(--line);
      border-bottom: 1px solid var(--line);
    }
    .comp-spec-table th {
      width: 22%;
      font-weight: 800;
      color: var(--muted);
      text-transform: uppercase;
      font-size: 11px;
      letter-spacing: 0.6px;
      border-left: 1px solid var(--line);
      border-radius: 8px 0 0 8px;
      background: #f8faf8;
    }
    .comp-spec-table td:last-child {
      border-right: 1px solid var(--line);
      border-radius: 0 8px 8px 0;
    }

    /* Category banner rows */
    .comp-spec-table tr.category-row th {
      background: #edf6eb;
      color: #15803d;
      font-size: 12px;
      font-weight: 900;
      letter-spacing: 0.8px;
      border-radius: 8px;
      border: 1px solid #cce7c7;
    }
    .comp-spec-table tr.category-row td {
      background: #edf6eb;
      border-top: 1px solid #cce7c7;
      border-bottom: 1px solid #cce7c7;
    }

    /* Car header column cards */
    .table-car-head {
      text-align: center;
      padding: 14px 8px;
    }
    .table-car-head img {
      width: 100%;
      max-height: 110px;
      object-fit: cover;
      border-radius: 8px;
      margin-bottom: 10px;
    }
    .table-car-head h3 {
      font-size: 16px;
      margin: 0 0 4px;
      font-weight: 800;
      color: var(--ink);
    }
    .table-car-head .price {
      font-size: 14px;
      font-weight: 800;
      color: var(--green);
      margin-bottom: 10px;
    }
    .table-car-head .car-actions {
      display: flex;
      gap: 6px;
      justify-content: center;
      flex-wrap: wrap;
    }

    .feature-chip-list {
      display: flex;
      flex-wrap: wrap;
      gap: 5px;
    }
    .feature-chip {
      background: #f0fdf4;
      border: 1px solid #bbf7d0;
      color: #166534;
      font-size: 11px;
      font-weight: 600;
      padding: 3px 8px;
      border-radius: 4px;
    }

    @media (max-width: 960px) {
      .compare-slots-grid {
        grid-template-columns: repeat(2, 1fr);
      }
    }
    @media (max-width: 600px) {
      .compare-slots-grid {
        grid-template-columns: 1fr;
      }
    }
  </style>
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
        <a href="car-search.jsp">New Cars</a>
        <a class="active" href="compare.jsp">Compare</a>
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

  <!-- =========================================================
       HERO
       ========================================================= -->
  <section class="compare-hero">
    <div class="shell">
      <div class="eyebrow">Car Comparison</div>
      <h1>Compare <span>Cars</span></h1>
      <p>Select up to 4 models to compare prices, performance, dimensions, and specifications.</p>
    </div>
  </section>

  <!-- =========================================================
       MAIN CONTENT
       ========================================================= -->
  <main class="compare-container">
    <div class="shell">

      <% if (dbError != null) { %>
        <div class="alert alert-error" style="background:#fee2e2;border:1px solid #f87171;padding:14px 18px;border-radius:8px;color:#991b1b;margin-bottom:20px;">
          Database notice: <%= dbError %>. Showing available features.
        </div>
      <% } %>

      <!-- ══ COMPARISON SELECTION PANEL (Mockup UI) ══════════════ -->
      <form id="compare-form" action="compare.jsp" method="get">
        <div class="compare-card-panel">
          
          <div class="compare-slots-grid">
            <%
              for (int slotIdx = 1; slotIdx <= 4; slotIdx++) {
                int selectedCarId = 0;
                if (selectedIds.size() >= slotIdx) {
                  selectedCarId = selectedIds.get(slotIdx - 1);
                }
                CarModel currentCar = carMap.get(selectedCarId);
                String isHasCar = (currentCar != null) ? "has-car" : "";
                String removeBtnStyle = (currentCar == null) ? "display:none;" : "";
                String emptyViewStyle = (currentCar != null) ? "display:none;" : "";
                String filledViewStyle = (currentCar == null) ? "display:none;" : "";
                String currentImg = (currentCar != null) ? firstImg(currentCar.getImages()) : "assets/images/car-placeholder.jpg";
                String currentTitle = (currentCar != null) ? currentCar.getModelName() : "";
                String currentPrice = (currentCar != null) ? ("₹ " + val(currentCar.getPriceRange())) : "";
            %>
            <div class="compare-slot <%= isHasCar %>" id="slot-card-<%= slotIdx %>" data-slot="<%= slotIdx %>">
              
              <!-- Remove button when car selected -->
              <button type="button" class="slot-remove-btn" id="remove-btn-<%= slotIdx %>"
                      style="<%= removeBtnStyle %>"
                      onclick="clearSlot(<%= slotIdx %>)" title="Remove car">×</button>

              <!-- Slot Preview / Placeholder -->
              <div class="slot-preview" onclick="focusSlotSelect(<%= slotIdx %>)">
                <!-- Empty Placeholder -->
                <div class="slot-empty-view" id="empty-view-<%= slotIdx %>" style="<%= emptyViewStyle %>">
                  <div class="slot-add-circle">+</div>
                  <div class="slot-add-label">Add car</div>
                </div>

                <!-- Filled Car View -->
                <div class="slot-filled-view" id="filled-view-<%= slotIdx %>" style="<%= filledViewStyle %>">
                  <div class="slot-img-wrap">
                    <img id="slot-img-<%= slotIdx %>"
                         src="<%= currentImg %>"
                         alt="<%= currentTitle %>">
                  </div>
                  <div class="slot-car-title" id="slot-title-<%= slotIdx %>">
                    <%= currentTitle %>
                  </div>
                  <div class="slot-car-price" id="slot-price-<%= slotIdx %>">
                    <%= currentPrice %>
                  </div>
                </div>
              </div>

              <!-- Dropdown Controls -->
              <div class="slot-controls">
                <!-- Brand / Model Select -->
                <select class="slot-select slot-car-select" name="car<%= slotIdx %>" id="car-select-<%= slotIdx %>" onchange="onCarSelectChange(<%= slotIdx %>)">
                  <option value="">Select Brand/Model</option>
                  <% for (Map.Entry<String, List<CarModel>> entry : brandMap.entrySet()) { %>
                    <optgroup label="<%= entry.getKey() %>">
                      <% for (CarModel cm : entry.getValue()) {
                           boolean isSelected = (cm.getCarId() == selectedCarId);
                      %>
                        <option value="<%= cm.getCarId() %>" <%= isSelected ? "selected" : "" %>>
                          <%= cm.getBrand() %> <%= cm.getModelName() %>
                        </option>
                      <% } %>
                    </optgroup>
                  <% } %>
                </select>

                <!-- Variant Select -->
                <select class="slot-select slot-variant-select" id="variant-select-<%= slotIdx %>">
                  <option value="">Select Variant</option>
                  <% if (currentCar != null) { %>
                    <option value="standard" selected>
                      <%= val(currentCar.getFuelTypes()) %> · <%= val(currentCar.getBodyType()) %>
                    </option>
                  <% } %>
                </select>
              </div>

            </div>
            <% } %>
          </div>

          <!-- Centered Orange "Compare Now" Button -->
          <div class="compare-btn-wrap">
            <button type="submit" class="btn btn-primary">Compare Now</button>
          </div>

        </div>
      </form>

      <!-- ══ COMPARISON TABLE SECTION ════════════════════════════ -->
      <%
        List<CarModel> activeCompareCars = new ArrayList<>();
        for (int cid : selectedIds) {
          if (carMap.containsKey(cid)) activeCompareCars.add(carMap.get(cid));
        }
      %>

      <% if (activeCompareCars.size() >= 2) { %>
      <section class="compare-table-section" id="comparison-results">
        
        <div class="compare-table-head">
          <div>
            <div class="eyebrow">Side-by-side breakdown</div>
            <h2>Key Specifications Comparison</h2>
          </div>
          <div style="display:flex;gap:10px;align-items:center;">
            <button type="button" class="btn btn-outline" id="highlight-diff-btn" onclick="toggleHighlightDiff()">
              Highlight differences
            </button>
          </div>
        </div>

        <div style="overflow-x:auto;">
          <table class="comp-spec-table" id="spec-comparison-table">
            
            <!-- Car Header Photos & CTAs -->
            <thead>
              <tr>
                <% for (CarModel car : activeCompareCars) { %>
                <td style="background:#fff;padding:18px 14px;">
                  <div class="table-car-head">
                    <img src="<%= firstImg(car.getImages()) %>" alt="<%= car.getModelName() %>">
                    <h3><%= car.getModelName() %></h3>
                    <div class="price">₹ <%= val(car.getPriceRange()) %><sup>*</sup></div>
                    <div class="car-actions">
                      <a class="btn btn-primary btn-sm" href="car-details?carId=<%= car.getCarId() %>">Details →</a>
                      <a class="btn btn-outline btn-sm" href="<%= request.getContextPath() %>/BookingDisplayServlet?carId=<%= car.getCarId() %>">Book</a>
                    </div>
                  </div>
                </td>
                <% } %>
              </tr>
            </thead>

            <tbody>
              
              <!-- ── CATEGORY: Pricing & Essentials ── -->
              <tr class="category-row">
                <th colspan="<%= activeCompareCars.size() + 1 %>">💰 Pricing & Essentials</th>
              </tr>
              <tr class="spec-row">
                <th>Ex-showroom Price</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td><strong>₹ <%= val(car.getPriceRange()) %></strong></td>
                <% } %>
              </tr>
              <tr class="spec-row">
                <th>Brand</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td><%= val(car.getBrand()) %></td>
                <% } %>
              </tr>
              <tr class="spec-row">
                <th>Body Type</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td><%= val(car.getBodyType()) %></td>
                <% } %>
              </tr>
              <tr class="spec-row">
                <th>Seating Capacity</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td><%= val(car.getSeatingCapacity()) %> Seater</td>
                <% } %>
              </tr>

              <!-- ── CATEGORY: Performance & Engine ── -->
              <tr class="category-row">
                <th colspan="<%= activeCompareCars.size() + 1 %>">⚡ Performance & Powertrain</th>
              </tr>
              <tr class="spec-row">
                <th>Fuel Type</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td><%= val(car.getFuelTypes()) %></td>
                <% } %>
              </tr>
              <tr class="spec-row">
                <th>Engine / Motor</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td><%= val(car.getEngine()) %></td>
                <% } %>
              </tr>
              <tr class="spec-row">
                <th>Max Power</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td><%= val(car.getPower()) %></td>
                <% } %>
              </tr>
              <tr class="spec-row">
                <th>Max Torque</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td><%= val(car.getTorque()) %></td>
                <% } %>
              </tr>
              <tr class="spec-row">
                <th>Mileage / Range</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td><strong><%= val(car.getMileage()) %></strong></td>
                <% } %>
              </tr>
              <tr class="spec-row">
                <th>Drive Type</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td><%= val(car.getDriveType()) %></td>
                <% } %>
              </tr>

              <!-- ── CATEGORY: Safety & Dimensions ── -->
              <tr class="category-row">
                <th colspan="<%= activeCompareCars.size() + 1 %>">📐 Dimensions & Safety</th>
              </tr>
              <tr class="spec-row">
                <th>Safety Rating</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td><strong><%= val(car.getSafetyRating()) %></strong></td>
                <% } %>
              </tr>
              <tr class="spec-row">
                <th>Dimensions (L × W × H)</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td>
                    <%= val(car.getLength()) %> × <%= val(car.getWidth()) %> × <%= val(car.getHeight()) %> mm
                  </td>
                <% } %>
              </tr>
              <tr class="spec-row">
                <th>Wheelbase</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td><%= val(car.getWheelbase()) %> mm</td>
                <% } %>
              </tr>
              <tr class="spec-row">
                <th>Boot Space</th>
                <% for (CarModel car : activeCompareCars) { %>
                  <td><%= val(car.getBootSpace()) %></td>
                <% } %>
              </tr>

              <!-- ── CATEGORY: Key Features ── -->
              <tr class="category-row">
                <th colspan="<%= activeCompareCars.size() + 1 %>">✨ Key Features</th>
              </tr>
              <tr class="spec-row">
                <th>On-Board Features</th>
                <% for (CarModel car : activeCompareCars) {
                     String feats = car.getFeatures();
                %>
                  <td>
                    <% if (feats != null && !feats.trim().isEmpty()) { %>
                      <div class="feature-chip-list">
                        <% for (String f : feats.split(",")) {
                             f = f.trim();
                             if (!f.isEmpty()) { %>
                          <span class="feature-chip"><%= f %></span>
                        <%   }
                           } %>
                      </div>
                    <% } else { %>
                      —
                    <% } %>
                  </td>
                <% } %>
              </tr>

            </tbody>
          </table>
        </div>

      </section>
      <% } else { %>
      <div class="empty-state" style="text-align:center;padding:56px 20px;background:#fff;border:1px solid #e5e7eb;border-radius:12px;margin-top:38px;">
        <div style="font-size:44px;margin-bottom:12px;">⚖️</div>
        <h3 style="font-size:20px;margin:0 0 8px;">Select at least 2 cars to compare</h3>
        <p style="color:var(--muted);font-size:14px;max-width:460px;margin:0 auto;">
          Choose models from the dropdown cards above and click <strong>Compare Now</strong> to view a full spec-by-spec comparison.
        </p>
      </div>
      <% } %>

      <!-- Book test drive banner -->
      <section class="flow" style="margin-top:48px;background:var(--mint);padding:36px;border-radius:14px;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:20px;">
        <div>
          <div class="eyebrow">Ready when you are</div>
          <h2 style="font-size:24px;margin:6px 0;">Book a test drive or reserve online.</h2>
          <p class="sub" style="margin:0;color:var(--muted);">Experience your top choice on the road with transparent pricing.</p>
        </div>
        <div>
          <a class="btn btn-primary" href="<%= request.getContextPath() %>/car-search">Browse all cars →</a>
        </div>
      </section>

    </div>
  </main>

  <!-- =========================================================
       FOOTER
       ========================================================= -->
  <footer class="footer">
    <div class="shell">
      <div>
        <a class="brand" href="index.jsp">CARVERSE</a>
      </div>
      <div>Explore · Compare · Book · Maintenance · Support</div>
      <div>© 2026 CarVerse</div>
    </div>
  </footer>

  <div class="toast"></div>

  <!-- =========================================================
       DYNAMIC CLIENT-SIDE SCRIPT FOR SLOTS & COMPARISON
       ========================================================= -->
  <script>
    /* Embedded car registry from database */
    var carsData = {
      <% for (int i = 0; i < allCars.size(); i++) {
           CarModel c = allCars.get(i);
      %>
      "<%= c.getCarId() %>": {
        id: "<%= c.getCarId() %>",
        name: "<%= c.getModelName() != null ? c.getModelName().replace("\"", "\\\"") : "" %>",
        brand: "<%= c.getBrand() != null ? c.getBrand().replace("\"", "\\\"") : "" %>",
        bodyType: "<%= c.getBodyType() != null ? c.getBodyType().replace("\"", "\\\"") : "" %>",
        price: "<%= c.getPriceRange() != null ? c.getPriceRange().replace("\"", "\\\"") : "" %>",
        fuel: "<%= c.getFuelTypes() != null ? c.getFuelTypes().replace("\"", "\\\"") : "" %>",
        image: "<%= firstImg(c.getImages()) %>"
      }<%= i < allCars.size() - 1 ? "," : "" %>
      <% } %>
    };

    function focusSlotSelect(slotIdx) {
      var select = document.getElementById('car-select-' + slotIdx);
      if (select) select.focus();
    }

    function onCarSelectChange(slotIdx) {
      var select = document.getElementById('car-select-' + slotIdx);
      var variantSelect = document.getElementById('variant-select-' + slotIdx);
      var card = document.getElementById('slot-card-' + slotIdx);
      var removeBtn = document.getElementById('remove-btn-' + slotIdx);
      var emptyView = document.getElementById('empty-view-' + slotIdx);
      var filledView = document.getElementById('filled-view-' + slotIdx);
      var img = document.getElementById('slot-img-' + slotIdx);
      var title = document.getElementById('slot-title-' + slotIdx);
      var price = document.getElementById('slot-price-' + slotIdx);

      var carId = select.value;
      if (carId && carsData[carId]) {
        var car = carsData[carId];
        card.classList.add('has-car');
        removeBtn.style.display = 'flex';
        emptyView.style.display = 'none';
        filledView.style.display = 'block';
        img.src = car.image;
        img.alt = car.name;
        title.textContent = car.name;
        price.textContent = car.price ? '₹ ' + car.price : '';

        /* Update variant */
        variantSelect.innerHTML = '<option value="std" selected>' + (car.fuel || 'Standard') + ' · ' + (car.bodyType || 'Variant') + '</option>';
      } else {
        card.classList.remove('has-car');
        removeBtn.style.display = 'none';
        emptyView.style.display = 'flex';
        filledView.style.display = 'none';
        variantSelect.innerHTML = '<option value="">Select Variant</option>';
      }
    }

    function clearSlot(slotIdx) {
      var select = document.getElementById('car-select-' + slotIdx);
      if (select) {
        select.value = "";
        onCarSelectChange(slotIdx);
      }
    }

    function toggleHighlightDiff() {
      var table = document.getElementById('spec-comparison-table');
      if (!table) return;
      var rows = table.querySelectorAll('tr.spec-row');
      var btn = document.getElementById('highlight-diff-btn');
      var isHighlighting = btn.classList.toggle('active');

      rows.forEach(function(row) {
        var cells = Array.from(row.querySelectorAll('td'));
        if (cells.length > 1) {
          var texts = cells.map(function(c) { return c.textContent.trim(); });
          var allSame = texts.every(function(t) { return t === texts[0]; });
          cells.forEach(function(c) {
            if (isHighlighting && !allSame) {
              c.classList.add('diff-highlight');
            } else {
              c.classList.remove('diff-highlight');
            }
          });
        }
      });

      btn.textContent = isHighlighting ? "Show normal view" : "Highlight differences";
    }
  </script>
</body>
</html>