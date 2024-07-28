<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="entity.Exam"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>All Exams</title>
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
                        <h5>All Exams</h5>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th scope="col">Exam Name</th>
                                        <th scope="col">Total Questions</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="entry" items="${exams}">
                                        <tr>
                                            <td>${entry.key.title}</td>
                                            <td>${entry.value}</td>
                                            <td>
                                                <a href='/class/exam/edit?examId=${entry.key.id}' class='btn btn-warning'>Edit</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <jsp:include page="../footer/footer.jsp"/>
            </main>
        </div>
        
        <!-- End Success Toast Message -->
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
       
    </body>
</html>
