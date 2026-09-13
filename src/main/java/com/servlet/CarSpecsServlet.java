package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/car-specs")
public class CarSpecsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String DB_URL      = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String DB_USER     = System.getenv("DB_USER");
    private static final String DB_PASSWORD = System.getenv("DB_PASSWORD");

    @Override
    public void init() throws ServletException {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            throw new ServletException("Oracle JDBC Driver not found.", e);
        }

        if (DB_USER == null || DB_PASSWORD == null) {
            throw new ServletException(
                    "DB_USER or DB_PASSWORD environment variable is not set.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        /* ------------------------------------------------------------------ *
         * Validate carId parameter                                            *
         * ------------------------------------------------------------------ */

        String carIdParam = request.getParameter("carId");

        if (carIdParam == null || carIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/car-search");
            return;
        }

        int carId;
        try {
            carId = Integer.parseInt(carIdParam.trim());
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/car-search");
            return;
        }

        /* ------------------------------------------------------------------ *
         * Fetch from DB: CAR_DETAILS (for header) + CAR_SPECS (full specs)   *
         * ------------------------------------------------------------------ */

        CarModel     car      = null;
        CarSpecsModel carSpecs = null;

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {

            /* --- CAR_DETAILS: name, brand, price, images for page header --- */
            String detailsSql =
                    "SELECT car_id, model_name, brand, body_type, price_range, "
                    + "fuel_types, images, source_url "
                    + "FROM car_details WHERE car_id = ?";

            try (PreparedStatement ps = conn.prepareStatement(detailsSql)) {
                ps.setInt(1, carId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        car = new CarModel();
                        car.setCarId(rs.getInt("car_id"));
                        car.setModelName(rs.getString("model_name"));
                        car.setBrand(rs.getString("brand"));
                        car.setBodyType(rs.getString("body_type"));
                        car.setPriceRange(rs.getString("price_range"));
                        car.setFuelTypes(rs.getString("fuel_types"));
                        car.setImages(rs.getString("images"));
                        car.setSourceUrl(rs.getString("source_url"));
                    }
                }
            }

            /* --- CAR_SPECS: full specification data --- */
            String specsSql =
                    "SELECT car_id, brand, model, "
                    + "length, width, height, wheelbase, "
                    + "engine_type, displacement, motor_type, max_power, max_torque, "
                    + "no_of_cylinders, valves_per_cylinder, "
                    + "battery_type, regenerative_braking, wireless_charging, "
                    + "transmission_type, gearbox, hybrid_type, drive_type, "
                    + "fuel_type, petrol_mileage_arai, petrol_fuel_tank_capacity, "
                    + "emission_norm_compliance, "
                    + "front_suspension, rear_suspension, "
                    + "steering_type, steering_column, steering_gear_type, turning_radius, "
                    + "front_brake_type, rear_brake_type, "
                    + "seating_capacity, gross_weight, source_url "
                    + "FROM car_specs WHERE car_id = ?";

            try (PreparedStatement ps = conn.prepareStatement(specsSql)) {
                ps.setInt(1, carId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        carSpecs = new CarSpecsModel();
                        carSpecs.setCarId(rs.getInt("car_id"));
                        carSpecs.setBrand(rs.getString("brand"));
                        carSpecs.setModel(rs.getString("model"));
                        carSpecs.setLength(rs.getString("length"));
                        carSpecs.setWidth(rs.getString("width"));
                        carSpecs.setHeight(rs.getString("height"));
                        carSpecs.setWheelbase(rs.getString("wheelbase"));
                        carSpecs.setEngineType(rs.getString("engine_type"));
                        carSpecs.setDisplacement(rs.getString("displacement"));
                        carSpecs.setMotorType(rs.getString("motor_type"));
                        carSpecs.setMaxPower(rs.getString("max_power"));
                        carSpecs.setMaxTorque(rs.getString("max_torque"));
                        carSpecs.setNoOfCylinders(rs.getString("no_of_cylinders"));
                        carSpecs.setValvesPerCylinder(rs.getString("valves_per_cylinder"));
                        carSpecs.setBatteryType(rs.getString("battery_type"));
                        carSpecs.setRegenerativeBraking(rs.getString("regenerative_braking"));
                        carSpecs.setWirelessCharging(rs.getString("wireless_charging"));
                        carSpecs.setTransmissionType(rs.getString("transmission_type"));
                        carSpecs.setGearbox(rs.getString("gearbox"));
                        carSpecs.setHybridType(rs.getString("hybrid_type"));
                        carSpecs.setDriveType(rs.getString("drive_type"));
                        carSpecs.setFuelType(rs.getString("fuel_type"));
                        carSpecs.setPetrolMileageArai(rs.getString("petrol_mileage_arai"));
                        carSpecs.setPetrolFuelTankCapacity(rs.getString("petrol_fuel_tank_capacity"));
                        carSpecs.setEmissionNormCompliance(rs.getString("emission_norm_compliance"));
                        carSpecs.setFrontSuspension(rs.getString("front_suspension"));
                        carSpecs.setRearSuspension(rs.getString("rear_suspension"));
                        carSpecs.setSteeringType(rs.getString("steering_type"));
                        carSpecs.setSteeringColumn(rs.getString("steering_column"));
                        carSpecs.setSteeringGearType(rs.getString("steering_gear_type"));
                        carSpecs.setTurningRadius(rs.getString("turning_radius"));
                        carSpecs.setFrontBrakeType(rs.getString("front_brake_type"));
                        carSpecs.setRearBrakeType(rs.getString("rear_brake_type"));
                        carSpecs.setSeatingCapacity(rs.getString("seating_capacity"));
                        carSpecs.setGrossWeight(rs.getString("gross_weight"));
                        carSpecs.setSourceUrl(rs.getString("source_url"));
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load specifications. Please try again.");
        }

        /* ------------------------------------------------------------------ *
         * Guard: if car_details row not found, redirect to search             *
         * ------------------------------------------------------------------ */

        if (car == null && request.getAttribute("error") == null) {
            response.sendRedirect(request.getContextPath() + "/car-search");
            return;
        }

        request.setAttribute("car", car);
        request.setAttribute("carSpecs", carSpecs);

        request.getRequestDispatcher("/car-specs.jsp").forward(request, response);
    }
}
