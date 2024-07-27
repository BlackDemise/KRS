<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
        <div class="sidebar-brand">
            <a href="#">
                <img src="${pageContext.request.contextPath}/assets/images/logo-dark.jpg" height="24" class="logo-light-mode" alt="">
                <img src="${pageContext.request.contextPath}/assets/images/logo-white.png" height="24" class="logo-dark-mode" alt="">
            </a>
        </div>

        <nav id="sidebar" class="sidebar-wrapper">
            <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                <div class="sidebar-brand">
                    <a href="../landing/index-two.html" class="d-flex justify-content-center align-items-center">
                        <!--<a href="index.html">-->
                        <img src="../assets/images/logo-white.png" height="54" width="140" class="logo-light-mode" alt="">
                        <img src="../assets/images/logo-white.png" height="54" width="140" class="logo-dark-mode" alt="">
                    </a>
                </div>
                <c:choose>

                    <c:when test="${sessionScope.user.role.title.userRole == 'Administrator'}">
                        <ul class="sidebar-menu pt-3">
                            <li><a href="/dashboard"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Settings</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="/user-settings">User Settings</a></li>
                                        <li><a href="/subject-settings">Subject Settings</a></li>
                                        <li><a href="/class-settings">Class Settings</a></li>
                                        <li><a href="/exam-settings">Exam Settings</a></li> 
                                    </ul>
                                </div>
                            </li>     

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Blogs</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="blogs.html">Blogs</a></li>
                                        <li><a href="blog-detail.html">Blog Detail</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>My Profile</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="/user/profile">Credentials</a></li>
                                        <li><a href="/user/change-password">Password</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Users</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/user">All Users</a></li>
                                        <li><a href="${pageContext.request.contextPath}/user/add">Add User</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Subjects</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/subject">All Subjects</a></li>
                                        <li><a href="${pageContext.request.contextPath}/subject/add">Add Subject</a></li>
                                        <li><a href="${pageContext.request.contextPath}/subject/manager">Subject Manager</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Classes</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/class">All Classes</a></li>
                                        <li><a href="${pageContext.request.contextPath}/class/add">Add Class</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Lesson</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/lesson">All Lessons</a></li>
                                        <li><a href="${pageContext.request.contextPath}/lesson/add">Add Lesson</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li><a href="/exam-history"><i class="uil uil-dashboard me-2 d-inline-block"></i>Exam History</a></li>
                        </ul>
                    </c:when>

                    <c:when test="${sessionScope.user.role.title.userRole == 'Manager'}">
                        <ul class="sidebar-menu pt-3">
                            <li><a href="/dashboard"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Settings</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="/subject-settings">Subject Settings</a></li>
                                        <li><a href="/class-settings">Class Settings</a></li>
                                        <li><a href="/exam-settings">Exam Settings</a></li> 
                                    </ul>
                                </div>
                            </li>      

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Blogs</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="blogs.html">Blogs</a></li>
                                        <li><a href="blog-detail.html">Blog Detail</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>My Profile</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="/user/profile">Credentials</a></li>
                                        <li><a href="/user/change-password">Password</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li>
                                <a href="${pageContext.request.contextPath}/user"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Users</a>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Subjects</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/subject">All Subjects</a></li>
                                        <li><a href="${pageContext.request.contextPath}/subject/add">Add Subject</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Classes</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/class">All Classes</a></li>
                                        <li><a href="${pageContext.request.contextPath}/class/add">Add Class</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Lesson</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/lesson">All Lessons</a></li>
                                        <li><a href="${pageContext.request.contextPath}/lesson/add">Add Lesson</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li><a href="/exam-history"><i class="uil uil-dashboard me-2 d-inline-block"></i>Exam History</a></li>
                        </ul>
                    </c:when>

                    <c:when test="${sessionScope.user.role.title.userRole == 'Teacher'}">
                        <ul class="sidebar-menu pt-3">
                            <li><a href="/dashboard"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Settings</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="/class-settings">Class Settings</a></li>
                                        <li><a href="/exam-settings">Exam Settings</a></li> 
                                    </ul>
                                </div>
                            </li> 

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Blogs</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="blogs.html">Blogs</a></li>
                                        <li><a href="blog-detail.html">Blog Detail</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>My Profile</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="/user/profile">Credentials</a></li>
                                        <li><a href="/user/change-password">Password</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li>
                                <a href="${pageContext.request.contextPath}/user"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Users</a>
                            </li>

                            <li>
                                <a href="${pageContext.request.contextPath}/subject"><i class="uil uil-apps me-2 d-inline-block"></i>Subjects</a>
                            </li>

                            <li>
                                <a href="${pageContext.request.contextPath}/class"><i class="uil uil-apps me-2 d-inline-block"></i>Classes</a>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Lesson</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/lesson">All Lessons</a></li>
                                        <li><a href="${pageContext.request.contextPath}/lesson/add">Add Lesson</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Flashcard</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="/flashcard/all-flashcard">All Flashcard</a></li>
                                        <li><a href="/flashcard/my-flashcard">My Flashcard</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li><a href="/exam-history"><i class="uil uil-dashboard me-2 d-inline-block"></i>Exam History</a></li>
                        </ul>
                    </c:when>

                    <c:when test="${sessionScope.user.role.title.userRole == 'Student'}">
                        <ul class="sidebar-menu pt-3">
                            <li><a href="/dashboard"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Blogs</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="/blog">Blogs</a></li>
                                        <li><a href="/blog/details">Blog Details</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>My Profile</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="/user/profile">Credentials</a></li>
                                        <li><a href="/user/change-password">Password</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li>
                                <a href="/my-subjects"><i class="uil uil-user me-2 d-inline-block"></i>My Subjects</a>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Flashcard</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="/flashcard/all-flashcard">All Flashcard</a></li>
                                        <li><a href="/flashcard/my-flashcard">My Flashcard</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li><a href="/exam-history"><i class="uil uil-dashboard me-2 d-inline-block"></i>Exam History</a></li>

                        </c:when>

                    </c:choose>
            </div>
        </nav>
    </div>
</nav>