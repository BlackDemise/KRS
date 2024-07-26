<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="repository.impl.QuestionRepositoryImpl"%>
<%@page import="java.util.List"%>
<%@page import="entity.Question"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>All Classes</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="../../../add-user.jsp" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
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
                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive bg-white shadow rounded">
                                    <table class="table mb-0 table-center">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3" style="min-width: 10%;">Id</th>
                                                <th class="border-bottom p-1" style="min-width: 30%;">Question</th>
                                                <th class="border-bottom p-3" style="min-width: 30%;">Subject</th>
                                                <th class="border-bottom p-3" style="min-width: 20%">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <p>${size}</p>
                                            <c:forEach var="q" items="${questionList}">
                                                <tr>
                                                    <td class="p-3">${q.id}</td>
                                                    <td class="p-1">${q.title}</td>
                                                    <td class="text-start p-3">
                                                        <a href="#" class="btn btn-icon btn-pills btn-soft-primary" data-bs-toggle="modal" data-bs-target="#viewDetailQuestion${q.id}"><i class="uil uil-eye"></i></a>
                                                        <a href="#" class="btn btn-icon btn-pills btn-soft-success" data-bs-toggle="modal" data-bs-target="#updateQuestion${q.id}"><i class="uil uil-edit"></i></a>
                                                        <a href="#" class="btn btn-icon btn-pills btn-soft-danger" data-bs-toggle="modal" data-bs-target="#deleteQuestion${q.id}"><i class="uil uil-trash-alt"></i></a>
                                                    </td>
                                                </tr>
                                                <!-- Details Modal -->
                                                <div class="modal fade" id="viewDetailQuestion${q.id}" tabindex="-1" aria-labelledby="viewDetailQuestionLabel${q.id}" aria-hidden="true">
                                                    <div class="modal-dialog modal-xl modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header border-bottom p-3">
                                                                <h5 class="modal-title" id="viewDetailQuestionLabel${q.id}">${q.title}</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body p-3 pt-4">
                                                                <div class="row align-items-center">
                                                                    <div class="col-lg-10 col-md-8">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Answer</label>
                                                                            <input type="text" class="form-control" value="${s.name}" disabled>
                                                                        </div>
                                                                    </div><!--end col-->
                                                                </div><!--end row-->


                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">Close</button>
                                                                    </div><!--end col-->
                                                                </div><!--end row-->

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            <!-- End Details Modal -->
                                            <!-- Delete Modal -->
                                            <div class="modal fade" id="deleteQuestion${q.id}" tabindex="-1" aria-labelledby="deleteQuestionLabel${q.id}" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h1 class="modal-title fs-5" id="deleteQuestionLabel${q.id}">Confirmation</h1>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body text-danger-emphasis">
                                                            Do you want to delete this Question? This action is irreversible!
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button class="btn btn-primary" data-bs-dismiss="modal">No</button>
                                                            <a href="/question/delete?questionId=${q.id}" class="btn btn-warning">Yes</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- End Delete Modal -->
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
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
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>

    </body>

</html>