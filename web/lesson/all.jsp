<%-- 
    Document   : all-lesson
    Created on : Jun 7, 2024, 10:11:10 PM
    Author     : BOT Mark
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="repository.impl.LessonRepositoryImpl"%>
<%@page import="java.util.List"%>
<%@page import="entity.Lesson"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>All Lessons</title>
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
        <style>
            .search-bar {
                display: flex;
                justify-content: flex-start;
                margin-bottom: 20px;
            }
            .search-bar select, .search-bar input[type="search"] {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px 0 0 4px;
                outline: none;
                margin-right: 10px;
            }
            .search-bar button {
                padding: 10px 20px;
                border: 1px solid #ccc;
                background-color: #28a745;
                color: white;
                border-radius: 0 4px 4px 0;
                cursor: pointer;
            }
            .search-bar button:hover {
                background-color: #218838;
            }
            .cancel-btn {
                padding: 10px 20px;
                border: 1px solid #ccc;
                background-color: #dc3545;
                color: white;
                border-radius: 4px;
                cursor: pointer;
                margin-left: 10px;
            }
            .cancel-btn:hover {
                background-color: #c82333;
            }
        </style>
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
                            <div class="col-md-12 ms-auto">
                                <form class="search-bar" action="/lesson/search" method="get">
                                    <select name="SubjectId">
                                        <option value="ALL" >ALL</option>
                                        <c:forEach var="sl" items="${subjectList}">
                                            <option value="${sl.getId()}" >${sl.getCode()}</option>
                                        </c:forEach>
                                    </select>
                                    <select name="Status">
                                        <option value="ALL" >ALL</option>
                                        <option value="ACTIVE" >ACTIVE</option>
                                        <option value="INACTIVE" >INACTIVE</option>
                                    </select>
                                    <button type="submit">Search</button>
                                </form>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive bg-white shadow rounded">
                                    <table class="table mb-0 table-center">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3" style="min-width: 10%;">Id</th>
                                                <th class="border-bottom p-3" style="min-width: 30%;">Name</th>
                                                <th class="border-bottom p-3" style="min-width: 30%;">Subject</th>
                                                <th class="border-bottom p-3" style="min-width: 30%;">Status</th>
                                                <th class="border-bottom p-3" style="min-width: 20%">Update</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:forEach var="l" items="${lessonList}">
                                                <tr>
                                                    <td class="p-3">${l.lessonId}</td>
                                                    <td class="p-3">${l.name}</a></td>
                                                    <td class="p-3">${l.getSubject().getCode()}</a></td>
                                                    <td class="p-3">${l.status}</a></td>
                                                    <td class="text-start p-3">
                                                        <a href="#" class="btn btn-icon btn-pills btn-soft-success" data-bs-toggle="modal" data-bs-target="#updateLesson${l.lessonId}"><i class="uil uil-edit"></i></a>
                                                    </td>
                                                </tr>
                                                <!--START MODAL-->

                                                <!-- Update Modal -->
                                            <form action="/lesson">
                                                <div class="modal fade" id="updateLesson${l.lessonId}" tabindex="-1" aria-labelledby="updateLessonLabel${l.lessonId}" aria-hidden="true">
                                                    <div class="modal-dialog modal-xl modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header border-bottom p-3">
                                                                <h5 class="modal-title" id="updateLessonLabel${l.lessonId}">${l.subject.name}</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body p-3 pt-4">
                                                                <div class="row align-items-center">
                                                                    <div class="col-lg-10 col-md-8">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Name</label>
                                                                            <input name="lessonName" id="lessonName" class="form-control" value="${l.name}" required>
                                                                        </div>
                                                                    </div><!--end col-->
                                                                    <div class="col-md-12">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Status</label>
                                                                            <select class="form-control" name="status" required>
                                                                                <option value="ACTIVE">ACTIVE</option>
                                                                                <option value="ACTIVE">INACTIVE</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>
                                                                </div><!--end row-->
                                                                <div class="row">
                                                                    <div class="col-sm-12">
                                                                        <input type="hidden" name="lessonId" value="${l.lessonId}"> 
                                                                        <input type="hidden" name="subjectId" value="${l.subject.id}"> 
                                                                        <button type="submit" class="btn btn-primary">Save change</button>
                                                                    </div><!--end col-->
                                                                </div><!--end row-->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                            <!-- End Update Modal -->
                                            <!-- Delete Modal -->
                                            <div class="modal fade" id="deleteLesson${l.lessonId}" tabindex="-1" aria-labelledby="deleteLessonLabel${l.lessonId}" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h1 class="modal-title fs-5" id="deleteSubjectLabel${l.lessonId}">Confirmation</h1>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body text-danger-emphasis">
                                                            Do you want to delete this Lesson? This action is irreversible!
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button class="btn btn-primary" data-bs-dismiss="modal">No</button>
                                                            <a href="/deleteLessonServlet?lessonId=${l.lessonId}&subjectId=${l.subject.id}" class="btn btn-warning">Yes</a>
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
        <script type="text/javascript">
            const currentSite = '${currentSite}';
        </script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>

        <!-- subModal Update start -->
        <div class="toast-container position-fixed bottom-0 end-0 p-3">
            <%
                String updated = request.getParameter("updated");
                if ("yes".equals(updated) || "no".equals(updated)) {
            %>
            <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                <div class="toast-header">
                    <img src="../assets/images/favicon.ico.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                    <strong class="me-auto">KRS System</strong>
                    <small class="mt-1">A few seconds ago</small>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <%
                    if ("yes".equals(updated)) {
                %>
                <div class="toast-body text-success-emphasis">
                    Updated successfully!
                </div>
                <% 
                    } else {
                %>
                <div class="toast-body text-danger-emphasis">
                    updated failed!
                </div>
                <%
                    }    
                %>

            </div>
            <%
                }
            %>
        </div>
        <!-- subModal Update end -->

        <!-- subModal Delete start -->
        <div class="toast-container position-fixed bottom-0 end-0 p-3">
            <%
                String deleted = request.getParameter("deleted");
                if ("yes".equals(deleted) || "no".equals(deleted)) {
            %>
            <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                <div class="toast-header">
                    <img src="../assets/images/favicon.ico.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                    <strong class="me-auto">KRS System</strong>
                    <small class="mt-1">A few seconds ago</small>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <%
                    if ("yes".equals(deleted)) {
                %>
                <div class="toast-body text-success-emphasis">
                    Deleted successfully!
                </div>
                <% 
                    } else {
                %>
                <div class="toast-body text-danger-emphasis">
                    Deleted failed!
                </div>
                <%
                    }    
                %>
            </div>
            <%
                }
            %>
        </div>
        <!-- subModal Delete end -->
    </body>
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

</html>