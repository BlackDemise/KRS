<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="entity.Classroom"%>

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
        <link rel="shortcut icon" href="../assets/images/favicon.png">
        <!-- Bootstrap -->
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="../assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="../assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="../assets/css/flatpickr.min.css">
        <link href="../assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />

        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

        <style>
            .search-bar-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .search-bar {
                display: flex;
                align-items: center;
            }
            .search-bar input[type="search"] {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px 0 0 4px;
                outline: none;
                margin-right: -1px; /* Adjust to remove double border */
            }
            .search-bar button {
                padding: 10px 20px;
                border: 1px solid #28a745;
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
                border: 1px solid #dc3545;
                background-color: #dc3545;
                color: white;
                border-radius: 4px;
                cursor: pointer;
                margin-left: 10px;
            }
            .cancel-btn:hover {
                background-color: #c82333;
            }
            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
                padding: 10px 20px;
                border-radius: 4px;
            }
            .btn-primary:hover {
                background-color: #0056b3;
                border-color: #004085;
            }
        </style>
    </head>

    <body>
        <jsp:include page="../loader/loader.jsp"/>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../navbar/vertical.jsp"/>
            <main class="page-content bg-light">
                <jsp:include page="../navbar/horizontal.jsp"/>
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row search-bar-container">
                            <div class="col-md-9">
                                <form class="search-bar" action="${pageContext.request.contextPath}/class" method="get">
                                    <input type="search" name="searchQuery" placeholder="Enter class name" aria-label="Search" value="${searchQuery}">
                                    <button type="submit">Search</button>
                                    <c:if test="${not empty searchQuery}">
                                        <button type="button" class="cancel-btn" onclick="window.location.href = '${pageContext.request.contextPath}/class'">Cancel</button>
                                    </c:if>
                                </form>
                            </div>
                            <div class="col-md-3 text-end">
                                <a href="${pageContext.request.contextPath}/class/add" class="btn btn-primary">New Class</a>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive bg-white shadow rounded">
                                    <table class="table mb-0 table-center">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3" style="min-width: 10%;">STT</th>
                                                <th class="border-bottom p-3" style="min-width: 20%;">Class Name</th>
                                                <th class="border-bottom p-3" style="min-width: 25%;">Teacher Name</th>
                                                <th class="border-bottom p-3" style="min-width: 25%;">
                                                    Subject Code
                                                    <a href="?sortField=subject_code&sortOrder=${sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                        <i class="uil uil-direction"></i>
                                                    </a>
                                                </th>
                                                <th class="border-bottom p-3" style="min-width: 20%;">
                                                    Status
                                                    <a href="?sortField=status&sortOrder=${sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                        <i class="uil uil-direction"></i>
                                                    </a>
                                                </th>
                                                <th class="border-bottom p-3">
                                                    Student
                                                </th>
                                                <th class="border-bottom p-3" style="min-width: 20%;">Action</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <c:forEach var="c" items="${classes}" varStatus="status">
                                                <tr>
                                                    <td class="p-3"><c:out value="${(currentPage - 1) * itemsPerPage + status.index + 1}" /></td>
                                                    <td class="p-3">${c.classRoom.title}</td>
                                                    <td class="p-3">${c.classRoom.teacher.fullName}</td>
                                                    <td class="p-3">${c.classRoom.subject.code}</td>
                                                    <td class="p-3">${c.classRoom.status}</td>
                                                    <td class="p-3">
                                                        <button type="button" class="btn btn-icon btn-pills btn-soft-primary" data-bs-toggle="modal" data-bs-target="#studentsList${c.classRoom.id}">
                                                            <i class="uil uil-eye"></i>
                                                        </button>
                                                    </td>
                                                    <td class="text-start p-3">
                                                        <a href="${pageContext.request.contextPath}/class/update?classId=${c.classRoom.id}" class="btn btn-icon btn-pills btn-soft-success"><i class="uil uil-edit"></i></a>
                                                        <a href="#" class="btn btn-icon btn-pills btn-soft-danger" data-bs-toggle="modal" data-bs-target="#toggleClassStatus${c.classRoom.id}">
                                                            ${c.classRoom.status.equals('INACTIVE') ? '<i class="uil uil-unlock"></i>' : '<i class="uil uil-lock"></i>'}
                                                        </a>
                                                    </td>
                                                </tr>

                                                <!-- Toggle Status Modal -->
                                            <div class="modal fade" id="toggleClassStatus${c.classRoom.id}" tabindex="-1" aria-labelledby="toggleClassStatusLabel${c.classRoom.id}" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="toggleClassStatusLabel${c.classRoom.id}">Confirmation</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body text-danger-emphasis">
                                                            Do you want to ${'ACTIVE'.equals(c.classRoom.status) ? 'deactivate' : 'activate'} this class?
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button class="btn btn-primary" data-bs-dismiss="modal">No</button>
                                                            <button class="btn btn-warning" onclick="confirmToggleClassStatus(${c.classRoom.id}, '${c.classRoom.status}')" data-bs-dismiss="modal">Yes</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- End Toggle Status Modal -->

                                            <!-- Details Modal -->
                                            <div class="modal fade" id="classProfile${c.classRoom.id}" tabindex="-1" aria-labelledby="classProfileLabel${c.classRoom.id}" aria-hidden="true">
                                                <div class="modal-dialog modal-xl modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header border-bottom p-3">
                                                            <h5 class="modal-title" id="classProfileLabel${c.classRoom.id}">${c.classRoom.title}</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body p-3 pt-4">
                                                            <div class="row align-items-center">
                                                                <div class="col-lg-2 col-md-4">
                                                                    <img src="../assets/images/classes/class1.jpg" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                                                </div><!--end col-->

                                                                <div class="col-lg-10 col-md-8">
                                                                    <div class="mb-3">
                                                                        <label class="form-label">Class Name</label>
                                                                        <input type="text" class="form-control" value="${c.classRoom.title}" disabled>
                                                                    </div>
                                                                </div><!--end col-->
                                                            </div><!--end row-->

                                                            <div class="row">
                                                                <div class="col-md-12">
                                                                    <div class="mb-3">
                                                                        <label class="form-label">Teacher Name</label>
                                                                        <input type="text" class="form-control" value="${c.classRoom.teacher.fullName}" disabled>
                                                                    </div> 
                                                                </div><!--end col-->

                                                                <div class="col-md-12">
                                                                    <div class="mb-3">
                                                                        <label class="form-label">Subject Code</label>
                                                                        <input type="text" class="form-control" value="${c.classRoom.subject.code}" disabled>
                                                                    </div> 
                                                                </div><!--end col-->
                                                            </div>

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
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="row text-center">
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3">
                                        Showing ${(currentPage - 1) * itemsPerPage + 1} - 
                                        ${Math.min(currentPage * itemsPerPage, totalClasses)} 
                                        out of ${totalClasses}
                                    </span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="?currentPage=${currentPage - 1}&itemsPerPage=${itemsPerPage}&searchQuery=${searchQuery}" aria-label="Previous">Previous</a>
                                        </li>
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="?currentPage=${i}&itemsPerPage=${itemsPerPage}&searchQuery=${searchQuery}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="?currentPage=${currentPage + 1}&itemsPerPage=${itemsPerPage}&searchQuery=${searchQuery}" aria-label="Next">Next</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Modal for Students -->
                        <c:forEach var="c" items="${classes}">
                            <div class="modal fade" id="studentsList${c.classRoom.id}" tabindex="-1" aria-labelledby="studentsListLabel${c.classRoom.id}" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="studentsListLabel${c.classRoom.id}">Students for ${c.classRoom.title}</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <!-- File Upload Form -->
                                            <form action="${pageContext.request.contextPath}/class/uploadStudents" method="post" enctype="multipart/form-data">
                                                <input type="hidden" name="classId" value="${c.classRoom.id}">
                                                <div class="form-group">
                                                    <label for="fileUpload${c.classRoom.id}">Upload Students File</label>
                                                    <input type="file" id="fileUpload${c.classRoom.id}" name="studentsFile" class="form-control" required>
                                                </div>
                                                <button type="submit" class="btn btn-primary mt-3">Upload</button>
                                            </form>
                                            <hr>
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>Full Name</th>
                                                        <th>Email</th>
                                                        <th>Phone Number</th>
                                                        <th>Date of Birth</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="student" items="${c.students}">
                                                        <tr>
                                                            <td>${student.fullName}</td>
                                                            <td>${student.email}</td>
                                                            <td>${student.phoneNumber}</td>
                                                            <td>${student.dob}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>




                        <!-- Success Toast Message -->
                        <c:choose>
                            <c:when test="${param.added == 'successful'}">
                                <div class="toast-container position-fixed bottom-0 end-0 p-3">
                                    <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                                        <div class="toast-header">
                                            <img src="../assets/images/favicon.ico.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                                            <strong class="me-auto">KRS System</strong>
                                            <small class="mt-1">A few seconds ago</small>
                                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                                        </div>
                                        <div class="toast-body text-success-emphasis">
                                            Added successfully!
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${param.updated == 'successful'}">
                                <div class="toast-container position-fixed bottom-0 end-0 p-3">
                                    <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                                        <div class="toast-header">
                                            <img src="../assets/images/favicon.ico.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                                            <strong class="me-auto">KRS System</strong>
                                            <small class="mt-1">A few seconds ago</small>
                                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                                        </div>
                                        <div class="toast-body text-success-emphasis">
                                            Updated successfully!
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${param.statusChanged == 'successful'}">
                                <div class="toast-container position-fixed bottom-0 end-0 p-3">
                                    <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                                        <div class="toast-header">
                                            <img src="../assets/images/favicon.ico.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                                            <strong class="me-auto">KRS System</strong>
                                            <small class="mt-1">A few seconds ago</small>
                                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                                        </div>
                                        <div class="toast-body text-success-emphasis">
                                            Status changed successfully!
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${param.statusChanged == 'failed'}">
                                <div class="toast-container position-fixed bottom-0 end-0 p-3">
                                    <div id="liveToast" class="toast show" role="alert" aria-live="assertive" aria-atomic="true" style="width: 350px">
                                        <div class="toast-header">
                                            <img src="../assets/images/favicon.ico.png" class="rounded me-2" alt="web-logo" height="20" width="20">
                                            <strong class="me-auto">KRS System</strong>
                                            <small class="mt-1">A few seconds ago</small>
                                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                                        </div>
                                        <div class="toast-body text-danger-emphasis">
                                            Failed to change status!
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                        </c:choose>
                        <!-- End Success Toast Message -->

                    </div>
                </div>
                <jsp:include page="../footer/footer.jsp"/>
            </main>
        </div>

        <!-- javascript -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="../assets/js/simplebar.min.js"></script>
        <!-- Select2 -->
        <script src="../assets/js/select2.min.js"></script>
        <script src="../assets/js/select2.init.js"></script>
        <!-- Datepicker -->
        <script src="../assets/js/jquery.timepicker.min.js"></script> 
        <script src="../assets/js/flatpickr.min.js"></script>
        <script src="../assets/js/flatpickr.init.js"></script>
        <script src="../assets/js/timepicker.init.js"></script> 

        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <script type="text/javascript">
                                                                const currentSite = '${currentSite}';
        </script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>
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
        <script>
            function confirmToggleClassStatus(classId, currentStatus) {
                const newStatus = currentStatus === 'ACTIVE' ? 'INACTIVE' : 'ACTIVE';

                $.ajax({
                    url: '${pageContext.request.contextPath}/class/toggle',
                    type: 'POST',
                    data: {classId: classId, currentStatus: currentStatus},
                    success: function () {
                        location.reload(); // Reload the page to reflect the changes
                    },
                    error: function () {
                        alert('Failed to update class status');
                    }
                });
            }
        </script>
    </body>
</html>
