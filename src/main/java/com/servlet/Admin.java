package com.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Servlet implementation class Admin
 */
@WebServlet("/Admin")
public class Admin extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Admin() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request,
     *      HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("text/html");

        PrintWriter pw = res.getWriter();

        String action = req.getParameter("action");

        try {

            Class.forName("oracle.jdbc.driver.OracleDriver");

            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:XE",
                    "CARVERSE",
                    "manager"
            );

            Statement stmt = con.createStatement();

            /*
             * =====================================================
             * ADMIN DASHBOARD
             * =====================================================
             */

            if (action == null || action.equals("dashboard")) {

                pw.println("<html>");
                pw.println("<head>");
                pw.println("<title>Carverse Admin</title>");

                pw.println("<style>");

                pw.println("body{");
                pw.println("font-family:Arial;");
                pw.println("background:#f5f5f5;");
                pw.println("margin:0;");
                pw.println("}");

                pw.println(".header{");
                pw.println("background:#111;");
                pw.println("color:white;");
                pw.println("padding:25px;");
                pw.println("}");

                pw.println(".container{");
                pw.println("padding:30px;");
                pw.println("}");

                pw.println(".menu{");
                pw.println("display:grid;");
                pw.println("grid-template-columns:repeat(3,1fr);");
                pw.println("gap:20px;");
                pw.println("}");

                pw.println(".box{");
                pw.println("background:white;");
                pw.println("padding:30px;");
                pw.println("text-align:center;");
                pw.println("border-radius:10px;");
                pw.println("box-shadow:0 3px 10px #ccc;");
                pw.println("}");

                pw.println("a{");
                pw.println("text-decoration:none;");
                pw.println("color:#111;");
                pw.println("font-weight:bold;");
                pw.println("}");

                pw.println("</style>");

                pw.println("</head>");

                pw.println("<body>");

                pw.println("<div class='header'>");
                pw.println("<h1>Carverse Admin Panel</h1>");
                pw.println("<p>Welcome Admin - Princi</p>");
                pw.println("</div>");

                pw.println("<div class='container'>");

                pw.println("<h2>Admin Dashboard</h2>");

                pw.println("<div class='menu'>");


                pw.println("<div class='box'>");
                pw.println("<a href='Admin?action=users'>");
                pw.println("User Details");
                pw.println("</a>");
                pw.println("</div>");


                pw.println("<div class='box'>");
                pw.println("<a href='Admin?action=companies'>");
                pw.println("Company Details");
                pw.println("</a>");
                pw.println("</div>");


                pw.println("<div class='box'>");
                pw.println("<a href='Admin?action=cars'>");
                pw.println("Car Details");
                pw.println("</a>");
                pw.println("</div>");


                pw.println("<div class='box'>");
                pw.println("<a href='Admin?action=bookings'>");
                pw.println("Booking Details");
                pw.println("</a>");
                pw.println("</div>");


                pw.println("<div class='box'>");
                pw.println("<a href='Admin?action=commission'>");
                pw.println("Commission Details");
                pw.println("</a>");
                pw.println("</div>");


                pw.println("<div class='box'>");
                pw.println("<a href='Admin?action=platformfeed'>");
                pw.println("Platform Feedback");
                pw.println("</a>");
                pw.println("</div>");


                pw.println("<div class='box'>");
                pw.println("<a href='Admin?action=maintenance'>");
                pw.println("Maintenance Details");
                pw.println("</a>");
                pw.println("</div>");


                pw.println("</div>");
                pw.println("</div>");

                pw.println("</body>");
                pw.println("</html>");
            }


            /*
             
             * USER DETAILS
             
             */

            else if (action.equals("users")) {

                String q1 =
                        "select user_id, username, email, contact, " +
                        "address, created_at " +
                        "from USER_REGISTRATION";

                ResultSet rs = stmt.executeQuery(q1);

                pw.println("<html><body>");

                pw.println("<h2>User Details</h2>");

                pw.println("<table border='2' width='100%'>");

                pw.println("<tr>");
                pw.println("<th>User ID</th>");
                pw.println("<th>Username</th>");
                pw.println("<th>Email</th>");
                pw.println("<th>Contact</th>");
                pw.println("<th>Address</th>");
                pw.println("<th>Created At</th>");
                pw.println("</tr>");

                while (rs.next()) {

                    pw.println("<tr>");

                    pw.println("<td>" +
                            rs.getString("user_id") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("username") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("email") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("contact") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("address") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("created_at") +
                            "</td>");

                    pw.println("</tr>");
                }

                pw.println("</table>");

                pw.println("<br>");
                pw.println("<a href='Admin'>Back to Dashboard</a>");

                pw.println("</body></html>");
            }


            /*
             
             * COMPANY DETAILS
             
             */

            else if (action.equals("companies")) {

                String q1 =
                        "select company_id, company_name, " +
                        "company_email, company_phone, " +
                        "company_address, registration_number, " +
                        "verification_status, created_at " +
                        "from company_details";

                ResultSet rs = stmt.executeQuery(q1);

                pw.println("<html><body>");

                pw.println("<h2>Company Details</h2>");

                pw.println("<table border='2' width='100%'>");

                pw.println("<tr>");
                pw.println("<th>Company ID</th>");
                pw.println("<th>Company Name</th>");
                pw.println("<th>Email</th>");
                pw.println("<th>Phone</th>");
                pw.println("<th>Address</th>");
                pw.println("<th>Registration No.</th>");
                pw.println("<th>Status</th>");
                pw.println("<th>Created At</th>");
                pw.println("</tr>");

                while (rs.next()) {

                    pw.println("<tr>");

                    pw.println("<td>" +
                            rs.getString("company_id") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("company_name") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("company_email") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("company_phone") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("company_address") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("registration_number") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("verification_status") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("created_at") +
                            "</td>");

                    pw.println("</tr>");
                }

                pw.println("</table>");

                pw.println("<br>");
                pw.println("<a href='Admin'>Back to Dashboard</a>");

                pw.println("</body></html>");
            }


            /*
             
             * CAR DETAILS
             
             */

            else if (action.equals("cars")) {

                String q1 =
                        "select c.car_id, c.company_id, c.model_name, c.brand, " +
                        "c.registration_number, " +
                        "s.fuel_type, s.transmission_type as transmission, c.seating_capacity, " +
                        "c.body_type, c.price_range, " +
                        "c.availability_status " +
                        "from car_details c " +
                        "left join car_specs s on s.car_id = c.car_id";

                ResultSet rs = stmt.executeQuery(q1);

                pw.println("<html><body>");

                pw.println("<h2>Car Details</h2>");

                pw.println("<table border='2' width='100%'>");

                pw.println("<tr>");

                pw.println("<th>Car ID</th>");
                pw.println("<th>Company ID</th>");
                pw.println("<th>Brand</th>");
                pw.println("<th>Model Name</th>");
                pw.println("<th>Registration No.</th>");
                pw.println("<th>Fuel</th>");
                pw.println("<th>Transmission</th>");
                pw.println("<th>Seats</th>");
                pw.println("<th>Body Type</th>");
                pw.println("<th>Price Range</th>");
                pw.println("<th>Status</th>");

                pw.println("</tr>");

                while (rs.next()) {

                    pw.println("<tr>");

                    pw.println("<td>" + rs.getString("car_id") + "</td>");
                    pw.println("<td>" + rs.getString("company_id") + "</td>");
                    pw.println("<td>" + rs.getString("brand") + "</td>");
                    pw.println("<td>" + rs.getString("model_name") + "</td>");
                    pw.println("<td>" + rs.getString("registration_number") + "</td>");
                    pw.println("<td>" + rs.getString("fuel_type") + "</td>");
                    pw.println("<td>" + rs.getString("transmission") + "</td>");
                    pw.println("<td>" + rs.getString("seating_capacity") + "</td>");
                    pw.println("<td>" + rs.getString("body_type") + "</td>");
                    pw.println("<td>" + rs.getString("price_range") + "</td>");
                    pw.println("<td>" + rs.getString("availability_status") + "</td>");

                    pw.println("</tr>");
                }

                pw.println("</table>");

                pw.println("<br>");
                pw.println("<a href='Admin'>Back to Dashboard</a>");

                pw.println("</body></html>");
            }


            /*
             
             * BOOKING DETAILS
             
             */

            else if (action.equals("bookings")) {

                String q1 =
                        "select booking_id, user_id, car_id, " +
                        "booking_date, " +
                        "pickup_location, drop_location, total_amount, " +
                        "booking_status " +
                        "from booking_details";

                ResultSet rs = stmt.executeQuery(q1);

                pw.println("<html><body>");

                pw.println("<h2>Booking Details / Cancel Requests</h2>");

                pw.println("<table border='2' width='100%'>");

                pw.println("<tr>");

                pw.println("<th>Booking ID</th>");
                pw.println("<th>User ID</th>");
                pw.println("<th>Car ID</th>");
                pw.println("<th>Booking Date</th>");
                pw.println("<th>Pickup</th>");
                pw.println("<th>Drop</th>");
                pw.println("<th>Total Amount</th>");
                pw.println("<th>Status</th>");

                pw.println("</tr>");

                while (rs.next()) {

                    pw.println("<tr>");

                    pw.println("<td>" + rs.getString("booking_id") + "</td>");
                    pw.println("<td>" + rs.getString("user_id") + "</td>");
                    pw.println("<td>" + rs.getString("car_id") + "</td>");
                    pw.println("<td>" + rs.getString("booking_date") + "</td>");
                    pw.println("<td>" + rs.getString("pickup_location") + "</td>");
                    pw.println("<td>" + rs.getString("drop_location") + "</td>");
                    pw.println("<td>" + rs.getString("total_amount") + "</td>");
                    pw.println("<td>" + rs.getString("booking_status") + "</td>");

                    pw.println("</tr>");
                }

                pw.println("</table>");

                pw.println("<br>");
                pw.println("<a href='Admin'>Back to Dashboard</a>");

                pw.println("</body></html>");
            }



            /*
             
             * COMMISSION DETAILS
             
             */

            else if (action.equals("commission")) {

                String q1 =
                        "select commission_id, booking_id, payment_id, " +
                        "commission_rate, commission_amount, " +
                        "commission_status, created_at " +
                        "from commission_details";

                ResultSet rs = stmt.executeQuery(q1);

                pw.println("<html><body>");

                pw.println("<h2>Commission Details</h2>");

                pw.println("<table border='2' width='100%'>");

                pw.println("<tr>");

                pw.println("<th>Commission ID</th>");
                pw.println("<th>Booking ID</th>");
                pw.println("<th>Payment ID</th>");
                pw.println("<th>Commission Rate</th>");
                pw.println("<th>Commission Amount</th>");
                pw.println("<th>Status</th>");
                pw.println("<th>Created At</th>");

                pw.println("</tr>");

                while (rs.next()) {

                    pw.println("<tr>");

                    pw.println("<td>" + rs.getString("commission_id") + "</td>");
                    pw.println("<td>" + rs.getString("booking_id") + "</td>");
                    pw.println("<td>" + rs.getString("payment_id") + "</td>");
                    pw.println("<td>" + rs.getString("commission_rate") + "</td>");
                    pw.println("<td>" + rs.getString("commission_amount") + "</td>");
                    pw.println("<td>" + rs.getString("commission_status") + "</td>");
                    pw.println("<td>" + rs.getString("created_at") + "</td>");

                    pw.println("</tr>");
                }

                pw.println("</table>");

                pw.println("<br>");
                pw.println("<a href='Admin'>Back to Dashboard</a>");

                pw.println("</body></html>");
            }



            /*
             
             * PLATFORM FEEDBACK
             
             */

            else if (action.equals("platformfeed")) {

                String q1 =
                        "select platform_feed_id, user_id, company_id, " +
                        "title, content, created_at, status " +
                        "from platform_feed";

                ResultSet rs = stmt.executeQuery(q1);

                pw.println("<html><body>");

                pw.println("<h2>Platform Feedback</h2>");

                pw.println("<table border='2' width='100%'>");

                pw.println("<tr>");

                pw.println("<th>Feed ID</th>");
                pw.println("<th>User ID</th>");
                pw.println("<th>Company ID</th>");
                pw.println("<th>Title</th>");
                pw.println("<th>Content</th>");
                pw.println("<th>Created At</th>");
                pw.println("<th>Status</th>");

                pw.println("</tr>");

                while (rs.next()) {

                    pw.println("<tr>");

                    pw.println("<td>" +
                            rs.getString("platform_feed_id") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("user_id") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("company_id") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("title") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("content") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("created_at") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("status") +
                            "</td>");

                    pw.println("</tr>");
                }

                pw.println("</table>");

                pw.println("<br>");
                pw.println("<a href='Admin'>Back to Dashboard</a>");

                pw.println("</body></html>");
            }


            /*
             
             * MAINTENANCE DETAILS
            
             */

            else if (action.equals("maintenance")) {

                String q1 =
                        "select maintenance_id, user_id, car_id, " +
                        "car_purchased_year, last_maintenance_date, " +
                        "maintenance_status " +
                        "from maintenance_details";

                ResultSet rs = stmt.executeQuery(q1);

                pw.println("<html><body>");

                pw.println("<h2>Maintenance Details</h2>");

                pw.println("<table border='2' width='100%'>");

                pw.println("<tr>");

                pw.println("<th>Maintenance ID</th>");
                pw.println("<th>User ID</th>");
                pw.println("<th>Car ID</th>");
                pw.println("<th>Purchased Year</th>");
                pw.println("<th>Last Maintenance</th>");
                pw.println("<th>Status</th>");

                pw.println("</tr>");

                while (rs.next()) {

                    pw.println("<tr>");

                    pw.println("<td>" +
                            rs.getString("maintenance_id") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("user_id") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("car_id") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("car_purchased_year") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("last_maintenance_date") +
                            "</td>");

                    pw.println("<td>" +
                            rs.getString("maintenance_status") +
                            "</td>");

                    pw.println("</tr>");
                }

                pw.println("</table>");

                pw.println("<br>");
                pw.println("<a href='Admin'>Back to Dashboard</a>");

                pw.println("</body></html>");
            }

            /*
             
             * CLOSE CONNECTION
             
             */

            con.close();

        }

        catch (Exception e) {

            pw.println("<h3>Error:</h3>");
            pw.println(e);

        }
    }
}