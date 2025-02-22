<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="repository.impl.SubjectRepositoryImpl"%>
<%@page import="java.util.List"%>
<%@page import="entity.Subject"%>
<%@page import="entity.Answer"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.ico.png">
        <title>Learn</title>

        <!-- Bootstrap core CSS -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">


        <!-- Additional CSS Files -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/fontawesome.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/templatemo-scholar.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/owl.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/animate.css">

        <link rel="stylesheet"href="https://unpkg.com/swiper@7/swiper-bundle.min.css"/>
        <link href="${pageContext.request.contextPath}/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

        <style>
            .answer {
                cursor: pointer;
                transition: all 0.25s ease;
            }
            .answer p {
                width: 100%;
                height: auto;
            }
            .answer:hover, .answer.clicked {
                background-color: #cccccc;
            }
            .answer p:hover, .answer.clicked p {
                color: black;
            }
        </style>
    </head>

    <body>

        <!-- ***** Preloader Start ***** -->
        <div id="js-preloader" class="js-preloader">
            <div class="preloader-inner">
                <span class="dot"></span>
                <div class="dots">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
        </div>
        <!-- ***** Preloader End ***** -->

        <!-- ***** Header Area Start ***** -->
        <header class="header-area header-sticky py-4" style="background-color: #7a6ad8;position:absolute;top:0">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <nav class="main-nav">
                            <!-- ***** Logo Start ***** -->
                            <a href="/main/homepage.jsp" class="logo">
                                <h1>KRS</h1>
                            </a>
                            <!-- ***** Logo End ***** -->
                            <!-- ***** Serach Start ***** -->
                            <div class="search-input">
                                <form id="search" action="#">
                                    <input type="text" placeholder="Type Something" id='searchText' name="searchKeyword" onkeypress="handle" />
                                    <i class="fa fa-search"></i>
                                </form>
                            </div>
                            <!-- ***** Serach Start ***** -->
                            <!-- ***** Menu Start ***** -->
                            <ul class="nav">
                                <li class="scroll-to-section"><a href="#top" class="active">Home</a></li>
                                <li class="scroll-to-section"><a href="#services">Services</a></li>
                                <li class="scroll-to-section"><a href="#about">About</a></li>
                                <li class="scroll-to-section"><a href="#courses">Subjects</a></li>
                                <li class="scroll-to-section"><a href="#team">Teacher</a></li>
                                <li class="scroll-to-section"><a href="#contact">Contact</a></li>
                                    <c:choose>
                                        <c:when test="${sessionScope.user == null}">
                                        <li class="scroll-to-section"><a href="/main/login.jsp">Login</a></li>
                                        <li class="scroll-to-section"><a href="/main/register.jsp">Register</a></li>
                                        </c:when>
                                        <c:otherwise>
                                        <li class="list-inline-item mb-0 ms-1">
                                            <div class="dropdown dropdown-primary">
                                                <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="${pageContext.request.contextPath}/assets/images/${sessionScope.user.avatar}" class="avatar avatar-ex-small rounded-circle" alt=""></button>
                                                <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px">
                                                    <a class="dropdown-item d-flex align-items-center text-dark" href="#">
                                                        <img src="${pageContext.request.contextPath}/assets/images/${sessionScope.user.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <div class="flex-1 ms-2">
                                                            <span class="d-block mb-1">${sessionScope.user.email}</span>
                                                            <small class="text-muted">${sessionScope.user.role.title}</small>
                                                        </div>
                                                    </a>
                                                    <a class="dropdown-item text-dark" href="/admin/dashboard.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                                    <a class="dropdown-item text-dark" href="/admin/profile.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                                    <div class="dropdown-divider border-top"></div>
                                                    <a class="dropdown-item text-dark" href="/logout"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                                                </div>
                                            </div>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>   
                            <a class='menu-trigger'>
                                <span>Menu</span>
                            </a>
                            <!-- ***** Menu End ***** -->
                        </nav>
                    </div>
                </div>
            </div>
        </header>
        <!-- ***** Header Area End ***** -->

        <div class="container-fluid" style="margin-top: 150px;">
            <c:forEach var="q" items="${questions}">
                <div class="row mx-3 my-5 py-3 px-3" style="border:1px solid black" id="question-area">
                    <div class="col-12 text-center">
                        <p>${q.title}</p>
                    </div>
                    <c:forEach var="a" items="${answers}">
                        <c:choose>
                            <c:when test="${q.id == a.question.id}">
                                <div id="answer-${a.answerId}" data-correct="${a.correct}" style="width:48%;border:2px solid gray;border-radius:7px;text-align: center;margin:10px;padding:10px" class="answer d-flex justify-content-center align-items-center" onclick="checkAnswer(this)">
                                    <p>${a.answer}</p>
                                </div>
                            </c:when>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:forEach>
        </div>

        <div class="container-fluid d-flex justify-content-center" style="margin-top: 10px">
            <button class="btn btn-light mx-2" onclick="resetAnswers()">Reset</button>
            <button class="btn btn-primary mx-2" onclick="goBack()">Back</button>
        </div>
        
        <audio id="correct" src="../assets/sounds/correct-effect.mp3"></audio>
        <audio id="incorrect" src="../assets/sounds/incorrect-effect.mp3"></audio>
        <footer>
            <div class="container">
                <div class="col-lg-12">
                    <p>Copyright © 2024 FPTU, Group 5. All rights reserved. &nbsp;&nbsp;&nbsp; Design: <a href="https://templatemo.com" rel="nofollow" target="_blank">TemplateMo</a> Distribution: <a href="https://themewagon.com" rel="nofollow" target="_blank">ThemeWagon</a></p>
                </div>
            </div>
        </footer>
        <div class="col-lg-12" bottom="0">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.506341942524!2d105.52271427449699!3d21.012416680632832!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e0!3m2!1svi!2s!4v1716569363263!5m2!1svi!2s" style="border:0;width:100%;height:200px" allowfullscreen loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>


        <!-- Scripts -->
        <!-- Bootstrap core JavaScript -->
        <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/isotope.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/owl-carousel.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/counter.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/custom.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/contact-form.js"></script>
        <script>
                // Get all the question elements
                let questions = document.querySelectorAll('#question-area');

