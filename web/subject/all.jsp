<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>All Subjects</title>
        <!-- Meta tags and CSS links -->
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
        <!-- Date picker -->
        <link rel="stylesheet" href="../assets/css/flatpickr.min.css">
        <link href="../assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
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
            <main class="page-content bg-light">
                <jsp:include page="../navbar/horizontal.jsp"/>
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row">
                            <div class="col-md-4">
                                <form class="d-flex" method="get" action="/subject">
                                    <input class="form-control me-2" type="search" name="searchQuery" placeholder="Enter name:" aria-label="Search" value="${searchQuery}">
                                    <button class="btn btn-outline-success me-2" type="submit">Search</button>
                                    <c:if test="${searchQuery != null && !searchQuery.isEmpty()}">
                                        <button type="button" class="btn btn-outline-secondary" id="cancelSearch">Cancel</button>
                                    </c:if>
                                </form>
                            </div>
                            <c:choose>
                                <c:when test="${sessionScope.user.role.title.userRole == 'Administrator'}">
                                    <div class="col-md-2 ms-auto">
                                        <a href="${pageContext.request.contextPath}/subject/add" class="btn btn-primary">New Subject</a>
                                    </div>
                                </c:when>
                            </c:choose>
                        </div>

                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive bg-white shadow rounded">
                                    <table class="table mb-0 table-center">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3" style="min-width: 10%;">STT</th>
                                                <th class="border-bottom p-3" style="min-width: 30%;">Name</th>
                                                <th class="border-bottom p-3" style="min-width: 20%;">Code
                                                    <form method="get" class="d-inline" action="/subject">
                                                        <input type="hidden" name="sortField" value="code">
                                                        <input type="hidden" name="sortOrder" value="${sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                        <input type="hidden" name="currentPage" value="${currentPage}">
                                                        <input type="hidden" name="itemsPerPage" value="${itemsPerPage}">
                                                        <input type="hidden" name="searchQuery" value="${searchQuery}">
                                                        <button type="submit" class="btn btn-link p-0 m-0"><i class="uil uil-direction"></i></button>
                                                    </form>
                                                </th>
                                                <th class="border-bottom p-3" style="min-width: 20%;">Category
                                                    <form method="get" class="d-inline" action="/subject">
                                                        <input type="hidden" name="sortField" value="category">
                                                        <input type="hidden" name="sortOrder" value="${sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                        <input type="hidden" name="currentPage" value="${currentPage}">
                                                        <input type="hidden" name="itemsPerPage" value="${itemsPerPage}">
                                                        <input type="hidden" name="searchQuery" value="${searchQuery}">
                                                        <button type="submit" class="btn btn-link p-0 m-0"><i class="uil uil-direction"></i></button>
                                                    </form>
                                                </th>
                                                <th class="border-bottom p-3" style="min-width: 10%;">Status
                                                    <form method="get" class="d-inline" action="/subject">
                                                        <input type="hidden" name="sortField" value="status">
                                                        <input type="hidden" name="sortOrder" value="${sortOrder == 'asc' ? 'desc' : 'asc'}">
                                                        <input type="hidden" name="currentPage" value="${currentPage}">
                                                        <input type="hidden" name="itemsPerPage" value="${itemsPerPage}">
                                                        <input type="hidden" name="searchQuery" value="${searchQuery}">
                                                        <button type="submit" class="btn btn-link p-0 m-0"><i class="uil uil-direction"></i></button>
                                                    </form>
                                                </th>
                                                <th class="border-bottom p-3" style="min-width: 20%;">Manager</th>
                                                <th class="border-bottom p-3" style="min-width: 20%">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="s" items="${subjects}">
                                                <tr>
                                                    <td class="p-3">${s.subject.id}</td>
                                                    <td class="p-3">${s.subject.name}</td>
                                                    <td class="p-3">${s.subject.code}</td>
                                                    <td class="p-3">${s.subject.category.name}</td>
                                                    <td class="p-3">${s.subject.status.subjectStatus}</td>
                                                    <td class="text-start p-3">
                                                        <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#managerList${s.subject.id}">
                                                            View Managers
                                                        </button>

                                                    </td>
                                                    <td class="text-start p-3">
                                                        <c:choose>
                                                            <c:when test="${sessionScope.user.role.title.userRole == 'Administrator'}">
                                                                <a href="#" class="btn btn-icon btn-pills btn-soft-success" data-bs-toggle="modal" data-bs-target="#updateSubjectProfile${s.subject.id}"><i class="uil uil-edit"></i></a>
                                                                <a href="#" class="btn btn-icon btn-pills btn-soft-danger" data-bs-toggle="modal" data-bs-target="#toggleStatus${s.subject.id}"><i class="uil uil-lock"></i></a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                <a href="#" class="btn btn-icon btn-pills btn-soft-secondary disabled"><i class="uil uil-eye"></i></a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                    </td>
                                                </tr>
                                                <!-- START MODAL -->
                                                <!-- Update Details Modal -->
                                            <form action="/subject/update" method="post">
                                                <div class="modal fade" id="updateSubjectProfile${s.subject.id}" tabindex="-1" aria-labelledby="updateSubjectProfileLabel${s.subject.id}" aria-hidden="true">
                                                    <div class="modal-dialog modal-xl modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header border-bottom p-3">
                                                                <h5 class="modal-title" id="updateSubjectProfileLabel${s.subject.id}">${s.subject.name}</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <div class="modal-body p-3 pt-4">
                                                                <div class="row">
                                                                    <div class="col-md-6">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Name</label>
                                                                            <input name="nameSubject" id="nameSubject" class="form-control" value="${s.subject.name}" required>
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-md-6">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Code</label>
                                                                            <input name="codeSubject" id="codeSubject" class="form-control" value="${s.subject.code}" required>
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-md-6">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Category</label>
                                                                            <input name="categorySubject" id="categorySubject" class="form-control" value="${s.subject.category.name}" required>
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-md-6">
                                                                        <label class="form-label">Status</label>
                                                                        <div class="form-check">
                                                                            <input class="form-check-input" type="radio" name="statusSubject" id="statusSubjectActive${s.subject.id}" value="ACTIVE" <c:if test="${s.subject.status == 'ACTIVE'}">checked</c:if> required>
                                                                            <label class="form-check-label" for="statusSubjectActive${s.subject.id}">ACTIVE</label><br>
                                                                            <input class="form-check-input" type="radio" name="statusSubject" id="statusSubjectInactive${s.subject.id}" value="INACTIVE" <c:if test="${s.subject.status == 'INACTIVE'}">checked</c:if> required>
                                                                            <label class="form-check-label" for="statusSubjectInactive${s.subject.id}">INACTIVE</label>
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="col-md-12">
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Managers</label>
                                                                            <select name="managerIds" id="managerIds" class="form-control select2" multiple="multiple" required>


                                                                                <!-- Su ly o day -->


                                                                            </select>
                                                                        </div>
                                                                    </div><!--end col-->

                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <input type="hidden" name="id" value="${s.subject.id}">
                                                                            <c:if test="${sessionScope.user.role.title.userRole == 'Administrator'}">
                                                                                <button type="submit" class="btn btn-primary mt-3">Save Changes</button>
                                                                            </c:if>
                                                                        </div><!--end col-->
                                                                    </div><!--end row-->
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>

                                            <!-- Status Change Confirmation Modal -->
                                            <div class="modal fade" id="toggleStatus${s.subject.id}" tabindex="-1" aria-labelledby="toggleStatusLabel${s.subject.id}" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h1 class="modal-title fs-5" id="toggleStatusLabel${s.subject.id}">Confirmation</h1>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body text-danger-emphasis">
                                                            Do you want to change the status of this subject?
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button class="btn btn-primary" data-bs-dismiss="modal">No</button>
                                                            <form action="/subject/updateStatus" method="post" class="d-inline">
                                                                <input type="hidden" name="id" value="${s.subject.id}">
                                                                <c:if test="${sessionScope.user.role.title.userRole == 'Administrator'}">
                                                                    <button type="submit" class="btn btn-warning">Yes</button>
                                                                </c:if>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                                                
                                            <!-- Modal for Managers -->
                                            <div class="modal fade" id="managerList${s.subject.id}" tabindex="-1" aria-labelledby="managerListLabel${s.subject.id}" aria-hidden="true">
                                                <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="managerListLabel${s.subject.id}">Managers for ${s.subject.name}</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <table class="table table-striped">
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col">Full Name</th>
                                                                        <th scope="col">Phone</th>
                                                                        <th scope="col">Email</th>
                                                                        <th scope="col">Date Of Birth</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="manager" items="${s.managers}">
                                                                        <tr>
                                                                            <td>${manager.fullName}</td>
                                                                            <td>${manager.phoneNumber}</td>
                                                                            <td>${manager.email}</td>
                                                                            <td>${manager.dob}</td>
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
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="row text-center">
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3">Showing ${start} - ${end} out of ${totalSubjects}</span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                            <a class="page-link" href="?currentPage=${currentPage - 1}&itemsPerPage=${itemsPerPage}&searchQuery=${searchQuery}&sortField=${sortField}&sortOrder=${sortOrder}" aria-label="Previous">Previous</a>
                                        </li>
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="?currentPage=${i}&itemsPerPage=${itemsPerPage}&searchQuery=${searchQuery}&sortField=${sortField}&sortOrder=${sortOrder}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                            <a class="page-link" href="?currentPage=${currentPage + 1}&itemsPerPage=${itemsPerPage}&searchQuery=${searchQuery}&sortField=${sortField}&sortOrder=${sortOrder}" aria-label="Next">Next</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="../footer/footer.jsp"/>
            </main>
        </div>

        <!-- Toast notifications -->
        <c:if test="${added == 'successful'}">
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
        </c:if>
        <!-- Similar toast notifications for other actions -->

        <!-- JavaScript files -->
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
        <!-- Datepicker -->
        <script src="../assets/js/jquery.timepicker.min.js"></script> 
        <script src="../assets/js/timepicker.init.js"></script> 
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <script>
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

            document.addEventListener('DOMContentLoaded', function () {
                var toastEl = document.getElementById('liveToast');
                if (toastEl) {
                    var toast = new bootstrap.Toast(toastEl, {
                        delay: 2000
                    });
                    toast.show();
                }
            });

            document.getElementById('cancelSearch').addEventListener('click', function () {
                var form = this.closest('form');
                var input = form.querySelector('input[name="searchQuery"]');
                input.value = '';
                form.submit();
            });
        </script>

    </body>
</html>
