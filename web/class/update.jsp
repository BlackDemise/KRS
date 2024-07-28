<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Update Class</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="../../../update-class.jsp" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="../assets/images/favicon.png">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="${pageContext.request.contextPath}/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="${pageContext.request.contextPath}/assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/flatpickr.min.css">
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Css -->
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

        <style>
            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
            }

            .form-group textarea,
            .form-group select,
            .form-group input[type="text"],
            .form-group input[type="number"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .form-row {
                display: flex;
                gap: 20px;
            }

            .form-row .form-group {
                flex: 1;
            }

            .table-responsive {
                margin-top: 20px;
            }

            .table thead th {
                background-color: #f5f5f5;
                text-align: center;
            }

            .table tbody td {
                text-align: center;
            }

            .table {
                border-collapse: separate;
                border-spacing: 0;
                width: 100%;
                background-color: #ffffff;
            }

            .table th,
            .table td {
                padding: 12px 15px;
                border-bottom: 1px solid #dddddd;
            }

            .table th {
                background-color: #f8f9fa;
                font-weight: bold;
            }

            .table tbody tr:hover {
                background-color: #f1f1f1;
            }

            .btn {
                border-radius: 50px;
                padding: 8px 16px;
                margin: 2px;
            }

            .btn-primary {
                background-color: #007bff;
                border: none;
            }

            .btn-danger {
                background-color: #dc3545;
                border: none;
            }

            .table-title {
                text-align: center;
                font-weight: bold;
                font-size: 1.5rem;
                margin-bottom: 15px;
                color: #333;
            }

            .select-all-container {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .error-message {
                color: red;
                font-size: 0.875rem;
                margin-top: 5px;
            }

            .radio-inline {
                display: inline-block;
                margin-right: 10px;
            }

            .radio-inline input {
                display: none; /* Hide the actual radio button */
            }

            .radio-inline label {
                display: inline-block;
                padding: 10px 20px;
                border: 1px solid #007bff;
                border-radius: 5px;
                background-color: #cce5ff; /* Lighter background color */
                color: #007bff; /* Darker text color */
                cursor: pointer;
                transition: background-color 0.3s, color 0.3s;
            }

            .radio-inline input:checked + label {
                background-color: #007bff; /* Darker background color */
                color: white; /* Lighter text color */
            }

            .radio-inline label:hover {
                background-color: #b3d7ff; /* Slightly darker on hover */
            }
        </style>
    </head>

    <body>
        <jsp:include page="../loader/loader.jsp" />

        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../navbar/vertical.jsp" />

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="../navbar/horizontal.jsp" />
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Update Class</h5>
                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item">Classes</li>
                                    <li class="breadcrumb-item active" aria-current="page"><a href="/admin/update-class.jsp">Update Class</a></li>
                                </ul>
                            </nav>
                        </div>
                        <div class="row">
                            <div class="col-lg-12 mt-4">
                                <div class="card border-0 p-4 rounded shadow">
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger" role="alert">
                                            ${error}
                                        </div>
                                    </c:if>
                                    <form class="mt-4" action="${pageContext.request.contextPath}/class/update" method="post">
                                        <input type="hidden" name="classId" value="${classroom.id}">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="className">Class Name</label>
                                                    <input type="text" id="className" name="className" value="${classroom.title}" placeholder="Enter class name" class="form-control" required>
                                                    <c:if test="${not empty classNameError}">
                                                        <div class="error-message">${classNameError}</div>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="subject">Code</label>
                                                    <select id="subject" name="subject" class="form-control" required>
                                                        <option value="">Select code</option>
                                                        <c:forEach var="subject" items="${subjects}">
                                                            <option value="${subject.id}" <c:if test="${subject.id == classroom.subject.id}">selected</c:if>>${subject.code}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="teacher">Teacher</label>
                                                    <select id="teacher" name="teacher" class="form-control" required>
                                                        <option value="">Select teacher</option>
                                                        <c:forEach var="teacher" items="${teachers}">
                                                            <option value="${teacher.id}" ${teacher.id == classroom.teacher.id ? 'selected' : ''}>
                                                                ${teacher.fullName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Status</label>
                                                    <div class="radio-inline">
                                                        <input type="radio" id="active" name="status" value="ACTIVE" ${classroom.status == 'Active' ? 'checked' : ''}>
                                                        <label for="active">Active</label>
                                                    </div>
                                                    <div class="radio-inline">
                                                        <input type="radio" id="inactive" name="status" value="INACTIVE" ${classroom.status == 'Inactive' ? 'checked' : ''}>
                                                        <label for="inactive">Inactive</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <a href="/class/exam?classId=${classroom.id}" class="btn btn-success">All Exams</a>
                                            <div>
                                                <button type="submit" class="btn btn-primary">Update Class</button>
                                                <button type="button" class="btn btn-danger" onclick="location.href = '${pageContext.request.contextPath}/class'">Cancel</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="../footer/footer.jsp" />
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

        <!-- Success Toast Message -->
        <c:choose>
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
        </c:choose>
        <!-- End Success Toast Message -->

        <!-- javascript -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="${pageContext.request.contextPath}/assets/js/simplebar.min.js"></script>
        <!-- Select2 -->
        <script src="${pageContext.request.contextPath}/assets/js/select2.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/select2.init.js"></script>
        <!-- Datepicker -->
        <script src="${pageContext.request.contextPath}/assets/js/flatpickr.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/flatpickr.init.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
        <script>
                                                    const currentSite = '${currentSite}';
        </script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>

        <script>
                                                    // Select/Deselect all checkboxes
                                                    document.getElementById('select-all').onclick = function () {
                                                        var checkboxes = document.getElementsByName('selectedStudents');
                                                        for (var checkbox of checkboxes) {
                                                            checkbox.checked = this.checked;
                                                        }
                                                    };
        </script>
    </body>
</html>
