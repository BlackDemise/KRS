<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
        <title>FPTU Learning Website</title>

        <!-- Bootstrap core CSS -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">


        <!-- Additional CSS Files -->
        <link rel="stylesheet" href="../assets/css/fontawesome.css">
        <link rel="stylesheet" href="../assets/css/templatemo-scholar.css">
        <link rel="stylesheet" href="../assets/css/owl.css">
        <link rel="stylesheet" href="../assets/css/animate.css">

        <link rel="stylesheet"href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        
    </head>

    <body>

        <!-- ***** Preloader Start ***** -->
        <div id="js-preloader" class="js-preloader">
            <div class="preloader-inner">
                <span class="dot"></span>
                <div class="dots">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
        </div>
        <!-- ***** Preloader End ***** -->

        <!-- ***** Header Area Start ***** -->
        <header class="header-area header-sticky">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <nav class="main-nav">
                            <!-- ***** Logo Start ***** -->
                            <a href="/main/homepage.jsp" class="logo">
                                <h1>KRS</h1>
                            </a>
                            <!-- ***** Logo End ***** -->
                            <!-- ***** Serach Start ***** -->
                            <div class="search-input">
                                <form id="search" action="#">
                                    <input type="text" placeholder="Type Something" id='searchText' name="searchKeyword" onkeypress="handle" />
                                    <i class="fa fa-search"></i>
                                </form>
                            </div>
                            <!-- ***** Serach Start ***** -->
                            <!-- ***** Menu Start ***** -->
                            <ul class="nav">
                                <li class="scroll-to-section"><a href="#top" class="active">Home</a></li>
                                <li class="scroll-to-section"><a href="#services">Services</a></li>
                                <li class="scroll-to-section"><a href="#about">About</a></li>
                                <li class="scroll-to-section"><a href="#courses">Subjects</a></li>
                                <li class="scroll-to-section"><a href="#team">Teacher</a></li>
                                <li class="scroll-to-section"><a href="#contact">Contact</a></li>
                                <li class="scroll-to-section"><a href="/allpost">Post</a></li>
                                    <c:choose>
                                        <c:when test="${sessionScope.user == null}">
                                        <li class="scroll-to-section"><a href="/main/login.jsp">Login</a></li>
                                        <li class="scroll-to-section"><a href="/register">Register</a></li>
                                        </c:when>
                                        <c:otherwise>
                                        <li class="list-inline-item mb-0 ms-1">
                                            <div class="dropdown dropdown-primary">
                                                <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="../assets/images/${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt=""></button>
                                                <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px">
                                                    <a class="dropdown-item d-flex align-items-center text-dark" href="#">
                                                        <img src="../assets/images/${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="flex-1 ms-2">
                                                            <span class="d-block mb-1">${sessionScope.user.email}</span>
                                                            <small class="text-muted">${sessionScope.user.role.title}</small>
                                                        </div>
                                                    </a>
                                                    <a class="dropdown-item text-dark" href="/admin/dashboard.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                                    <a class="dropdown-item text-dark" href="/main/my-profile.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                                    <div class="dropdown-divider border-top"></div>
                                                    <a class="dropdown-item text-dark" href="/logout"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                                                </div>
                                            </div>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>   
                            <a class='menu-trigger'>
                                <span>Menu</span>
                            </a>
                            <!-- ***** Menu End ***** -->
                        </nav>
                    </div>
                </div>
            </div>
        </header>
        <!-- ***** Header Area End ***** -->

        <div class="main-banner" id="top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="owl-carousel owl-banner">
                            <div class="item item-1">
                                <div class="header-text">
                                    <span class="category">Our Learning Website</span>
                                    <h2>With FPTU Learning Website, Everything Is Easier</h2>
                                    <p>FLW is free website designed by SWP391-G5 team for online educational websites. This is the web for FPT students to review their knowledge.</p>
                                    <div class="buttons">
                                        <div class="main-button">
                                            <a href="#">Request Demo</a>
                                        </div>
                                        <div class="icon-button">
                                            <a href="#"><i class="fa fa-play"></i> What's FLW?</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="item item-2">
                                <div class="header-text">
                                    <span class="category">Best Result</span>
                                    <h2>Get the best result out of your effort</h2>
                                    <p>You are allowed to use this web for any educational purpose. You can not find better services on any other website.</p>
                                    <div class="buttons">
                                        <div class="main-button">
                                            <a href="#">Request Demo</a>
                                        </div>
                                        <div class="icon-button">
                                            <a href="#"><i class="fa fa-play"></i> What's the best result?</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="item item-3">
                                <div class="header-text">
                                    <span class="category">Online Learning</span>
                                    <h2>Online Learning helps you save the time</h2>
                                    <p>Online learning delivers educational content via the internet, enabling flexible, accessible, and convenient learning experiences.</p>
                                    <div class="buttons">
                                        <div class="main-button">
                                            <a href="#">Request Demo</a>
                                        </div>
                                        <div class="icon-button">
                                            <a href="#"><i class="fa fa-play"></i> What's Online Learning?</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="services section" id="services">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-6">
                        <div class="service-item">
                            <div class="icon">
                                <img src="assets/images/service-01.png" alt="online degrees">
                            </div>
                            <div class="main-content">
                                <h4>Free Syllabuses</h4>
                                <p>Whenever you need free documentation in FPT's subjects, you just remember FLW website.</p>
                                <div class="main-button">
                                    <a href="#">Read More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="service-item">
                            <div class="icon">
                                <img src="assets/images/service-02.png" alt="short courses">
                            </div>
                            <div class="main-content">
                                <h4>Online Review</h4>
                                <p>You can access all multi-choice questions created by our teachers and use them to review for your tests</p>
                                <div class="main-button">
                                    <a href="#">Read More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="service-item">
                            <div class="icon">
                                <img src="assets/images/service-03.png" alt="web experts">
                            </div>
                            <div class="main-content">
                                <h4>Online Tests</h4>
                                <p>You can try to do all tests like a real one at school for better results</p>
                                <div class="main-button">
                                    <a href="#">Read More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="section about-us" id="about">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 offset-lg-1">
                        <div class="accordion" id="accordionExample">
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingOne">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        Where shall we begin?
                                    </button>
                                </h2>
                                <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                                    <div class="accordion-body">
                                        Dolor <strong>almesit amet</strong>, consectetur adipiscing elit, sed doesn't eiusmod tempor incididunt ut labore consectetur <code>adipiscing</code> elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingTwo">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                        How do we work together?
                                    </button>
                                </h2>
                                <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                                    <div class="accordion-body">
                                        Dolor <strong>almesit amet</strong>, consectetur adipiscing elit, sed doesn't eiusmod tempor incididunt ut labore consectetur <code>adipiscing</code> elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingThree">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                        Why SCHOLAR is the best?
                                    </button>
                                </h2>
                                <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                                    <div class="accordion-body">
                                        There are more than one hundred responsive HTML templates to choose from <strong>Template</strong>Mo website. You can browse by different tags or categories.
                                    </div>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingFour">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                        Do we get the best support?
                                    </button>
                                </h2>
                                <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#accordionExample">
                                    <div class="accordion-body">
                                        You can also search on Google with specific keywords such as <code>templatemo business templates, templatemo gallery templates, admin dashboard templatemo, 3-column templatemo, etc.</code>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5 align-self-center">
                        <div class="section-heading">
                            <h6>About Us</h6>
                            <h2>What make us the best learning website online?</h2>
                            <p>We have the team of best teachers that have high experience and the closest sources of each subject's knowledge to the school</p>
                            <div class="main-button">
                                <a href="#">Discover More</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <section class="section courses" id="courses" >
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <div class="section-heading">
                            <h6>Subjects</h6>
                        </div>
                    </div>
                </div>
                <ul class="event_filter">
                    <li>
                        <a class="is_active" href="#!" data-filter="*">Show All</a>
                    </li>
                    <li>
                        <a href="#!" data-filter=".design">Webdesign</a>
                    </li>
                    <li>
                        <a href="#!" data-filter=".development">Development</a>
                    </li>
                    <li>
                        <a href="#!" data-filter=".wordpress">Wordpress</a>
                    </li>
                </ul>
                <div class="row event_box">
                    <div class="col-lg-4 col-md-6 align-self-center mb-30 event_outer col-md-6 design">
                        <div class="events_item">
                            <div class="thumb">
                                <a href="#"><img src="assets/images/course-01.jpg" alt=""></a>
                                <span class="category">Webdesign</span>
                                <span class="price"><h6><em>$</em>160</h6></span>
                            </div>
                            <div class="down-content">
                                <span class="author">Stella Blair</span>
                                <h4>Learn Web Design</h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 align-self-center mb-30 event_outer col-md-6  development">
                        <div class="events_item">
                            <div class="thumb">
                                <a href="#"><img src="assets/images/course-02.jpg" alt=""></a>
                                <span class="category">Development</span>
                                <span class="price"><h6><em>$</em>340</h6></span>
                            </div>
                            <div class="down-content">
                                <span class="author">Cindy Walker</span>
                                <h4>Web Development Tips</h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 align-self-center mb-30 event_outer col-md-6 design wordpress">
                        <div class="events_item">
                            <div class="thumb">
                                <a href="#"><img src="assets/images/course-03.jpg" alt=""></a>
                                <span class="category">Wordpress</span>
                                <span class="price"><h6><em>$</em>640</h6></span>
                            </div>
                            <div class="down-content">
                                <span class="author">David Hutson</span>
                                <h4>Latest Web Trends</h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 align-self-center mb-30 event_outer col-md-6 development">
                        <div class="events_item">
                            <div class="thumb">
                                <a href="#"><img src="assets/images/course-04.jpg" alt=""></a>
                                <span class="category">Development</span>
                                <span class="price"><h6><em>$</em>450</h6></span>
                            </div>
                            <div class="down-content">
                                <span class="author">Stella Blair</span>
                                <h4>Online Learning Steps</h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 align-self-center mb-30 event_outer col-md-6 wordpress development">
                        <div class="events_item">
                            <div class="thumb">
                                <a href="#"><img src="assets/images/course-05.jpg" alt=""></a>
                                <span class="category">Wordpress</span>
                                <span class="price"><h6><em>$</em>320</h6></span>
                            </div>
                            <div class="down-content">
                                <span class="author">Sophia Rose</span>
                                <h4>Be a WordPress Master</h4>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 align-self-center mb-30 event_outer col-md-6 wordpress design">
                        <div class="events_item">
                            <div class="thumb">
                                <a href="#"><img src="assets/images/course-06.jpg" alt=""></a>
                                <span class="category">Webdesign</span>
                                <span class="price"><h6><em>$</em>240</h6></span>
                            </div>
                            <div class="down-content">
                                <span class="author">David Hutson</span>
                                <h4>Full Stack Developer</h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div class="section fun-facts">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="wrapper">
                            <div class="row">
                                <div class="col-lg-3 col-md-6">
                                    <div class="counter">
                                        <h2 class="timer count-title count-number" data-to="150" data-speed="1000"></h2>
                                        <p class="count-text ">Happy Students</p>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <div class="counter">
                                        <h2 class="timer count-title count-number" data-to="804" data-speed="1000"></h2>
                                        <p class="count-text ">Course Hours</p>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <div class="counter">
                                        <h2 class="timer count-title count-number" data-to="50" data-speed="1000"></h2>
                                        <p class="count-text ">Employed Students</p>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <div class="counter end">
                                        <h2 class="timer count-title count-number" data-to="15" data-speed="1000"></h2>
                                        <p class="count-text ">Years Experience</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="team section" id="team">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="team-member">
                            <div class="main-content">
                                <img src="assets/images/member-01.jpg" alt="">
                                <span class="category">UX Teacher</span>
                                <h4>Sophia Rose</h4>
                                <ul class="social-icons">
                                    <li><a href="#"><i class="fab fa-facebook"></i></a></li>
                                    <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                                    <li><a href="#"><i class="fab fa-linkedin"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="team-member">
                            <div class="main-content">
                                <img src="assets/images/member-02.jpg" alt="">
                                <span class="category">Graphic Teacher</span>
                                <h4>Cindy Walker</h4>
                                <ul class="social-icons">
                                    <li><a href="#"><i class="fab fa-facebook"></i></a></li>
                                    <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                                    <li><a href="#"><i class="fab fa-linkedin"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="team-member">
                            <div class="main-content">
                                <img src="assets/images/member-03.jpg" alt="">
                                <span class="category">Full Stack Master</span>
                                <h4>David Hutson</h4>
                                <ul class="social-icons">
                                    <li><a href="#"><i class="fab fa-facebook"></i></a></li>
                                    <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                                    <li><a href="#"><i class="fab fa-linkedin"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="team-member">
                            <div class="main-content">
                                <img src="assets/images/member-04.jpg" alt="">
                                <span class="category">Digital Animator</span>
                                <h4>Stella Blair</h4>
                                <ul class="social-icons">
                                    <li><a href="#"><i class="fab fa-facebook"></i></a></li>
                                    <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                                    <li><a href="#"><i class="fab fa-linkedin"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> 

        <div class="section testimonials">
            <div class="container">
                <div class="row">
                    <div class="col-lg-7">
                        <div class="owl-carousel owl-testimonials">
                            <div class="item">
                                <p>“Please tell your friends or collegues about TemplateMo website. Anyone can access the website to download free templates. Thank you for visiting.”</p>
                                <div class="author">
                                    <img src="assets/images/testimonial-author.jpg" alt="">
                                    <span class="category">Full Stack Master</span>
                                    <h4>Claude David</h4>
                                </div>
                            </div>
                            <div class="item">
                                <p>“Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravid.”</p>
                                <div class="author">
                                    <img src="assets/images/testimonial-author.jpg" alt="">
                                    <span class="category">UI Expert</span>
                                    <h4>Thomas Jefferson</h4>
                                </div>
                            </div>
                            <div class="item">
                                <p>“Scholar is free website template provided by TemplateMo for educational related websites. This CSS layout is based on Bootstrap v5.3.0 framework.”</p>
                                <div class="author">
                                    <img src="assets/images/testimonial-author.jpg" alt="">
                                    <span class="category">Digital Animator</span>
                                    <h4>Stella Blair</h4>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5 align-self-center">
                        <div class="section-heading">
                            <h6>TESTIMONIALS</h6>
                            <h2>What they say about us?</h2>
                            <p>You can search free CSS templates on Google using different keywords such as templatemo portfolio, templatemo gallery, templatemo blue color, etc.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="contact-us section" id="contact">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6  align-self-center">
                        <div class="section-heading">
                            <h6>Contact Us</h6>
                            <h2>Feel free to contact us anytime</h2>
                            <p>Thank you for using our service. Please leave us a feedback so that we can improve your experience!</p>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="contact-us-content">
                            <form id="contact-form" action="/contact" method="post">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <fieldset>
                                            <input type="text" name="name" id="name" placeholder="Your Name..." autocomplete="on" required>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-12">
                                        <fieldset>
                                            <input type="text" name="email" id="email" pattern="[^ @]*@[^ @]*" placeholder="Your E-mail..." required="">
                                        </fieldset>
                                    </div>                             
                                    <div class="col-lg-12">
                                        <fieldset>
                                            <input type="text" name="phone" id="phone" pattern="\d{10,15}" placeholder="Your Phone Number" required>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-12">
                                        <fieldset>
                                            <input type="text" name="subject" id="subject" placeholder="Subject of your message" required>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-12">
                                        <fieldset>
                                            <textarea name="message" id="message" placeholder="Your Message" required></textarea>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-12">
                                        <fieldset>
                                            <button type="submit" id="form-submit" class="orange-button">Send Message Now</button>
                                        </fieldset>
                                    </div>
                                    <div class="col-lg-12">
                                        <fieldset>
                                            <p id="result" name="result"></p>
                                        </fieldset>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <footer>
            <div class="container">
                <div class="col-lg-12">
                    <p>Copyright © 2024 FPTU, Group 5. All rights reserved. &nbsp;&nbsp;&nbsp; Design: <a href="https://templatemo.com" rel="nofollow" target="_blank">TemplateMo</a> Distribution: <a href="https://themewagon.com" rel="nofollow" target="_blank">ThemeWagon</a></p>
                </div>
            </div>
        </footer>
        <div class="col-lg-12" bottom="0">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.506341942524!2d105.52271427449699!3d21.012416680632832!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e0!3m2!1svi!2s!4v1716569363263!5m2!1svi!2s" style="border:0;width:100%;height:200px" allowfullscreen loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>


        <!-- Scripts -->
        <!-- Bootstrap core JavaScript -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/bootstrap.min.js"></script>
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/js/isotope.min.js"></script>
        <script src="../assets/js/owl-carousel.js"></script>
        <script src="../assets/js/counter.js"></script>
        <script src="../assets/js/custom.js"></script>
        <script src="../assets/js/contact-form.js"></script>

    </body>
</html>