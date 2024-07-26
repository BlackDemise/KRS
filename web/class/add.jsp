<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Add A New Class</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="../../../add-class.jsp" />
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

        .status-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .status-group label {
            margin-bottom: 0;
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
                        <h5 class="mb-0">Create A New Class</h5>
                        <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                            <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                <li class="breadcrumb-item">Classes</li>
                                <li class="breadcrumb-item active" aria-current="page"><a href="/admin/add-class.jsp">Add Class</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 mt-4">
                            <div class="card border-0 p-4 rounded shadow">
                                <c:if test="${not empty duplicateError}">
                                    <div class="alert alert-danger" role="alert">
                                        ${duplicateError}
                                    </div>
                                </c:if>
                                <form class="mt-4" action="${pageContext.request.contextPath}/class/add" method="post" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label for="file">Upload Excel File:</label>
                                        <input type="file" name="file" id="file" class="form-control">
                                    </div>
                                    <div class="row form-row">
                                        <div class="col-md-6 form-group">
                                            <label for="className">Class Name*</label>
                                            <input type="text" id="className" name="className" placeholder="Enter class name" class="form-control" value="${className != null ? className : ''}">
                                            <c:if test="${not empty classNameError}">
                                                <div style="color: red;">${classNameError}</div>
                                            </c:if>
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label for="code">Code*</label>
                                            <select id="code" name="code" class="form-control">
                                                <option value="">Select code</option>
                                                <c:forEach var="subject" items="${subjects}">
                                                    <option value="${subject.id}" <c:if test="${subject.id.toString() == codeStr}">selected</c:if>>${subject.code}</option>
                                                </c:forEach>
                                            </select>
                                            <c:if test="${not empty codeError}">
                                                <div style="color: red;">${codeError}</div>
                                            </c:if>
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label for="teacher">Teacher*</label>
                                            <select id="teacher" name="teacher" class="form-control">
                                                <option value="">Select teacher</option>
                                                <c:forEach var="teacher" items="${teachers}">
                                                    <option value="${teacher.id}" <c:if test="${teacher.id.toString() == teacherIdStr}">selected</c:if>>${teacher.fullName}</option>
                                                </c:forEach>
                                            </select>
                                            <c:if test="${not empty teacherError}">
                                                <div style="color: red;">${teacherError}</div>
                                            </c:if>
                                        </div>
                                        <div class="col-md-6 form-group">
                                            <label>Status*</label>
                                            <div class="status-group">
                                                <div>
                                                    <input type="radio" id="active" name="status" value="ACTIVE" ${status == 'ACTIVE' ? 'checked' : ''}>
                                                    <label for="active">Active</label>
                                                </div>
                                                <div>
                                                    <input type="radio" id="inactive" name="status" value="INACTIVE" ${status == 'INACTIVE' ? 'checked' : ''}>
                                                    <label for="inactive">Inactive</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Add Class</button>
                                    <button type="button" class="btn btn-danger" onclick="window.location.href = '${pageContext.request.contextPath}/class'">Cancel</button>
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
    <script type="text/javascript">
        const currentSite = '${currentSite}';
    </script>
    <!-- Main Js -->
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>
