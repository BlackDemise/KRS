<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>FPT University Learning Website</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.png">
        <!-- Bootstrap -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- SLIDER -->
        <link rel="stylesheet" href="../assets/css/tiny-slider.css"/>
        <!-- Select2 -->
        <link href="../assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="../assets/css/flatpickr.min.css">
        <link href="../assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- CSS -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>

    <body>
        <jsp:include page="../loader/loader.jsp"/>

        <!-- Navbar Start -->
        <header id="topnav" class="defaultscroll sticky">
            <div class="container">
                <!-- Logo container-->
                <div>
                    <span class="logo">
                        <span class="logo-light-mode">
                            <img src="../assets/images/logo-white.png" class="l-dark" width="120" height="48" alt="">
                            <img src="../assets/images/logo-white.png" class="l-light" width="120" height="48" alt="">
                        </span>
                        <img src="../assets/images/logo-white.png" height="24" class="logo-dark-mode" alt="">
                    </span>
                </div>
                <!-- End Logo container-->

                <!-- Start Mobile Toggle -->
                <div class="menu-extras">
                    <div class="menu-item">
                        <!-- Mobile menu toggle-->
                        <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                            <div class="lines">
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                        </a>
                        <!-- End mobile menu toggle-->
                    </div>
                </div>
                <!-- End Mobile Toggle -->

                <!-- Start Dropdown -->
                <ul class="dropdowns list-inline mb-0">
                    <c:choose>
                        <c:when test="${sessionScope.user == null}">
                            <li class="list-inline-item mb-0 ms-1">
                                <div class="dropdown dropdown-primary">
                                    <button type="button" class="btn btn-pills btn-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="width:40px;height:40px"><i class="uil uil-user"></i></button>
                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 100px;">
                                        <a class="dropdown-item text-dark" href="/login"><span class="mb-0 d-inline-block me-1"><i class="uil uil-signin align-middle h6"></i></span> Login</a>
                                        <div class="dropdown-divider border-top"></div>
                                        <a class="dropdown-item text-dark" href="/register"><span class="mb-0 d-inline-block me-1"><i class="uil uil-user-plus align-middle h6"></i></span> Register</a>
                                    </div>
                                </div>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="list-inline-item mb-0 ms-1">
                                <div class="dropdown dropdown-primary">
                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="../assets/images/${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt=""></button>
                                    <div class="dropdown-menu dd-menu dropdown-menu-start bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                        <a class="dropdown-item d-flex align-items-center text-dark" href="/user/profile">
                                            <img src="../assets/images/${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="flex-1 ms-2">
                                                <span class="d-block mb-1">${sessionScope.user.fullName}</span>
                                                <small class="text-muted">${sessionScope.user.role.title.userRole}</small>
                                            </div>
                                        </a>
                                        <a class="dropdown-item text-dark" href="/dashboard"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                        <a class="dropdown-item text-dark" href="/user/profile"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                        <div class="dropdown-divider border-top"></div>
                                        <a class="dropdown-item text-dark" href="/logout"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                                    </div>
                                </div>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <!-- Start Dropdown -->

                <div id="navigation">
                    <!-- Navigation Menu-->   
                    <ul class="navigation-menu nav-left nav-light">
                        <li>
                            <a href="/">Home</a></span> 
                        </li>

                        <li>
                            <a href="/blog">Blog</a></span> 
                        </li>

                        <li class="has-submenu parent-parent-menu-item">
                            <a href="javascript:void(0)">Subjects</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li>
                                    <a href="javascript:void(0)" class="menu-item"> Information Technology </a>
                                </li>
                                <li><a href="doctor-team-one.html" class="sub-menu-item">Economics</a></li>
                                <li><a href="doctor-team-two.html" class="sub-menu-item">Language</a></li>
                            </ul>
                        </li>

                        <li class="has-submenu parent-menu-item">
                            <a href="javascript:void(0)">Teachers</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="patient-dashboard.html" class="sub-menu-item">Professor</a></li>
                                <li><a href="patient-profile.html" class="sub-menu-item">Senior Lecturer</a></li>
                                <li><a href="booking-appointment.html" class="sub-menu-item">Lecturer</a></li>
                            </ul>
                        </li>
                    </ul><!--end navigation menu-->
                </div><!--end navigation-->
            </div><!--end container-->
        </header><!--end header-->
        <!-- Navbar End -->

        <!-- Start Hero -->
        <section class="bg-half-170 d-table w-100" id="home">
            <div class="bg-overlay bg-overlay-dark"></div>
            <div class="container">
                <div class="row justify-content-center mt-5">
                    <div class="col-xl-10">
                        <div class="heading-title text-center">
                            <img src="../assets/images/logo-white.png" height="90" width="180" alt="">
                            <h4 class="heading fw-bold text-white title-dark mt-3 mb-4">FPT University Learning Website</h4>
                            <p class="para-desc mx-auto text-white-50 mb-0">This is a great place for FPT University students to revise their knowledge and seek for support from professional teachers.</p>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- End Hero -->

        <!-- Start -->
        <section class="section py-5 bg-light">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <div class="d-flex">
                            <i class="uil uil-briefcase h1 mb-0 text-primary"></i>
                            <div class="ms-3 ms-lg-4">
                                <h5>Our Mission</h5>
                                <p class="text-muted mb-0">We want to bring all the students in FPTU altogether for learning, sharing knowledge and experience.</p>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-md-6 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <div class="d-flex">
                            <i class="uil uil-flip-v h1 mb-0 text-primary"></i>
                            <div class="ms-3 ms-lg-4">
                                <h5>Who We Are ?</h5>
                                <p class="text-muted mb-0">We are a FPTU student group dedicating to make this website for all the students here to learn.</p>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- End -->

        <!-- Start -->
        <section class="section bg-white pb-0">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-5 col-md-6">
                        <div class="position-relative">
                            <img src="../assets/images/about/about-2.jpg" class="img-fluid" alt="">
                            <div class="play-icon">
                                <a href="#" data-bs-toggle="modal" data-bs-target="#watchvideomodal" class="play-btn video-play-icon">
                                    <i class="mdi mdi-play text-primary rounded-circle bg-white title-bg-dark shadow"></i>
                                </a>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-lg-7 col-md-6 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <div class="section-title ms-lg-5">
                            <span class="badge badge-pill badge-soft-primary">About FPTU</span>
                            <h4 class="title mt-3 mb-4">Great place to begin your future</h4>
                            <p class="para-desc text-muted">FPT University (FPTU), established by FPT Corporation in 2006, is a leading private university in Vietnam. It specializes in information technology, business, and engineering education, emphasizing practical skills and global integration. FPTU is renowned for its innovative curriculum, international partnerships, and high graduate employment rates.</p>
                            <div class="mt-4">
                                <a href="aboutus.html" class="btn btn-soft-primary">Read More</a>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->

            <div class="container mt-100 mt-60">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title mb-4 pb-2 text-center">
                            <span class="badge badge-pill badge-soft-primary mb-3">Subjects</span>
                            <h4 class="title mb-4">Our Categories</h4>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row">
                    <div class="col-xl-4 col-md-6 col-12 mt-5">
                        <div class="card features feature-primary bg-transparent border-0">
                            <div class="icon text-center rounded-md">
                                <i class="ri-microscope-fill h3 mb-0"></i>
                            </div>
                            <div class="card-body p-0 mt-3">
                                <a href="departments.html" class="title text-dark h5">Language</a>
                                <p class="text-muted mt-3">Language studies explore the structure, evolution, and usage of human languages, covering linguistics, literature, communication, and cultural expression.</p>
                                <a href="departments.html" class="link">Read More <i class="ri-arrow-right-line align-middle"></i></a>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl-4 col-md-6 col-12 mt-5">
                        <div class="card features feature-primary bg-transparent border-0">
                            <div class="icon text-center rounded-md">
                                <i class="ri-pulse-fill h3 mb-0"></i>
                            </div>
                            <div class="card-body p-0 mt-3">
                                <a href="departments.html" class="title text-dark h5">Information Technology</a>
                                <p class="text-muted mt-3">Information Technology (IT) encompasses the study and application of computer systems, networks, and software to manage and process data efficiently.</p>
                                <a href="departments.html" class="link">Read More <i class="ri-arrow-right-line align-middle"></i></a>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl-4 col-md-6 col-12 mt-5">
                        <div class="card features feature-primary bg-transparent border-0">
                            <div class="icon text-center rounded-md">
                                <i class="ri-empathize-fill h3 mb-0"></i>
                            </div>
                            <div class="card-body p-0 mt-3">
                                <a href="departments.html" class="title text-dark h5">Economics</a>
                                <p class="text-muted mt-3">Economics examines how societies allocate scarce resources to meet human needs and desires, studying markets, production, consumption, and economic policies.</p>
                                <a href="departments.html" class="link">Read More <i class="ri-arrow-right-line align-middle"></i></a>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-12 mt-5 d-flex justify-content-center align-items-center">
                        <div class="card features feature-primary bg-transparent border-0">
                            <div class="card-body p-0 mt-3">
                                <p class="text-muted mt-3">And more are coming!</p>
                            </div>
                        </div>
                    </div><!--end col-->

                </div><!--end row-->
            </div><!--end container-->
        </section>
        <!-- End -->

        <!-- Start -->
        <section class="section bg-white">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center mb-4 pb-2">
                            <h4 class="title mb-4">Teachers</h4>
                            <p class="text-muted mx-auto para-desc mb-0">Our university boasts a distinguished faculty renowned for their expertise, fostering rigorous academic inquiry and intellectual growth among students.</p>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row align-items-center">
                    <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-img position-relative">
                                <img src="../assets/images/default_avatar.png" class="img-fluid" alt="">
                            </div>
                            <div class="card-body content text-center">
                                <a href="doctor-team-one.html" class="title text-dark h5 d-block mb-0">Vương Minh Tuấn</a>
                                <small class="text-muted speciality">Information Technology</small>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-img position-relative">
                                <img src="../assets/images/default_avatar.png" class="img-fluid" alt="">

                            </div>
                            <div class="card-body content text-center">
                                <a href="doctor-team-one.html" class="title text-dark h5 d-block mb-0">Nguyễn Trung Kiên</a>
                                <small class="text-muted speciality">Information Technology</small>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-img position-relative">
                                <img src="../assets/images/default_avatar.png" class="img-fluid" alt="">

                            </div>
                            <div class="card-body content text-center">
                                <a href="doctor-team-one.html" class="title text-dark h5 d-block mb-0">Giang Thị Thanh Nhã</a>
                                <small class="text-muted speciality">Japanese Language</small>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-img position-relative">
                                <img src="../assets/images/default_avatar.png" class="img-fluid" alt="">

                            </div>
                            <div class="card-body content text-center">
                                <a href="doctor-team-one.html" class="title text-dark h5 d-block mb-0">Tạ Thanh Huyền</a>
                                <small class="text-muted speciality">Japanese Language</small>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->

            <div class="container mt-100 mt-60">
                <div class="row align-items-lg-end">
                    <div class="col-md-6">
                        <div class="me-xl-3">
                            <div class="section-title mb-4 pb-2">
                                <i class="uil uil-notes text-primary h2"></i>
                                <h4 class="title mb-4">Contact Us</h4>
                                <p class="text-muted para-desc mb-0">We value your feedback! Please contact us for anything which can help improve your experience.</p>
                            </div>

                            <div class="features feature-bg-primary d-flex bg-white p-4 rounded-md shadow position-relative overflow-hidden">
                                <i class="uil uil-stethoscope-alt icons h2 mb-0 text-primary"></i>
                                <div class="ms-3">
                                    <h5 class="titles">Modern Technology</h5>
                                    <p class="text-muted para mb-0">Our university integrates cutting-edge technology into teaching practices, enhancing learning experiences through innovative digital tools and methodologies.</p>
                                </div>
                                <div class="big-icon">
                                    <i class="uil uil-stethoscope-alt"></i>
                                </div>
                            </div>

                            <div class="features feature-bg-primary d-flex bg-white p-4 rounded-md shadow position-relative overflow-hidden mt-4">
                                <i class="uil uil-microscope icons h2 mb-0 text-primary"></i>
                                <div class="ms-3">
                                    <h5 class="titles">Professional Teachers</h5>
                                    <p class="text-muted para mb-0">Our university is distinguished by its exceptional faculty, comprising dedicated educators committed to academic excellence and student development.</p>
                                </div>
                                <div class="big-icon">
                                    <i class="uil uil-microscope"></i>
                                </div>
                            </div>

                            <div class="features feature-bg-primary d-flex bg-white p-4 rounded-md shadow position-relative overflow-hidden mt-4">
                                <i class="uil uil-user-md icons h2 mb-0 text-primary"></i>
                                <div class="ms-3">
                                    <h5 class="titles">High Employment Rate</h5>
                                    <p class="text-muted para mb-0">Our university achieves a high post-graduation employment rate, preparing students effectively for career success in their chosen fields.</p>
                                </div>
                                <div class="big-icon">
                                    <i class="uil uil-user-md"></i>
                                </div>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-md-6 mt-4 mt-sm-0 pt-2 pt-sm-0">
                        <div class="card border-0 rounded shadow p-4 ms-xl-3">
                            <div class="custom-form">
                                <form id="contact-form" action="/contact" method="post">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Your Name <span class="text-danger">*</span></label>
                                                <input type="text" name="name" id="name" placeholder="Your Name..." class="form-control" required value="${sessionScope.user.fullName}" ${sessionScope.user != null? 'disabled' : ''}>
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                                <input type="text" name="email" id="email" pattern="[^ @]*@[^ @]*" placeholder="Your E-mail..." required class="form-control" value="${sessionScope.user.email}" ${sessionScope.user != null? 'disabled' : ''}>
                                            </div> 
                                        </div><!--end col-->

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Your Phone <span class="text-danger">*</span></label>
                                                <input type="text" name="phone" id="phone" pattern="\d{10,15}" placeholder="Your Phone..." required class="form-control"  value="${sessionScope.user.phoneNumber}" ${sessionScope.user != null? 'disabled' : ''}>
                                            </div> 
                                        </div><!--end col-->

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label"> Your Message Subject <span class="text-danger">*</span></label>
                                                <input type="text" name="subject" id="subject" placeholder="Your Message Subject..." required class="form-control">
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Your Message <span class="text-danger">*</span></label>
                                                <textarea name="message" id="message" rows="4" placeholder="Your Message" required class="form-control"></textarea>
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-lg-12">
                                            <div class="d-grid">
                                                <button type="submit" class="btn btn-primary">Contact</button>
                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </form>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- End -->

        <jsp:include page="/footer/footer1.jsp"/>

        <!-- Back to top -->
        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
        <!-- Back to top -->

        <!-- Modal Start -->
        <div class="modal fade" id="watchvideomodal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content video-modal rounded overflow-hidden">
                    <iframe id="videoIframe" height="400" src="https://www.youtube.com/embed/XCOWhO09ewk"></iframe>
                </div>
            </div>
        </div>
        <!-- Modal End -->

        <c:choose>
            <c:when test="${param.logout == 'true'}">
                <div class="toast-container position-fixed bottom-0 end-0 p-3">
                    <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                        <div class="toast-header">
                            <img src="../assets/images/favicon.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                            <strong class="me-auto">FPT University KRS</strong>
                            <small class="mt-1">A few seconds ago</small>
                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <div class="toast-body text-danger">
                            You have logged out successfully!
                        </div>
                    </div>
                </div>
            </c:when>
        </c:choose>
        
        <c:choose>
            <c:when test="${param.changed == 'successful'}">
                <div class="toast-container position-fixed bottom-0 end-0 p-3">
                    <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                        <div class="toast-header">
                            <img src="../assets/images/favicon.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                            <strong class="me-auto">FPT University KRS</strong>
                            <small class="mt-1">A few seconds ago</small>
                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <div class="toast-body text-success">
                            Password was changed successfully! Please login again.
                        </div>
                    </div>
                </div>
            </c:when>
        </c:choose>
        
        <!-- Modal -->
        <div class="modal fade" id="contactResultModal" tabindex="-1" role="dialog" aria-labelledby="contactResultModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="contactResultModalLabel">Contact Us</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="modalMessage"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- javascript -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="../assets/js/tiny-slider.js"></script>
        <script src="../assets/js/tiny-slider-init.js"></script>
        <script src="../assets/js/easy_background.js"></script>
        <!-- Select2 -->
        <script src="../assets/js/select2.min.js"></script>
        <script src="../assets/js/select2.init.js"></script>
        <!-- Datepicker -->
        <script src="../assets/js/flatpickr.min.js"></script>
        <script src="../assets/js/flatpickr.init.js"></script>
        <!-- Datepicker -->
        <script src="../assets/js/jquery.timepicker.min.js"></script> 
        <script src="../assets/js/timepicker.init.js"></script> 
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>
        <script src="../assets/js/contact-form.js"></script>
        <script>
            easy_background("#home",
                    {
                        slide: ["../assets/images/1.jpg", "../assets/images/2.png", "../assets/images/3.jpeg"],
                        delay: [3000, 3000, 3000]
                    }
            );
        </script>
        <script>
            const toastTrigger = document.getElementById('liveToastBtn');
            const toastLiveExample = document.getElementById('liveToast');

            if (toastTrigger) {
                const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample);
                toastTrigger.addEventListener('click', () => {
                    toastBootstrap.show();
                });
            }
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var toastEl = document.getElementById('liveToast');
                if (toastEl) {
                    var toast = new bootstrap.Toast(toastEl, {
                        delay: 3000
                    });
                    toast.show();
                }
            });
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var modal = document.getElementById('watchvideomodal');
                var iframe = document.getElementById('videoIframe');

                modal.addEventListener('hidden.bs.modal', function () {
                    var src = iframe.src;
                    iframe.src = '';
                    iframe.src = src;
                });
            });
        </script>
    </body>

</html>
