<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Dashboard</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="dashboard.jsp" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.png">
        <!-- Bootstrap -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="../assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="../assets/css/select2.min.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link href="../assets/css/tiny-slider.css" rel="stylesheet" />
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
                            <c:choose>
                                <c:when test="${sessionScope.user.role.title.userRole == 'Student'}">
                                    <h5 class="mb-0">My Statistics</h5>
                                    <div class="row">
                                        <div class="col-xl-4 col-lg-4 col-md-4 mt-4">
                                            <div class="card features feature-primary rounded border-0 shadow p-4">
                                                <div class="d-flex align-items-center">
                                                    <div class="icon text-center rounded-md">
                                                        <i class="uil uil-bed h3 mb-0"></i>
                                                    </div>
                                                    <div class="flex-1 ms-2">
                                                        <h5 class="mb-0">${totalClasses}</h5>
                                                        <p class="text-muted mb-0">Total Classes</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-xl-4 col-lg-4 col-md-4 mt-4">
                                            <div class="card features feature-primary rounded border-0 shadow p-4">
                                                <div class="d-flex align-items-center">
                                                    <div class="icon text-center rounded-md">
                                                        <i class="uil uil-file-medical-alt h3 mb-0"></i>
                                                    </div>
                                                    <div class="flex-1 ms-2">
                                                        <h5 class="mb-0">${totalPractices}</h5>
                                                        <p class="text-muted mb-0">Total Practice Attempts</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-xl-4 col-lg-4 col-md-4 mt-4">
                                            <div class="card features feature-primary rounded border-0 shadow p-4">
                                                <div class="d-flex align-items-center">
                                                    <div class="icon text-center rounded-md">
                                                        <i class="uil uil-social-distancing h3 mb-0"></i>
                                                    </div>
                                                    <div class="flex-1 ms-2">
                                                        <h5 class="mb-0">${totalExams}</h5>
                                                        <p class="text-muted mb-0">Total Exam Attempts</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->

                                    <div class="row">
                                        <div class="col-12 mt-4">
                                            <div class="card border-0 shadow rounded">
                                                <div class="d-flex justify-content-between align-items-center p-4 border-bottom">
                                                    <h6 class="mb-0"><i class="uil uil-calender text-primary me-1 h5"></i> Recent Exam Results</h6>
                                                </div>

                                                <ul class="list-unstyled mb-0 p-4">
                                                    <c:forEach var="examEntry" items="${examStatistics}">
                                                        <li class="mt-3">
                                                            <div class="d-flex align-items-center justify-content-between">
                                                                <div class="d-inline-flex">
                                                                    <img src="../assets/images/${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                                    <div class="ms-3">
                                                                        <h6 class="text-dark mb-0 d-block">${examEntry.value.examTitle}, ${examEntry.value.className}</h6>
                                                                        <small class="text-muted">Score: ${examEntry.value.actualScore}/${examEntry.value.maxScore}</small>
                                                                    </div>
                                                                </div>
                                                                <div>
                                                                    <a href="#" class="btn btn-primary">Details</a>
                                                                </div>
                                                            </div>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </c:when>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <jsp:include page="../footer/footer.jsp"/>
            </main>

            <!-- javascript -->
            <script src="../assets/js/bootstrap.bundle.min.js"></script>
            <!-- simplebar -->
            <script src="../assets/js/simplebar.min.js"></script>
            <!-- Chart -->
            <script src="../assets/js/apexcharts.min.js"></script>
            <script src="../assets/js/columnchart.init.js"></script>
            <!-- Icons -->
            <script src="../assets/js/feather.min.js"></script>
            <script type="text/javascript">
                const currentSite = '${currentSite}';
            </script>
            <!-- Main Js -->
            <script src="../assets/js/app.js"></script>

    </body>

</html>