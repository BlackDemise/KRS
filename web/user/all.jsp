<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="repository.impl.UserRepositoryImpl"%>
<%@page import="java.util.List"%>
<%@page import="entity.User"%>
<%@page import="service.impl.UserServiceImpl"%>
<%@page import="repository.impl.RoleRepositoryImpl" %>
<%@page import="constant.EUserStatus"%>
<%
    int currentPage = 1;
    int itemsPerPage = 4; // Default items per page
    
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }
    
    if (request.getParameter("itemsPerPage") != null) {
        itemsPerPage = Integer.parseInt(request.getParameter("itemsPerPage"));
    }
    
    String searchQuery = request.getParameter("searchQuery");
    if (searchQuery != null && !searchQuery.isEmpty()) {
        searchQuery = "%" + searchQuery + "%";
    } else {
        searchQuery = "%%";
    }
    
    UserServiceImpl userService = UserServiceImpl.getInstance();
    List<User> users = userService.findAllWithPaging(itemsPerPage, currentPage, searchQuery);
    int totalUsers = userService.countUsers(searchQuery);
    int totalPages = (int) Math.ceil((double) totalUsers / itemsPerPage);
    
    request.setAttribute("totalUsers", totalUsers);
    request.setAttribute("users", users);
    request.setAttribute("currentPage", currentPage);
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("itemsPerPage", itemsPerPage);
    RoleRepositoryImpl rri = RoleRepositoryImpl.getInstance();
    request.setAttribute("roles", rri.findAll());
    request.setAttribute("statuses", EUserStatus.values()); 
%>


