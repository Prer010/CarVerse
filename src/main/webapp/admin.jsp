<%
String adminName = request.getParameter("adminName");

if(adminName == null || adminName.trim().equals(""))
{
    adminName = "Admin";
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>CarVerse Admin Dashboard</title>

<style>

* {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: Arial, sans-serif;

    background:
        linear-gradient(rgba(15, 35, 29, 0.80),
                        rgba(15, 35, 29, 0.80)),
        url("car-bg.jpg");

    background-size: cover;
    background-position: center;
    background-attachment: fixed;

    min-height: 100vh;
    color: #18251f;
}


/* MAIN CONTAINER */

.container {
    width: 1200px;
    max-width: 94%;

    margin: 30px auto;

    background: rgba(246, 248, 247, 0.94);

    border-radius: 20px;

    overflow: hidden;

    box-shadow: 0 20px 50px rgba(0,0,0,0.35);
}


/* TOP NAVIGATION */

.navbar {
    height: 75px;

    display: flex;

    justify-content: space-between;

    align-items: center;

    padding: 0 35px;

    background: rgba(255,255,255,0.72);

    border-bottom: 1px solid rgba(0,0,0,0.08);

    backdrop-filter: blur(15px);
}

.logo {
    font-size: 23px;

    font-weight: bold;

    letter-spacing: 1px;
}

.logo span {
    color: #83b800;
}

.nav-right {
    display: flex;

    align-items: center;

    gap: 15px;
}

.admin {
    padding: 9px 15px;

    background: rgba(168,240,0,0.18);

    border: 1px solid rgba(130,170,0,0.25);

    border-radius: 20px;

    font-size: 11px;

    font-weight: bold;
}

.logout {
    text-decoration: none;

    color: #28332f;

    font-size: 11px;

    padding: 9px 15px;

    border: 1px solid #d1d8d5;

    border-radius: 6px;

    background: white;
}

.logout:hover {
    background: #182b26;

    color: white;
}


/* CONTENT */

.content {
    padding: 35px 40px 40px;
}


/* HEADER */

.header {
    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 25px;
}

.header h1 {
    margin: 0;

    font-size: 27px;
}

.header p {
    margin: 7px 0 0;

    color: #89948f;

    font-size: 12px;
}


/* STATUS */

.status {
    padding: 9px 14px;

    border-radius: 20px;

    background: #eaf5d1;

    color: #638000;

    font-size: 9px;

    font-weight: bold;

    letter-spacing: 1px;
}


/* WELCOME BOX */

.welcome {
    padding: 25px 28px;

    border-radius: 14px;

    background:
        linear-gradient(
            120deg,
            rgba(31,58,50,0.96),
            rgba(40,72,62,0.90)
        );

    color: white;

    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 30px;

    box-shadow: 0 10px 25px rgba(25,50,42,0.15);
}

.welcome h2 {
    margin: 0 0 8px;

    font-size: 21px;
}

.welcome h2 span {
    color: #a8f000;
}

.welcome p {
    margin: 0;

    color: #c1ceca;

    font-size: 11px;
}

.date-box {
    text-align: right;

    color: #a8b5b0;

    font-size: 10px;
}


/* SECTION TITLE */

.section {
    display: flex;

    justify-content: space-between;

    align-items: center;

    margin-bottom: 15px;
}

.section h3 {
    margin: 0;

    font-size: 15px;
}

.section span {
    color: #929d98;

    font-size: 10px;
}


/* MANAGEMENT GRID */

.grid {
    display: grid;

    grid-template-columns: repeat(4, 1fr);

    gap: 14px;
}


/* CARD */

.card {
    text-decoration: none;

    color: #1b2924;

    background: rgba(255,255,255,0.65);

    border: 1px solid rgba(255,255,255,0.9);

    border-radius: 12px;

    padding: 20px;

    min-height: 135px;

    backdrop-filter: blur(12px);

    box-shadow: 0 7px 20px rgba(30,50,43,0.06);

    transition: 0.2s;
}

.card:hover {
    transform: translateY(-3px);

    border-color: #a8f000;

    background: rgba(255,255,255,0.9);

    box-shadow: 0 10px 25px rgba(30,50,43,0.12);
}

.card-number {
    font-size: 9px;

    color: #a0aaa5;

    margin-bottom: 20px;
}

.card h3 {
    margin: 0 0 7px;

    font-size: 14px;
}

.card p {
    margin: 0;

    color: #8a9691;

    font-size: 10px;

    line-height: 1.5;
}


/* HIGHLIGHT */

.highlight {
    background: rgba(168,240,0,0.90);

    border-color: #a8f000;
}

.highlight .card-number {
    color: #5c700c;
}

.highlight p {
    color: #526113;
}

.highlight:hover {
    background: #a8f000;
}


/* FOOTER */

.footer {
    margin-top: 30px;

    padding-top: 20px;

    border-top: 1px solid #dfe5e2;

    display: flex;

    justify-content: space-between;

    align-items: center;
}

.footer p {
    margin: 0;

    color: #9aa39f;

    font-size: 9px;

    letter-spacing: 1px;
}

.footer a {
    text-decoration: none;

    color: #26332e;

    font-size: 10px;

    padding: 9px 15px;

    border-radius: 6px;

    border: 1px solid #ccd4d0;

    background: white;
}

.footer a:hover {
    background: #182b26;

    color: white;
}


/* RESPONSIVE */

@media(max-width: 1000px) {

    .grid {
        grid-template-columns: repeat(2, 1fr);
    }

}

@media(max-width: 650px) {

    .container {
        max-width: 96%;
    }

    .navbar {
        padding: 0 20px;
    }

    .content {
        padding: 25px 20px;
    }

    .header {
        display: block;
    }

    .status {
        display: inline-block;

        margin-top: 15px;
    }

    .welcome {
        display: block;
    }

    .date-box {
        text-align: left;

        margin-top: 15px;
    }

    .grid {
        grid-template-columns: 1fr;
    }

}

</style>

</head>


<body>


<div class="container">


    <!-- TOP NAVIGATION -->

    <div class="navbar">

        <div class="logo">
            <span>CAR</span>VERSE
        </div>


        <div class="nav-right">

            <div class="admin">
                <%=adminName%>
            </div>

            <a href="index.jsp" class="logout">
                Back to Website
            </a>

        </div>

    </div>



    <!-- CONTENT -->

    <div class="content">


        <!-- PAGE HEADER -->

        <div class="header">

            <div>

                <h1>
                    Admin Dashboard
                </h1>

                <p>
                    Car purchasing and comparison system
                </p>

            </div>


            <div class="status">
                SYSTEM ACTIVE
            </div>

        </div>



    <!-- WELCOME -->

        <div class="welcome">

            <div>

                <h2>
                    Welcome back, <span><%=adminName%></span>
                </h2>

                <p>
                    Manage the different sections of your
                    CarVerse application from here.
                </p>

            </div>


            <div class="date-box">
                CARVERSE ADMINISTRATION
            </div>

        </div>



    <!-- MANAGEMENT -->

        <div class="section">

            <h3>
                Management
            </h3>

            <span>
                Select an option
            </span>

        </div>



    <!-- CARDS -->

        <div class="grid">


            <a href="Admin?action=users" class="card">

                <div class="card-number">
                    01
                </div>

                <h3>
                    User Details
                </h3>

                <p>
                    View registered users and their information.
                </p>

            </a>


            <a href="Admin?action=companies" class="card">

                <div class="card-number">
                    02
                </div>

                <h3>
                    Company Details
                </h3>

                <p>
                    View automobile companies available in the system.
                </p>

            </a>


            <a href="Admin?action=cars" class="card highlight">

                <div class="card-number">
                    03
                </div>

                <h3>
                    Car Details
                </h3>

                <p>
                    View available cars and their details.
                </p>

            </a>


            <a href="Admin?action=bookings" class="card">

                <div class="card-number">
                    04
                </div>

                <h3>
                    Booking Details
                </h3>

                <p>
                    View bookings and cancellation requests.
                </p>

            </a>


            <a href="Admin?action=commission" class="card">

                <div class="card-number">
                    05
                </div>

                <h3>
                    Commission Details
                </h3>

                <p>
                    View commission generated from bookings.
                </p>

            </a>


            <a href="Admin?action=platformfeed" class="card">

                <div class="card-number">
                    06
                </div>

                <h3>
                    Platform Feedback
                </h3>

                <p>
                    View feedback about the CarVerse platform.
                </p>

            </a>


            <a href="admin_maintenance_update.jsp" class="card">

                <div class="card-number">
                    07
                </div>

                <h3>
                    Maintenance Details
                </h3>

                <p>
                    View maintenance information of vehicles.
                </p>

            </a>


        </div>



    <!-- FOOTER -->

        <div class="footer">

            <p>
                CARVERSE ADMINISTRATION
            </p>

            

        </div>


    </div>

</div>


</body>

</html>
