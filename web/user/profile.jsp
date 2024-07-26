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
        <title>User Profile</title>
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
                            <h5 class="mb-0">Update</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="/admin/profile.jsp">Profile</a></li>
                                </ul>
                            </nav>
                        </div>

                        <div class="row">
                            <div class="col-lg-12 mt-4">
                                <div class="card border-0 p-4 rounded shadow">
                                    <form class="mt-2" action="/user/profile" method="post" enctype="multipart/form-data" onsubmit="return checkFileSelected()">
                                        <div class="row align-items-center mb-4">
                                            <div class="col-lg-2 col-md-4">
                                                <img src="../assets/images/${sessionScope.user.avatar}" id="avatar-preview" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                                <input type="hidden" id="current-avatar" name="current-avatar" value="${sessionScope.user.avatar}">
                                            </div><!--end col-->

                                            <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                                <h6 class="">Upload your picture</h6>
                                                <p class="text-muted mb-0">For best results, use an image at least 256px by 256px in either .jpg or .png format</p>
                                            </div><!--end col-->

                                            <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                                <input type="file" id="updated-avatar" name="updated-avatar" hidden>
                                                <button type="button" class="btn btn-primary" onclick="triggerFileUpload()">Upload</button>
                                            </div><!--end col-->
                                        </div><!--end row-->

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Full Name</label>
                                                    <input name="fullName" id="fullName" type="text" class="form-control ${errors['errorName'] == 'None' ? 'is-valid' : errors['errorName'] == null? '' : 'is-invalid'}" placeholder="Full Name:" value="${sessionScope.user.fullName}" required>
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
                                                    <input name="email" id="email" type="email" class="form-control ${errors['errorEmail'] == 'None' ? 'is-valid' : errors['errorEmail'] == null? '' : 'is-invalid'}" placeholder="Email:" value="${sessionScope.user.email}" required>
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
                                                    <input name="dob" id="dob" type="date" class="form-control ${errors['errorDob'] == 'None' ? 'is-valid' : errors['errorDob'] == null? '' : 'is-invalid'}" value="${sessionScope.user.dob}" required>
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
                                                    <input name="phoneNumber" id="phoneNumber" type="text" class="form-control ${errors['errorPhoneNumber'] == 'None' ? 'is-valid' : errors['errorPhoneNumber'] == null? '' : 'is-invalid'}" placeholder="Phone Number:" value="${sessionScope.user.phoneNumber}" required>
                                                    <div class="valid-feedback">
                                                        Valid phone number!
                                                    </div>
                                                    <div class="invalid-feedback">
                                                        ${errors['errorPhoneNumber']}
                                                    </div>
                                                </div> 
                                            </div><!--end col-->

                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <p class="text-center">${message}</p>
                                                </div>
                                            </div>
                                        </div><!--end row-->

                                        <div class="row">
                                            <div class="col-12 text-end">
                                                <button type="submit" class="btn btn-success" id="submit-button" disabled>Update</button>
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
        <script>
                                                    function triggerFileUpload() {
                                                        document.getElementById('updated-avatar').click();
                                                    }

                                                    document.getElementById('updated-avatar').addEventListener('change', function (event) {
                                                        const file = event.target.files[0];
                                                        if (file) {
                                                            const reader = new FileReader();
                                                            reader.onload = function (e) {
                                                                document.getElementById('avatar-preview').src = e.target.result;
                                                            };
                                                            reader.readAsDataURL(file);
                                                        }
                                                        checkFormChanges();
                                                    });

                                                    function checkFormChanges() {
                                                        var originalValues = {
                                                            fullName: '${sessionScope.user.fullName}',
                                                            email: '${sessionScope.user.email}',
                                                            dob: '${sessionScope.user.dob}',
                                                            phoneNumber: '${sessionScope.user.phoneNumber}',
                                                            avatar: '${sessionScope.user.avatar}'
                                                        };

                                                        var currentValues = {
                                                            fullName: document.getElementById('fullName').value,
                                                            email: document.getElementById('email').value,
                                                            dob: document.getElementById('dob').value,
                                                            phoneNumber: document.getElementById('phoneNumber').value,
                                                            avatar: document.getElementById('updated-avatar').files.length > 0 ? document.getElementById('updated-avatar').files[0].name : originalValues.avatar
                                                        };

                                                        var hasChanges = false;
                                                        for (var key in originalValues) {
                                                            if (originalValues[key] !== currentValues[key]) {
                                                                hasChanges = true;
                                                                break;
                                                            }
                                                        }

                                                        document.getElementById('submit-button').disabled = !hasChanges;
                                                    }

                                                    document.getElementById('fullName').addEventListener('input', checkFormChanges);
                                                    document.getElementById('email').addEventListener('input', checkFormChanges);
                                                    document.getElementById('dob').addEventListener('input', checkFormChanges);
                                                    document.getElementById('phoneNumber').addEventListener('input', checkFormChanges);

                                                    function checkFileSelected() {
                                                        var fileInput = document.getElementById('updated-avatar');
                                                        if (fileInput.files.length === 0) {
                                                            // No file selected, so we need to ensure the current image is retained
                                                            fileInput.disabled = true;
                                                        }
                                                        return true;
                                                    }
        </script>
    </body>

</html>