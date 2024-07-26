<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>My Classes</title>
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
                            <div class="col-12">
                                <a href="/my-classes">My Classes</a>
                                <span> > </span>
                                <a href="/my-classes/details?classId=${classroom.id}&subjectId=${subjectId}">${classroom.title}</a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="d-flex justify-content-between align-items-center w-100">
                                <div class="d-flex w-75 justify-content-end">
                                    <div class="form-floating w-100 me-2">
                                        <select class="form-select" id="floatingSelect" aria-label="Floating label select example" onchange="redirectToDetails(this)">
                                            <c:forEach var="c" items="${classList}">
                                                <option value="${c.id},${c.subject.id}" ${classroom.id == c.id ? 'selected' : ''}>${c.title}</option>
                                            </c:forEach>
                                        </select>

                                        <label for="floatingSelect">Current class</label>
                                    </div>
                                    <div class="form-floating w-100 ms-2">
                                        <select class="form-select" id="floatingSelect" aria-label="Floating label select example" onchange='redirectToChapter(this)'>
                                            <option selected disabled value="">Choose the chapter</option>
                                            <c:forEach var="l" items="${lessonList}">
                                                <option value="${classroom.id},${l.subject.id},${l.lessonId}">${l.name}</option>
                                            </c:forEach>
                                        </select>
                                        <label for="floatingSelect">Jump to</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <h5>Teacher: </h5>
                            <c:forEach var="l" items="${lessonList}">
                                <div class="col-6 my-3">
                                    <div class="card" style="height: 175px">
                                        <div class="card-body d-flex flex-column justify-content-between">
                                            <div>
                                                <p>${l.name}</p>
                                                <div class="progress" role="progressbar" aria-label="Basic example" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
                                                    <div class="progress-bar" style="width: 50%"></div>
                                                </div>
                                            </div>
                                            <div class="text-end">
                                                <a href="/my-classes/lesson?lessonId=${l.lessonId}&classId=${classroom.id}&subjectId=${l.subject.id}" class="btn btn-primary">Details</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
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
        <script>
                                        function redirectToDetails(selectElement) {
                                            const selectedValue = selectElement.value;
                                            const [classId, subjectId] = selectedValue.split(',');
                                            const url = '/my-classes/details?classId=' + classId + '&subjectId=' + subjectId;
                                            window.location.href = url;
                                        }
                                        function redirectToChapter(selectElement) {
                                            const selectedValue = selectElement.value;
                                            const [classId, subjectId, lessonId] = selectedValue.split(',');
                                            const url = '/my-classes/lesson?lessonId=' + lessonId + '&classId=' + classId + '&subjectId=' + subjectId;
                                            console.log(url);
                                            window.location.href = url;
                                        }
        </script>

    </body>

</html>