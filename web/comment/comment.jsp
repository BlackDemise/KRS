<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <link rel="shortcut icon" href="../assets/images/favicon.png">
        <title>Comment Section</title>
        <!-- Load Bootstrap CSS from CDN -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
        <!-- Load Font Awesome CSS from CDN -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../assets/css/fontawesome.css">
        <link rel="stylesheet" href="../assets/css/templatemo-scholar.css">
        <link rel="stylesheet" href="../assets/css/owl.css">
        <link rel="stylesheet" href="../assets/css/animate.css">
        <link rel="stylesheet" href="../assets/css/style.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <style>
            .shadow-0 {
                box-shadow: none !important;
            }
            .text-black {
                color: black !important;
            }
            .comment-header {
                display: flex;
                justify-content: space-between;
            }
        </style>
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
                                        <li class="scroll-to-section"><a href="/main/register.jsp">Register</a></li>
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
                                                    <a class="dropdown-item text-dark" href="/admin/profile.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
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
                <div class="container mt-5" style="max-width: 1000px;">
                    <div class="row justify-content-center">
                        <div class="col-md-8 col-lg-6">
                            <div class="card shadow-0 border" style="background-color: #f0f2f5;">
                                <div class="card-body">
                                    <div class="mb-4">
                                        <form id="postForm" method="POST" action="/comment/add?post_id=${post_id}">
                                            <input type="text" id="content" name="content" class="form-control" placeholder="Type comment..." required>
                                            <button type="submit" class="center-button">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
                                                <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576zm6.787-8.201L1.591 6.602l4.339 2.76z"/>
                                                </svg>
                                                Send
                                            </button>
                                        </form>
                                        <c:if test="${not empty error}">
                                            <div class="alert alert-danger">${error}</div>
                                        </c:if>
                                    </div>
                                    <c:forEach var="com" items="${coms}">
                                        <div class="card mb-4">
                                            <div class="card-body">
                                                <div class="comment-header">
                                                    <p>${com.content}</p>
                                                    <c:if test="${sessionScope.user.id == com.user_id.id}">
                                                        <div class="dropdown">
                                                            <button class="btn btn-link dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                                                <i class="fas fa-ellipsis-v"></i>
                                                            </button>
                                                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                                                <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#updateComment${com.comment_id}">Edit</a></li>
                                                                <li><a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#deleteComment${com.comment_id}">Delete</a></li>
                                                            </ul>
                                                        </div>
                                                    </c:if>
                                                    <!-- Delete Modal -->
                                                    <div class="modal fade" id="deleteComment${com.comment_id}" tabindex="-1" aria-labelledby="deleteCommentLabel${com.comment_id}" aria-hidden="true">
                                                        <div class="modal-dialog modal-dialog-centered">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h1 class="modal-title fs-5" id="deleteCommentLabel${com.comment_id}">Confirmation</h1>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <div class="modal-body text-danger-emphasis">
                                                                    Do you want to delete this comment?
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button class="btn btn-primary" data-bs-dismiss="modal">No</button>
                                                                    <a href="/comment/delete?id=${com.comment_id}" class="btn btn-warning">Yes</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- End Delete Modal -->
                                                    <!-- subModal Delete start -->

                                                    <div class="toast-container position-fixed bottom-0 end-0 p-3">
                                                        <%
                                                            String deleted = request.getParameter("deleted");
                                                            if ("yes".equals(deleted) || "no".equals(deleted)) {
                                                        %>
                                                        <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                                                            <div class="toast-header">
                                                                <img src="../assets/images/favicon.ico.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                                                                <strong class="me-auto">KRS System</strong>
                                                                <small class="mt-1">A few seconds ago</small>
                                                                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                                                            </div>
                                                            <%
                                                                if ("yes".equals(deleted)) {
                                                            %>
                                                            <div class="toast-body text-success-emphasis">
                                                                Deleted successfully!
                                                            </div>
                                                            <% 
                                                                } else {
                                                            %>
                                                            <div class="toast-body text-danger-emphasis">
                                                                Deleted failed!
                                                            </div>
                                                            <%
                                                                }    
                                                            %>

                                                        </div>
                                                        <%
                                                            }
                                                        %>
                                                    </div>
                                                    <!-- subModal Delete end -->

                                                    <!-- Modal Update start -->
                                                    <form action="/comment/update" method="post">
                                                        <div class="modal fade" id="updateComment${com.comment_id}" tabindex="-1" aria-labelledby="updateCommentLabel${com.comment_id}" aria-hidden="true">
                                                            <div class="modal-dialog modal-xl modal-dialog-centered">
                                                                <div class="modal-content">
                                                                    <div class="modal-header border-bottom p-3">
                                                                        <h5 class="modal-title" id="updateCommentLabel${com.comment_id}"></h5>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body p-3 pt-4">
                                                                        <div class="card mb-4">
                                                                            <div class="card-body">
                                                                                <div class="comment-header">
                                                                                    <input id="content" name="content" value="${com.content}">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                                <div class="row">
                                                                                    <div class="col-sm-12">
                                                                                        <input type="hidden" name="id" value="${com.comment_id}">
                                                                                        <input type="hidden" name="user_id" value="${com.user_id.id}"> 
                                                                                        <button type="submit" class="btn btn-primary">Save change</button>
                                                                                    </div><!--end col-->
                                                                                </div><!--end row-->
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    </form>


                                                                    <!-- End Update Details Modal -->
                                                                    <div class="toast-container position-fixed bottom-0 end-0 p-3">
                                                                        <%
                                                                            String updated = request.getParameter("updated");
                                                                            if ("yes".equals(updated) || "no".equals(updated)) {
                                                                        %>
                                                                        <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                                                                            <div class="toast-header">
                                                                                <img src="../assets/images/favicon.ico.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                                                                                <strong class="me-auto">KRS System</strong>
                                                                                <small class="mt-1">A few seconds ago</small>
                                                                                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                                                                            </div>
                                                                            <%
                                                                                if ("yes".equals(updated)) {
                                                                            %>
                                                                            <div class="toast-body text-success-emphasis">
                                                                                Updated successfully!
                                                                            </div>
                                                                            <% 
                                                                                } else {
                                                                            %>
                                                                            <div class="toast-body text-danger-emphasis">
                                                                                updated failed!
                                                                            </div>
                                                                            <%
                                                                                }    
                                                                            %>

                                                                        </div>
                                                                        <%
                                                                            }
                                                                        %>
                                                                    </div>
                                                                    <!-- subModal Update end -->


                                                                </div>
                                                                <div class="d-flex justify-content-between">
                                                                    <div class="d-flex flex-row align-items-center">
                                                                        <img src="../assets/images/${com.user_id.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="avatar" >
                                                                        <div>
                                                                            <p class="small mb-0 ms-2" style="font-size: 0.875rem;">${com.user_id.fullName}</p>
                                                                            <p class="small mb-0 ms-2" style="font-size: 0.75rem;">${com.created_at}</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="d-flex flex-row align-items-center">
                                                                        <p class="small text-muted mb-0">Upvote?</p>
                                                                        <i class="far fa-thumbs-up mx-2 fa-xs text-black" style="margin-top: -0.16rem;"></i>
                                                                        <p class="small text-muted mb-0">3</p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                            </div>
                                        </div>
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
                    <!-- Load jQuery from CDN -->
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
                    <!-- Load Bootstrap JavaScript from CDN -->
                    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
                    <!-- Additional Scripts -->
                    <script src="../assets/js/jquery.min.js"></script>
                    <script src="../assets/js/bootstrap.min.js"></script>
                    <script src="../assets/js/bootstrap.bundle.min.js"></script>
                    <script src="../assets/js/isotope.min.js"></script>
                    <script src="../assets/js/owl-carousel.js"></script>
                    <script src="../assets/js/counter.js"></script>
                    <script src="../assets/js/custom.js"></script>
                    <script src="../assets/js/contact-form.js"></script>
                    <script src="../assets/js/script.js"></script>
                    </body>
                    </html>
