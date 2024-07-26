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
        <title>Change Password</title>
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
                            <h5 class="mb-0">Change Password</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="/main/my-profile.jsp">Profile</a></li>
                                </ul>
                            </nav>
                        </div>

                        <div class="row">
                            <div class="col-lg-12 mt-4">
                                <div class="card border-0 p-4 rounded shadow">
                                    <form class="mt-2" action="/user/change-password" method="post">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="oldPass">Old Password</label>
                                                    <input name="oldPass" id="oldPass" type="password" class="form-control ${errors['invalidOldPass'] == 'None' ? 'is-valid' : errors['invalidOldPass'] == null? '' : 'is-invalid'}" placeholder="Old Password:" required value="${oldPass}">
                                                    <div class="valid-feedback">
                                                        Valid old password!
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        ${errors['invalidOldPass']}
                                                    </div>
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="newPass">New Password</label>
                                                    <input name="newPass" id="newPass" type="password" class="form-control ${errors['passwordsMismatch'] == 'None' ? 'is-valid' : errors['passwordsMismatch'] == null? '' : 'is-invalid'}" placeholder="New Password :" required value="${newPass}">
                                                    <div class="valid-feedback">
                                                        Valid new password!
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        ${errors['passwordsMismatch']}
                                                    </div>
                                                </div>
                                            </div><!--end col-->

                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label" for="confirmPass">Confirm Password</label>
                                                    <input name="confirmPass" id="confirmPass" type="password" class="form-control ${errors['passwordsMismatch'] == 'None' ? 'is-valid' : errors['passwordsMismatch'] == null? '' : 'is-invalid'}" placeholder="Confirm Password :" required value="${confirmPass}">
                                                    <div class="valid-feedback">
                                                        Confirm password matches!
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        ${errors['passwordsMismatch']}
                                                    </div>
                                                </div>
                                            </div><!--end col-->
                                        </div><!--end row-->

                                        <div class="row">
                                            <div class="col-12 text-end">
                                                <button type="submit" class="btn btn-success">Change</button>
                                            </div>
                                        </div>

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
        <script>
            const currentSite = '${currentSite}';
        </script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>
    </body>

</html>