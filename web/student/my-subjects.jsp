<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>My Subjects</title>
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
        <!-- Loader -->
        <jsp:include page="../loader/loader.jsp"/>
        <!-- Loader -->

        <div class="page-wrapper doctris-theme toggled">
            <!-- Vertical Navbar -->
            <jsp:include page="../navbar/vertical.jsp"/>
            <!-- Vertical Navbar -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="../navbar/horizontal.jsp"/>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row">
                            <div class="d-flex justify-content-between align-items-center w-100">
                                <h5 class="mb-0">My Subjects</h5>
                                <div class="d-flex w-50 justify-content-end">
                                    <form class="d-flex w-100" action="/my-subjects" method="get">
                                        <input class="form-control me-2" type="search" placeholder="Enter subject code..." aria-label="Search" name="searchQuery" value="${searchQuery}">
                                        <button class="btn btn-primary" type="submit">Search</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <c:choose>
                            <c:when test="${subjectDtos.size() == 0}">
                                <div class="d-flex justify-content-center align-items-center" style="height: 50vh;">
                                    <p>No subjects found with the keyword <strong>${param.searchQuery}</strong>.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${param.searchQuery != null && !param.searchQuery.isEmpty()}">
                                    <p>Found ${subjectDtos.size()} subjects with keyword ${param.searchQuery}</p>
                                </c:if>
                                <div class="row">
                                    <c:forEach var="sd" items="${subjectDtos}">
                                        <div class="col-6 my-3">
                                            <div class="card">
                                                <div class="card-body">
                                                    <p><b>Name:</b> ${sd.subjectName}</p>
                                                    <p><b>Code:</b> ${sd.subjectCode}</p>
                                                    <p><b>Category:</b> ${sd.subjectCategory.name}</p>
                                                    <p><b>Total Students:</b> ${sd.totalStudents}</p>
                                                    <div class="d-flex justify-content-end">
                                                        <a href="/my-subjects/class?subjectId=${sd.subjectId}" class="btn btn-primary">Go to courses</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div><!--end container-->


                <!-- Footer Start -->
                <footer class="bg-white shadow py-3">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col">
                                <div class="text-sm-start text-center">
                                    <p class="mb-0 text-muted"><script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i class="mdi mdi-heart text-danger"></i> by <a href="../../../index.html" target="_blank" class="text-reset">Shreethemes</a>.</p>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div><!--end container-->
                </footer><!--end footer-->
                <!-- End -->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

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