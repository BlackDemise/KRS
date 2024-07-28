<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Login</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.png">
        <!-- Bootstrap -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            #google {
                color: white;
                background-color: red;
            }
            #google:hover {
                background-color: rgba(255, 0, 0, 0.8);
            }
            #facebook {
                color: white;
                background-color: blue;
            }
            #facebook:hover {
                background-color: rgba(0, 0, 255, 0.8);
            }
            #sign-in {
                color: white;
                background-color: green;
            }
            #sign-in:hover {
                background-color: rgba(0, 150, 0, 0.8);
            }
        </style>
    </head>

    <body>
        <jsp:include page="../loader/loader.jsp"/>

        <div class="back-to-home rounded d-none d-sm-block">
            <a href="/" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
        </div>

        <!-- Hero Start -->
        <section class="bg-home d-flex bg-light align-items-center" style="background: url('../assets/images/bg/bg-lines-one.png') center;height:100vh">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <img src="../assets/images/logo-white.png" width="150" height="60" class="mx-auto d-block" alt="">
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Sign In</h4>  
                                <form action="/login" method="post" class="login-form mt-4" id="login-form">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                                <input type="email" id="email" class="form-control" placeholder="Email" name="email" value="${email}" required>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Password <span class="text-danger">*</span></label>
                                                <input type="password" id="password" class="form-control" placeholder="Password" name="password" value="${password}" required>
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="d-flex justify-content-between">
                                                <div class="mb-3 w-100 text-end">
                                                    <a href="/main/enter-email.jsp" class="text-dark h6 mb-0">Forgot password ?</a> 
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-12 mb-0">
                                            <div class="d-grid">
                                                <button class="btn" id="sign-in" type="submit">Sign in</button>
                                            </div>
                                        </div>

                                        <div class="col-lg-12 mt-3 text-center">
                                            <h6 class="text-muted">Or</h6>
                                        </div><!--end col-->

                                        <div class="col-12 mt-3">
                                            <div class="d-grid">
                                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:9999/google-login&response_type=code&client_id=527549594418-9m2nkli21eoq6biph6c5lo0fnkdqaiok.apps.googleusercontent.com&approval_prompt=force" 
                                                   class="btn" id="google"><i class="uil uil-google"></i> Google</a>
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-12 text-center">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Don't have an account ?</small> <a href="/register" class="text-dark fw-bold">Sign Up</a></p>
                                            <p class="mt-2 text-danger" id="error">${error}</p>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div><!---->
                    </div> <!--end col-->
                </div><!--end row-->
            </div> <!--end container-->
        </section><!--end section-->
        <!-- Hero End -->

        <c:choose>
            <c:when test="${param.proceed == 'no'}">
                <div class="toast-container position-fixed bottom-0 end-0 p-3">
                    <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                        <div class="toast-header">
                            <img src="../assets/images/favicon.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                            <strong class="me-auto">FPT University KRS</strong>
                            <small class="mt-1">A few seconds ago</small>
                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                        <div class="toast-body text-danger">
                            You need to log in to do that!
                        </div>
                    </div>
                </div>
            </c:when>
        </c:choose>

        <!-- javascript -->
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>
        <script>
            // Toasts
            const toastTrigger = document.getElementById('liveToastBtn')
            const toastLiveExample = document.getElementById('liveToast')

            if (toastTrigger) {
                const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toastLiveExample)
                toastTrigger.addEventListener('click', () => {
                    toastBootstrap.show()
                })
            }
        </script>
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
    </body>

</html>