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
                                                <option value="${c.id},${subjectId}" ${classroom != null && classroom.id == c.id ? 'selected' : ''}>${c.title}</option>
                                            </c:forEach>
                                        </select>
                                        <label for="floatingSelect">Current class</label>
                                    </div>


                                </div>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <h5>Teacher: ${classroom.teacher.fullName}</h5>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <h5>Exams</h5>
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Title</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="e" items="${exams}" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td>${e.key.title}</td>
                                                <td>
                                                    <a href="/my-subjects/exam?id=${e.key.id}" class="btn btn-primary">Take</a>
                                                    <button class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModal">Details</button>
                                                </td>
                                            </tr>
                                        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered modal-sm">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h1 class="modal-title fs-5" id="exampleModalLabel">${e.key.title}</h1>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>Exam title: ${e.key.title}</p>
                                                        <p>Duration: ${e.key.duration} minutes</p>
                                                        <p>Creator: ${e.key.createdBy.fullName}</p>
                                                        <p>Total questions: ${e.value}</p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
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
                                        const myModal = document.getElementById('myModal');
                                        const myInput = document.getElementById('myInput');

                                        myModal.addEventListener('shown.bs.modal', () => {
                                            myInput.focus();
                                        });
                                        function redirectToDetails(selectElement) {
                                            const selectedValue = selectElement.value;
                                            const [classId, subjectId] = selectedValue.split(',');
                                            const url = '/my-subjects/class?subjectId=' + subjectId + '&classId=' + classId;
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