<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="repository.impl.RoleRepositoryImpl"%>
<%@page import="constant.EUserStatus"%>
<%
    RoleRepositoryImpl rri = RoleRepositoryImpl.getInstance();
    request.setAttribute("roles", rri.findAll());
    request.setAttribute("statuses", EUserStatus.values()); 
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Add Flashcard</title>
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
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            .flashcard {
                position: relative;
                border: 1px solid #ccc;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
            }

            .flashcard-number {
                font-weight: bold;
                margin-bottom: 10px;
            }

            .form-row {
                display: flex;
                justify-content: space-between;
            }

            .form-group.flex-item {
                flex: 1;
                margin-right: 20px;
            }

            .form-group.flex-item:last-child {
                margin-right: 0;
            }
            
            label {
                font-weight: bold;
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
                        <h2>Add a New FlashCard Set</h2>
                        <form id="flashcardForm" action="/flashcard/add-flashcard" method="post">
                            <div class="form-row">
                                
                                <div class="form-group flex-item">
                                    <label for="flashcardTitle">Title</label>
                                    <input type="text" class="form-control" id="flashcardTitle" name="title" placeholder="Enter title">
                                </div>
                                
                                <div class="form-group flex-item">
                                    <label for="flashcardSubject">Subject</label>
                                    <select class="form-control" id="flashcardSubject" name="subject">
                                        <c:forEach var="s" items="${subjects}">
                                            <option value="${s.id}">${s.code}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-group mt-3">
                                <label for="flashcardDescription">Description</label>
                                <textarea class="form-control" id="flashcardDescription" name="description" rows="3" placeholder="Enter description"></textarea>
                            </div>
                            
                            <div class="form-group flex-item">
                                <label for="flashcardSubject">Status</label>
                                <input type="radio" name="status" value="SHOW">Show
                                <input type="radio" name="status" value="HIDDEN">Hidden
                            </div>
                            <div id="flashcards" class="mt-4">
                                <!-- Initial Flashcard -->
                                <div class="flashcard mb-3 row">
                                    <div class="col-12 d-flex justify-content-between align-items-center">
                                        <div class="flashcard-number">Card 1</div>
                                        <button type="button"
                                                class="btn btn-soft-danger mb-3 d-flex justify-content-center align-items-center remove-flashcard"
                                                style="height:40px;width:40px">
                                            <i class="uil uil-trash"></i>
                                        </button>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <textarea class="form-control" name="term" rows="3" placeholder="Enter term"></textarea>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <textarea class="form-control" name="definition" rows="3" placeholder="Enter definition"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button type="button" class="btn btn-primary" id="addFlashcard">Add New Flashcard</button>
                            <button type="submit" class="btn btn-success">Save Flashcards</button>
                        </form>
                    </div>
                </div>

                <jsp:include page="../footer/footer.jsp" />
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

        <!-- javascript -->
        <script src="../assets/js/jquery.min.js"></script>
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- Add other JS links here -->
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
        <script>
            document.getElementById('addFlashcard').addEventListener('click', function () {
                var flashcards = document.getElementById('flashcards');
                var flashcardCount = flashcards.getElementsByClassName('flashcard').length;
                var newFlashcard = flashcards.children[0].cloneNode(true);

                // Update flashcard number
                newFlashcard.querySelector('.flashcard-number').textContent = 'Card ' + (flashcardCount + 1);

                // Clear the textareas
                var textareas = newFlashcard.getElementsByTagName('textarea');
                for (var i = 0; i < textareas.length; i++) {
                    textareas[i].value = '';
                }

                // Append the new flashcard to the flashcards div
                flashcards.appendChild(newFlashcard);

                updateFlashcardNumbers();
            });

            document.getElementById('flashcards').addEventListener('click', function (e) {
                if (e.target && e.target.closest('.remove-flashcard')) {
                    var flashcard = e.target.closest('.flashcard');
                    flashcard.remove();
                    updateFlashcardNumbers();
                }
            });

            function updateFlashcardNumbers() {
                var flashcards = document.getElementsByClassName('flashcard');
                for (var i = 0; i < flashcards.length; i++) {
                    flashcards[i].querySelector('.flashcard-number').textContent = 'Card ' + (i + 1);
                }
            }
        </script>
    </body>

</html>
