<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
        <title>Post</title>

        <!-- Bootstrap core CSS -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />

        <!-- Additional CSS Files -->
        <link rel="stylesheet" href="../assets/css/fontawesome.css">
        <link rel="stylesheet" href="../assets/css/templatemo-scholar.css">
        <link rel="stylesheet" href="../assets/css/owl.css">
        <link rel="stylesheet" href="../assets/css/animate.css">
        <link rel="stylesheet" href="../assets/css/style.css">
        <link rel="stylesheet" href="../assets/css/threedots.css">
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
                                <li class="scroll-to-section"><a href="/post">Post</a></li>
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
                <a href="/main/newpost.jsp">
                    <button class="button-80" role="button">Post your post here</button>
                </a>
                <!-- HTML !-->


                <style>
                    .button-80 {
                        background: #fff;
                        backface-visibility: hidden;
                        border-radius: .375rem;
                        border-style: solid;
                        border-width: .125rem;
                        box-sizing: border-box;
                        color: #212121;
                        cursor: pointer;
                        display: inline-block;
                        font-family: Circular,Helvetica,sans-serif;
                        font-size: 1.125rem;
                        font-weight: 700;
                        letter-spacing: -.01em;
                        line-height: 1.3;
                        padding: .875rem 1.125rem;
                        position: relative;
                        text-align: left;
                        text-decoration: none;
                        transform: translateZ(0) scale(1);
                        transition: transform .2s;
                        user-select: none;
                        -webkit-user-select: none;
                        touch-action: manipulation;
                    }

                    .button-80:not(:disabled):hover {
                        transform: scale(1.05);
                    }

                    .button-80:not(:disabled):hover:active {
                        transform: scale(1.05) translateY(.125rem);
                    }

                    .button-80:focus {
                        outline: 0 solid transparent;
                    }

                    .button-80:focus:before {
                        content: "";
                        left: calc(-1*.375rem);
                        pointer-events: none;
                        position: absolute;
                        top: calc(-1*.375rem);
                        transition: border-radius;
                        user-select: none;
                    }

                    .button-80:focus:not(:focus-visible) {
                        outline: 0 solid transparent;
                    }

                    .button-80:focus:not(:focus-visible):before {
                        border-width: 0;
                    }

                    .button-80:not(:disabled):active {
                        transform: translateY(.125rem);
                    }
                </style>
                <!-- post starts -->
                <c:forEach var="post" items="${posts}">
                    <div class="post">
                        <div class="post__top">
                            <img
                                class="user__avatar post__avatar"
                                src="../assets/images/${post.user_id.avatar}"
                                alt=""
                                />
                            <div class="post__topInfo">
                                <h3>${post.user_id.fullName}</h3>
                                <p>${post.post_at}</p>
                            </div>
                            <c:if test="${sessionScope.user.id == post.user_id.id}">
                            <div class="dropdown">
                                <button class="dropbtn"  > . . .</button>
                                <div class="dropdown-content">
                                        <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deletePost${post.post_id}">
                                            Delete
                                        </button>
                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updatePost${post.post_id}">
                                            Edit
                                        </button>
                                </div>
                            </div>
                            </c:if>

                        </div>

                        <div class="post__bottom">
                            <h2>${post.title}</h2>
                            <p>${post.content}</p>
                        </div>

                        <div class="post__image">
                            <img
                                src="https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2Fyc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80"
                                alt=""
                                />
                        </div>

                        <div class="post__options">
                            <div class="post__option">
                                <span class="material-icons"> thumb_up </span>
                                <p>Like</p>
                            </div>

                            <div class="post__option">
                                <span class="material-icons"> chat_bubble_outline </span>
                                <input type="hidden" name="post_id" id="post_id" value="${post.post_id}">
                                <a href="/comment?post_id=${post.post_id}">Comment</a>
                            </div>

                            <div class="post__option">
                                <span class="material-icons"> near_me </span>
                                <p>Share</p>
                            </div>
                        </div>
                    </div>
                    <!-- Delete Modal -->
                    <div class="modal fade" id="deletePost${post.post_id}" tabindex="-1" aria-labelledby="deletePostLabel${post.post_id}" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="deleteSubjectLabel${post.post_id}">Confirmation</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body text-danger-emphasis">
                                    Do you want to delete this post?
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-primary" data-bs-dismiss="modal">No</button>
                                    <a href="/post/delete?id=${post.post_id}" class="btn btn-warning">Yes</a>
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
                    <form action="/post/update" method="post">
                        <div class="modal fade" id="updatePost${post.post_id}" tabindex="-1" aria-labelledby="updatePostLabel${post.post_id}" aria-hidden="true">
                            <div class="modal-dialog modal-xl modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header border-bottom p-3">
                                        <h5 class="modal-title" id="updatePostLabel${post.post_id}">${post.title}</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body p-3 pt-4">
                                        <div class="post">                                                 
                                            <div class="post__bottom">
                                                <input name="title" id="title" value="${post.title}" required>
                                                <input name="content" id="content" value="${post.content}" required>
                                            </div>

                                            <div class="post__image">
                                                <img
                                                    src="https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2Fyc3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80"
                                                    alt=""
                                                    />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <input type="hidden" name="id" value="${post.post_id}">
                                            <input type="hidden" name="user_id" value="${post.user_id.getId()}"> 
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

                </c:forEach>
                <!-- post ends -->
            </div>
            <div class="col-md-3">
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
    <script src="../assets/js/script.js"></script>

</body>
</html>