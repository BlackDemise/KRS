<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="repository.impl.RoleRepositoryImpl"%>
<%@page import="constant.EUserStatus"%>
<%
    RoleRepositoryImpl rri = RoleRepositoryImpl.getInstance();
    request.setAttribute("roles", rri.findAll());
    request.setAttribute("statuses", EUserStatus.values()); 
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Add A New User</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="../../../add-user.jsp" />
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
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Add New User</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="/admin/all-users.jsp">All Users</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Add User</li>
                                </ul>
                            </nav>
                        </div>

                        <div class="row">
                            <div class="col-lg-12 mt-4">
                                <div class="card border-0 p-4 rounded shadow">
                                    <div class="row align-items-center">
                                        <div class="col-lg-3 col-md-4">
                                            <img src="../assets/images/default_avatar.png" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                        </div><!--end col-->

                                        <div class="col-lg-9 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                            <h5 class="text-center">This is default avatar. Users can update it later on.</h5>
                                            <h5 class="text-center">Password will be randomized and sent to the given email.</h5>
                                        </div><!--end col-->


                                    </div><!--end row-->

                                    <form class="mt-4" action="/user/add" method="post">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Full Name</label>
                                                    <input name="fullName" id="fullName" type="text" class="form-control ${errors['errorName'] == 'None' ? 'is-valid' : errors['errorName'] == null? '' : 'is-invalid'}" placeholder="Full Name :" required value="${fullName}">
                                                    <div class="valid-feedback">
                                                        Valid name!
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        ${errors['errorName']}
                                                    </div>
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Email</label>
                                                    <input name="email" id="email" type="email" class="form-control ${errors['errorEmail'] == 'None' ? 'is-valid' : errors['errorEmail'] == null? '' : 'is-invalid'}" placeholder="Email :" required value="${email}">
                                                    <div class="valid-feedback">
                                                        Valid email!
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        ${errors['errorEmail']}
                                                    </div>
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Date Of Birth</label>
                                                    <input name="dob" id="dob" type="date" class="form-control ${errors['errorDob'] == 'None' ? 'is-valid' : errors['errorDob'] == null? '' : 'is-invalid'}" required value="${dob}">
                                                    <div class="valid-feedback">
                                                        Valid date!
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        ${errors['errorDob']}
                                                    </div>
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Phone Number</label>
                                                    <input name="phoneNumber" id="phoneNumber" type="text" class="form-control ${errors['errorPhoneNumber'] == 'None' ? 'is-valid' : errors['errorPhoneNumber'] == null? '' : 'is-invalid'}" placeholder="Phone Number:" required value="${phoneNumber}">
                                                    <div class="valid-feedback">
                                                        Valid phone number!
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        ${errors['errorPhoneNumber']}
                                                    </div>
                                                </div> 
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Position</label>
                                                    <select class="form-control ${errors['checkRole'] == null? '' : 'is-valid'}" name="role" required>
                                                        <c:forEach var="r" items="${roles}">
                                                            <option value="${r.id}" ${r.id == roleId? 'selected' : ''}>${r.title.userRole}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <div class="valid-feedback">
                                                        Please check again if this is the expected role.
                                                    </div>
                                                </div>                                                                               
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Status</label>
                                                    <select class="form-control ${errors['checkStatus'] == null? '' : 'is-valid'}"" name="status" required>
                                                        <c:forEach var="s" items="${statuses}">
                                                            <option value="${s.name()}" ${s.name() == status? 'selected' : ''}>${s.userStatus}</option>
                                                        </c:forEach>
                                                    </select>
                                                    <div class="valid-feedback">
                                                        Please check again if this is the expected status.
                                                    </div>
                                                </div>                                                                               
                                            </div><!--end col-->
                                        </div><!--end row-->

                                        <button type="submit" class="btn btn-primary">Add User</button>
                                        <button type="submit" class="btn btn-danger">Cancel</button>
                                    </form>
                                </div>
                            </div><!--end col-->
                        </div>
                    </div><!--end container-->
                </div>
                <jsp:include page="../footer/footer.jsp"/>
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

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
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <script type="text/javascript">
            const currentSite = '${currentSite}';
        </script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>
        
    </body>

</html>