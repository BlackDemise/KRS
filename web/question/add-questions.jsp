<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="repository.impl.SubjectRepositoryImpl"%>
<%@page import="java.util.List"%>
<%@page import="entity.Subject"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Add Questions</title>
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
                        <form action="questions/add" method="post" class="w-100">
                            <div class="row">
                                <div class="col-12" id="question-area">
                                    <div class="question-wrapper" style="width: 100%;">
                                        <div class="input-group mx-3 my-3" style="width: 100%">
                                            <input
                                                type="text"
                                                class="form-control"
                                                placeholder="Enter question..."
                                                aria-label="Question"
                                                name="question0"
                                                style="width: 65%"/> <!-- Initial name -->
                                            <select class="form-select mx-3" name="subject0" style="width:15%"> <!-- Initial name -->
                                                <option value="">Select a subject</option>
                                                <c:forEach var="s" items="${subjects}">
                                                    <option value="${s.id}">${s.code}</option>
                                                </c:forEach>
                                            </select>
                                            <button type="button" class="btn btn-primary mx-3" style="width:5%">+</button>
                                        </div>
                                        <div class="input-group mx-3 my-3" style="width: 100%">
                                            <input
                                                type="text"
                                                class="form-control"
                                                placeholder="Enter answer A..."
                                                aria-label="Answer A"
                                                name="answer0A" /> <!-- Initial name -->
                                            <input
                                                type="radio"
                                                name="correct0"
                                                value="A"
                                                class="mx-2"
                                                /> <!-- Radio button for correct answer -->
                                            <input
                                                type="text"
                                                class="form-control mx-3"
                                                placeholder="Enter answer B..."
                                                aria-label="Answer B"
                                                name="answer0B" /> <!-- Initial name -->
                                            <input
                                                type="radio"
                                                name="correct0"
                                                value="B"
                                                class="mx-2"
                                                /> <!-- Radio button for correct answer -->
                                            <input
                                                type="text"
                                                class="form-control mx-3"
                                                placeholder="Enter answer C..."
                                                aria-label="Answer C"
                                                name="answer0C" /> <!-- Initial name -->
                                            <input
                                                type="radio"
                                                name="correct0"
                                                value="C"
                                                class="mx-2"
                                                /> <!-- Radio button for correct answer -->
                                            <input
                                                type="text"
                                                class="form-control mx-3"
                                                placeholder="Enter answer D..."
                                                aria-label="Answer D"
                                                name="answer0D" /> <!-- Initial name -->
                                            <input
                                                type="radio"
                                                name="correct0"
                                                value="D"
                                                class="mx-2"
                                                /> <!-- Radio button for correct answer -->
                                        </div>
                                    </div>
                                </div>
                                <hr>
                                <div class="col-3 text-end" style="width:100%">
                                    <button type="submit" class="btn btn-success my-2">Add</button>
                                </div>
                            </div>
                        </form>
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
        <!-- Custom Js -->
        <script>
            const questionArea = document.getElementById("question-area");
            let index = 1; // initialize index to 1 since the first question is 0

            document.querySelector(".btn-primary").addEventListener("click", function () {
                // Create a wrapper div for the question and answers
                let wrapperDiv = document.createElement("div");
                wrapperDiv.className = "question-wrapper";
                wrapperDiv.style.width = "100%";

                // Clone the question input and subject select group
                let questionGroup = document.querySelector(".input-group").cloneNode(true);
                questionGroup.querySelector('input[type="text"]').name = 'question' + index;
                questionGroup.querySelector('select').name = 'subject' + index;

                // Update the add/remove button
                let addButton = questionGroup.querySelector(".btn-primary");
                addButton.textContent = "-";
                addButton.className = "btn btn-danger mx-3"; // Change to danger button for red color
                addButton.addEventListener("click", function (event) {
                    event.target.closest(".question-wrapper").remove(); // remove the entire question wrapper
                });

                // Create the answers group
                let answersGroup = document.createElement("div");
                answersGroup.className = "input-group mx-3 my-3";
                answersGroup.style.width = "100%";

                // Add answer inputs and radio buttons
                let answerLabels = ['A', 'B', 'C', 'D'];
                answerLabels.forEach((label) => {
                    let answerInput = document.createElement("input");
                    answerInput.type = "text";
                    answerInput.className = "form-control";
                    answerInput.placeholder = `Enter answer ${label}...`;
                    answerInput.ariaLabel = `Answer ${label}`;
                    answerInput.name = `answer${index}${label}`;

                    let radioInput = document.createElement("input");
                    radioInput.type = "radio";
                    radioInput.name = `correct${index}`;
                    radioInput.value = label;
                    radioInput.className = "mx-2";

                    answersGroup.appendChild(answerInput);
                    answersGroup.appendChild(radioInput);
                });

                // Append questionGroup and answersGroup to the wrapper div
                wrapperDiv.appendChild(questionGroup);
                wrapperDiv.appendChild(answersGroup);

                // Append the wrapper div to the question area
                questionArea.appendChild(wrapperDiv);

                index++; // increment index
            });

        </script>
    </body>

</html>