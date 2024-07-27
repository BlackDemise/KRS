<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>My Flashcard</title>
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
                        <div class="row bg-soft-dark py-3">
                            <h5>Recent Access</h5>
                            <c:forEach var="fl" items="${top3Flashcard}" varStatus="status">
                                <div class="col-4">
                                    <div class="card" style="width: 18rem;border-radius: 10px">
                                        <div class="card-body">
                                            <h5 class="card-title">${fl.name}</h5>
                                            <h6 class="card-subtitle mb-2 text-body-secondary">${totalCardsOfTop3[status.index]}</h6>
                                            <p class="card-text">${creators[status.index].fullName} - ${creators[status.index].role.title.userRole}</p>
                                            <a href="${pageContext.request.contextPath}/flashcard/flashcard-details?flId=${fl.id}" class="card-link">Learn</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <hr>
                        <div class="row bg-soft-dark py-3">
                            <h5>My Flashcards</h5>
                            <c:forEach var="fl" items="${myFlashcards}" varStatus="status">
                                <div class="col-4">
                                    <div class="card" style="width: 18rem;border-radius: 10px">
                                        <div class="card-body">
                                            <h5 class="card-title">${fl.name}</h5>
                                            <h6 class="card-subtitle mb-2 text-body-secondary">${totalMyCard[status.index]}</h6>
                                            <p class="card-text">${sessionScope.user.fullName} - ${sessionScope.user.role.title.userRole}</p>
                                            <a href="${pageContext.request.contextPath}/flashcard/flashcard-details?flId=${fl.id}" class="card-link btn btn-warning">Learn</a>
                                            <a href="${pageContext.request.contextPath}/flashcard/update-flashcard?flId=${fl.id}" class="btn btn-warning">Edit</a>
                                        </div>
                                    </div>
                                </div>

                            </c:forEach>
                        </div>
                        <div class="row">
                            <div class="col-12 d-flex justify-content-center align-content-center">
                                <a href="${pageContext.request.contextPath}/flashcard/add-flashcard" class="btn btn-warning">Add A New Flashcard</a>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="../footer/footer.jsp"/>
            </main>
        </div>

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

    </body>
</html>