<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>All Users</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="../../../index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.png">
        <!-- Bootstrap -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="../assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="../assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="../assets/css/flatpickr.min.css">
        <link href="../assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>

    <body>
        <jsp:include page="../loader/loader.jsp"/>

        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../navbar/vertical.jsp"/>

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="../navbar/horizontal.jsp"/>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">All Users</h5>
                                <div class="col-md-6">
                                    <form class="d-flex" action='/user' method='get'>
                                        <input class="form-control me-2" type="search" placeholder="Enter email:" aria-label="Search" name='searchQuery' value="${param.searchQuery}">
                                        <button type='submit' class='btn btn-primary'>Search</button>
                                    </form>
                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive bg-white shadow rounded">
                                    <table class="table mb-0 table-center">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3" style="min-width: 10%;">Id</th>
                                                <th class="border-bottom p-3" style="min-width: 30%;">Full Name</th>
                                                <th class="border-bottom p-3" style="min-width: 30%;">Email</th>
                                                <th class="border-bottom p-3" style="min-width: 10%;">Role</th>
                                                <th class="border-bottom p-3" style="min-width: 20%">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="u" items="${users}">
                                                <tr>
                                                    <td class="p-3">${u.id}</td>
                                                    <td class="p-3">
                                                        <a href="#" class="text-dark">
                                                            <div class="d-flex align-items-center">
                                                                <img src="../assets/images/${u.avatar}" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                                <span class="ms-2">${u.fullName}</span>
                                                            </div>
                                                        </a>
                                                    </td>
                                                    <td class="p-3">${u.email}</td>
                                                    <td class="p-3">${u.role.title.userRole}</td>
                                                    <td class="text-start p-3">
                                                        <a href="#" class="btn btn-icon btn-pills btn-soft-success" data-bs-toggle="modal" data-bs-target="#updateUserProfile${u.id}"><i class="uil uil-edit"></i></a>
                                                        <a href="#" class="btn btn-icon btn-pills btn-soft-danger" data-bs-toggle="modal" data-bs-target="#toggleUser${u.id}">
                                                            <c:choose>
                                                                <c:when test="${'active'.equals(u.userStatus.userStatus.toLowerCase())}">
                                                                    <i class="uil uil-lock"></i>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="uil uil-unlock"></i>
                                                                </c:otherwise>
                                                            </c:choose>

                                                        </a>
                                                    </td>
                                                </tr>
                                                <!--START MODAL-->
                                                <!-- Delete Modal -->
                                            <div class="modal fade" id="toggleUser${u.id}" tabindex="-1" aria-labelledby="toggleUserLabel${u.id}" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h1 class="modal-title fs-5" id="deleteUserLabel${u.id}">Confirmation</h1>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body text-danger-emphasis">
                                                            Do you want to ${'active'.equals(u.userStatus.userStatus.toLowerCase())? 'deactivate' : 'activate'} this user?
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button class="btn btn-primary" data-bs-dismiss="modal">No</button>
                                                            <a href="/user/toggle?id=${u.id}" class="btn btn-warning">Yes</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- End Delete Modal -->

                                            <!-- Update Details Modal -->
                                            <div class="modal fade" id="updateUserProfile${u.id}" tabindex="-1" aria-labelledby="updateUserProfileLabel${u.id}" aria-hidden="true">
                                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header border-bottom p-3">
                                                            <h5 class="modal-title" id="updateUserProfileLabel${u.id}">${u.fullName}</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <form action="/user/update" method="post" enctype="multipart/form-data">
                                                            <div class="modal-body p-3 pt-4">
                                                                <div class="row align-items-center mb-2">
                                                                    <div class="col-lg-2 col-md-4">
                                                                        <img id="avatar-preview-${u.id}" src="../assets/images/${u.avatar}" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                                                    </div><!--end col-->

                                                                    <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                                                        <h6 class="">Upload your picture</h6>
                                                                        <p class="text-muted mb-0">For best results, use an image at least 256px by 256px in either .jpg or .png format</p>
                                                                    </div><!--end col-->

                                                                    <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                                                        <input type="file" id="updated-avatar-${u.id}" name="updated-avatar-${u.id}" hidden onchange="previewImage(event, ${u.id})">
                                                                        <button type="button" class="btn btn-primary" onclick="triggerFileUpload(${u.id})">Upload</button>
                                                                        <a href="#" class="btn btn-soft-primary ms-2">Remove</a>
                                                                    </div><!--end col-->
                                                                </div><!--end row-->

                                                                <input type="hidden" name="id" value="${u.id}"/>
                                                                <div class="row">

                                                                    <div class="col-md-6">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Full Name</label>
                                                                            <input type="text" class="form-control" value="${u.fullName}" name="fullName">
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-md-6">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Email</label>
                                                                            <input type="text" class="form-control" value="${u.email}" name="email">
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-md-6">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Phone Number</label>
                                                                            <input type="text" class="form-control" value="${u.phoneNumber}" name="phoneNumber">
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-md-6">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Date Of Birth</label>
                                                                            <input type="date" class="form-control" value="${u.dob}" name="dob">
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-md-12">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Position</label>
                                                                            <select class="form-control" name="role" required>
                                                                                <c:forEach var="r" items="${roles}">
                                                                                    <option value="${r.id}" <c:if test="${u.role.title.userRole eq r.title.userRole}">selected</c:if>>${r.title.userRole}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>                                                                               
                                                                    </div><!--end col-->

                                                                    <div class="col-md-12">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Note</label>
                                                                            <textarea class="form-control" name="note">${u.note}</textarea>
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="row">
                                                                        <div class="col-sm-12 text-center">
                                                                            <button type="submit" class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">Update</button>
                                                                        </div><!--end col-->
                                                                    </div><!--end row-->

                                                                </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- End Update Details Modal -->
                                            <!--END MODAL-->
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="row text-center">
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3">Showing <%= (currentPage - 1) * itemsPerPage + 1 %> - <%= Math.min(currentPage * itemsPerPage, totalUsers) %> out of <%= totalUsers %></span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
                                            <a class="page-link" href="?currentPage=<%= currentPage - 1 %>&itemsPerPage=<%= itemsPerPage %>&searchQuery=<%= searchQuery %>" aria-label="Previous">Previous</a>
                                        </li>
                                        <% for (int i = 1; i <= totalPages; i++) { %>
                                        <li class="page-item <%= (currentPage == i) ? "active" : "" %>">
                                            <a class="page-link" href="?currentPage=<%= i %>&itemsPerPage=<%= itemsPerPage %>&searchQuery=<%= searchQuery %>"><%= i %></a>
                                        </li>
                                        <% } %>
                                        <li class="page-item <%= (currentPage == totalPages) ? "disabled" : "" %>">
                                            <a class="page-link" href="?currentPage=<%= currentPage + 1 %>&itemsPerPage=<%= itemsPerPage %>&searchQuery=<%= searchQuery %>" aria-label="Next">Next</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>


                    </div>
                </div><!--end container-->

                <jsp:include page="../footer/footer.jsp"/>
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

        <c:choose>
            <c:when test="${toggled != null}">
                <div class="toast-container position-fixed bottom-0 end-0 p-3">
                    <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                        <div class="toast-header">
                            <img src="../assets/images/favicon.ico.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                            <strong class="me-auto">KRS System</strong>
                            <small class="mt-1">A few seconds ago</small>
                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <c:choose>
                            <c:when test="${toggled == 'successful'}">
                                <div class="toast-body text-success-emphasis">
                                    Status changed successfully!
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="toast-body text-danger-emphasis">
                                    Failed to change status!
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:when>
        </c:choose>

        <c:choose>
            <c:when test="${added == 'successful'}">
                <div class="toast-container position-fixed bottom-0 end-0 p-3">
                    <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                        <div class="toast-header">
                            <img src="../assets/images/favicon.ico.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                            <strong class="me-auto">KRS System</strong>
                            <small class="mt-1">A few seconds ago</small>
                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <div class="toast-body text-success-emphasis">
                            Added successfully!
                        </div>
                    </div>
                </div>
            </c:when>
        </c:choose>

        <c:choose>
            <c:when test="${updated != null}">
                <div class="toast-container position-fixed bottom-0 end-0 p-3">
                    <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                        <div class="toast-header">
                            <img src="../assets/images/favicon.ico.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                            <strong class="me-auto">KRS System</strong>
                            <small class="mt-1">A few seconds ago</small>
                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <c:choose>
                            <c:when test="${updated == 'successful'}">
                                <div class="toast-body text-success-emphasis">
                                    Updated successfully!
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="toast-body text-danger-emphasis">
                                    Updated failed!
                                </div> 
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:when>
        </c:choose>

        <!-- javascript -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="../assets/js/simplebar.min.js"></script>
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
        <script type="text/javascript">
                                                                            const currentSite = '${currentSite}';
        </script>
        <script src="../assets/js/app.js"></script>
        <script>
                                                                            document.addEventListener('DOMContentLoaded', function () {
                                                                                var toastEl = document.getElementById('liveToast');
                                                                                if (toastEl) {
                                                                                    var toast = new bootstrap.Toast(toastEl, {
                                                                                        delay: 2000
                                                                                    });
                                                                                    toast.show();
                                                                                }
                                                                            });
        </script>
        <script>
            function triggerFileUpload(userId) {
                document.getElementById('updated-avatar-' + userId).click();
            }

            function previewImage(event, userId) {
                const fileInput = event.target;
                const file = fileInput.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('avatar-preview-' + userId).src = e.target.result;
                    }
                    reader.readAsDataURL(file);
                }
            }
        </script>

    </body>

</html>
