<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>My Subjects</title>
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
        <!-- Icons -->
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link href="../assets/css/tiny-slider.css" rel="stylesheet" />
        <!-- Css -->
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            .container {
                width: 100%;
                max-width: 800px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin: 20px auto;
            }

            .question-box {
                margin: 20px 0;
            }

            .question {
                font-size: 18px;
                margin-bottom: 20px;
            }

            .answers {
                display: flex;
                flex-direction: column;
            }

            .answer {
                background-color: #f9f9f9;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 10px;
                margin: 5px 0;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .answer:hover {
                background-color: #e0e0e0;
            }

            .selected {
                background-color: #d4edda;
                border-color: #c3e6cb;
            }

            #timer {
                font-size: 20px;
                font-weight: bold;
                margin-bottom: 20px;
            }
        </style>
    </head>

    <body>
        <!-- Loader -->
        <jsp:include page="../loader/loader.jsp"/>
        <!-- Loader -->

        <div class="page-wrapper doctris-theme toggled">
            <!-- Vertical Navbar -->
            <jsp:include page="../navbar/vertical.jsp"/>
            <!-- Vertical Navbar -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="../navbar/horizontal.jsp"/>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div id="timer"></div>
                        <form action="/my-subjects/exam/submit" method="post" id="examForm">
                            <input type="hidden" name="examId" value="${param.id}">
                            <c:forEach var="entry" items="${questionsMap}" varStatus="status">
                                <div class="question-box">
                                    <c:set var="questionDetails" value="${entry.value[0]}" />
                                    <h2>Question ${status.index + 1}:</h2>
                                    <p class="question">${questionDetails.questionContent}</p>
                                    <div class="answers">
                                        <c:forEach var="answer" items="${entry.value}">
                                            <div class="answer" onclick="selectAnswer(this)">
                                                <input type="radio" name="question_${status.index}" value="${answer.answerId}" style="display:none">
                                                <input type="hidden" name="questionId_${status.index}" value="${questionDetails.questionId}">
                                                ${answer.answer}
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:forEach>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </form>
                    </div>
                </div><!--end container-->


                <!-- Footer Start -->
                <footer class="bg-white shadow py-3">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col">
                                <div class="text-sm-start text-center">
                                    <p class="mb-0 text-muted"><script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i class="mdi mdi-heart text-danger"></i> by <a href="../../../index.html" target="_blank" class="text-reset">Shreethemes</a>.</p>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div><!--end container-->
                </footer><!--end footer-->
                <!-- End -->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

        <!-- javascript -->
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="../assets/js/simplebar.min.js"></script>
        <!-- Chart -->
        <script src="../assets/js/apexcharts.min.js"></script>
        <script src="../assets/js/columnchart.init.js"></script>
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <script type="text/javascript">
                                        const currentSite = '${currentSite}';
        </script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>
        <script>
                                        function selectAnswer(element) {
                                            // Remove 'selected' class from all answer elements within the same question box
                                            const questionBox = element.closest('.question-box');
                                            const answers = questionBox.querySelectorAll('.answer');
                                            answers.forEach(answer => {
                                                answer.classList.remove('selected');
                                            });

                                            // Add 'selected' class to the clicked answer element
                                            element.classList.add('selected');

                                            // Check the hidden radio input
                                            const radioInput = element.querySelector('input[type="radio"]');
                                            radioInput.checked = true;
                                        }

                                        // Countdown Timer
                                        const duration = ${exam.duration}; // Duration in minutes
                                        if (!isNaN(duration)) {
                                            const endTime = new Date().getTime() + duration * 60000;

                                            const timerInterval = setInterval(() => {
                                                const now = new Date().getTime();
                                                const distance = endTime - now;

                                                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                                                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                                                const seconds = Math.floor((distance % (1000 * 60)) / 1000);

                                                document.getElementById('timer').innerHTML = "Time Remaining: " +
                                                        ("0" + hours).slice(-2) + ":" +
                                                        ("0" + minutes).slice(-2) + ":" +
                                                        ("0" + seconds).slice(-2);

                                                if (distance < 0) {
                                                    clearInterval(timerInterval);
                                                    document.getElementById('timer').innerHTML = "EXPIRED";
                                                    document.getElementById('examForm').submit(); // Automatically submit the form when time is up
                                                }
                                            }, 1000);
                                        } else {
                                            document.getElementById('timer').innerHTML = "Invalid exam duration.";
                                        }
        </script>
    </body>

</html>