// Add click event listener to each answer within each question
                questions.forEach(function (question) {
                    let answers = question.querySelectorAll('.answer');
                    answers.forEach(function (answer) {
                        answer.addEventListener('click', function () {
                            if (answer.classList.contains('clicked')) {
                                answer.classList.remove('clicked');
                                return;
                            }
                            // Remove .clicked class from all answers within the same question
                            answers.forEach(function (otherAnswer) {
                                otherAnswer.classList.remove('clicked');
                            });

                            // Toggle .clicked class for the clicked answer
                            this.classList.toggle('clicked');
                        });
                    });
                });

        </script>

        <script>
            function checkAnswer(answerDiv) {
                // Get the parent question container
                let questionContainer = answerDiv.closest('.row');

                // Reset the border color for all answer divs within the same question
                let elements = questionContainer.querySelectorAll('[id^="answer-"]');
                elements.forEach((answer) => {
                    answer.style.borderColor = 'gray';
                    answer.classList.remove('clicked');
                });

                // Check if the answer is correct
                var isCorrect = answerDiv.getAttribute('data-correct') === 'true';

                // Change border color based on correctness
                if (isCorrect) {
                    let correctAudio = document.getElementById("correct");
                    correctAudio.play();
                    answerDiv.style.borderColor = 'green';
                } else {
                    let incorrectAudio = document.getElementById("incorrect");
                    incorrectAudio.play();
                    answerDiv.style.borderColor = 'red';
                }
            }
            function resetAnswers() {
                // Get all answer divs
                var answerDivs = document.querySelectorAll('.answer');

                // Reset their border colors
                answerDivs.forEach(function (div) {
                    div.style.borderColor = 'gray';
                    div.classList.remove('clicked');
                });

            }

            function goBack() {
                // Navigate back to the previous page
                window.history.back();
            }
        </script>

    </body>
</html>