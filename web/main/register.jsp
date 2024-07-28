<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Register</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            body {
                background: #f7f8fa;
            }
            .card {
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .card-body {
                padding: 2rem;
            }
            .form-label {
                font-weight: bold;
                color: #333;
            }
            .form-control {
                border-radius: 8px;
                padding: 10px 15px;
                font-size: 16px;
                border: 1px solid #ced4da;
                transition: all 0.3s;
            }
            .form-control:focus {
                border-color: #80bdff;
                box-shadow: 0 0 5px rgba(128, 189, 255, 0.5);
            }
            .btn {
                border-radius: 8px;
                padding: 10px 20px;
                font-size: 16px;
                transition: background-color 0.3s;
            }
            #google {
                color: white;
                background-color: #db4437;
            }
            #google:hover {
                background-color: #c23321;
            }
            #facebook {
                color: white;
                background-color: #3b5998;
            }
            #facebook:hover {
                background-color: #2d4373;
            }
            #register {
                color: white;
                background-color: #28a745;
            }
            #register:hover {
                background-color: #218838;
            }
            .error-message {
                color: red;
                font-weight: bold;

            }
            .back-to-home {
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 100;
            }
            .icons {
                color: #fff;
            }
        </style>
    </head>

    <body>
        <!-- Loader -->
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->

        <div class="back-to-home rounded d-none d-sm-block">
            <a href="/" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
        </div>

        <!-- Hero Start -->
        <section class="bg-home d-flex bg-light align-items-center py-5" style="background: url('assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <img src="../assets/images/logo-white.png" width="150" height="60" class="mx-auto d-block" alt="">
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Sign Up</h4>  
                                <form action="/register" method="post" class="login-form mt-4">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="mb-2">
                                                <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" placeholder="Full Name" name="fullName" value="${fullName != null ? fullName : ''}">

                                                <c:choose>
                                                    <c:when test="${empty fullName}">
                                                        <span class="error-message">${error_empty}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="error-message">${error_fullName}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="mb-2">
                                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                                <input type="email" class="form-control" placeholder="Email" name="email" value="${email != null ? email : ''}">
                                                <span class="error-message">${error_email}</span>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="mb-2">
                                                <label class="form-label">Password <span class="text-danger">*</span></label>
                                                <input type="password" class="form-control" placeholder="Password" name="password" value="${password != null ? password : ''}">
                                                <span class="error-message">${error_password}</span>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="mb-2">
                                                <label class="form-label">Confirm Password <span class="text-danger">*</span></label>
                                                <input type="password" class="form-control" placeholder="Confirm Password" name="confirmPassword" value="${confirmPassword != null ? confirmPassword : ''}">
                                                <span class="error-message">${error_confirmPassword}</span>
                                            </div>
                                        </div>

                                        <div class="col-12">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" value="" id="invalidCheck" >
                                                <label class="form-check-label" for="invalidCheck">
                                                    <p>I agree to terms and conditions</p>
                                                </label>
                                            </div>
                                        </div>

                                        <div class="col-lg-12 mb-0">
                                            <div class="d-grid">
                                                <button class="btn" id="register" type="submit">Register</button>
                                            </div>
                                        </div>

                                        <div class="col-lg-12 mt-3 text-center">
                                            <h6 class="text-muted">Or</h6>
                                        </div><!--end col-->

                                        <div class="col-12 mt-3">
                                            <div class="d-grid">
                                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:9999/google-login&response_type=code&client_id=527549594418-9m2nkli21eoq6biph6c5lo0fnkdqaiok.apps.googleusercontent.com&approval_prompt=force" class="btn" id="google"><i class="uil uil-google"></i> Google</a>
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-12 text-center">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Already has an account ?</small> <a href="login.jsp" class="text-dark fw-bold">Log In</a></p>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div><!--end card-->
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- Hero End -->

        <!-- javascript -->
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>
    </body>
</html>
