<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Flashcard Details</title>
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
        <style>
            .flashcard-container {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 80vh;
                flex-direction: column;
            }

            .flashcard {
                position: relative;
                width: 500px;
                height: 300px;
                perspective: 1000px;
                margin: 20px 0;
            }

            .flashcard-inner {
                position: absolute;
                width: 100%;
                height: 100%;
                transition: transform 0.6s;
                transform-style: preserve-3d;
            }

            .flashcard.flipped .flashcard-inner {
                transform: rotateY(180deg);
            }

            .flashcard-front,
            .flashcard-back {
                position: absolute;
                width: 100%;
                height: 100%;
                backface-visibility: hidden;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 24px;
                text-align: center;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .flashcard-front {
                background-color: #fff;
            }

            .flashcard-back {
                background-color: #f8f9fa;
                transform: rotateY(180deg);
            }

            .flashcard-nav {
                margin-top: 20px;
            }

            .flashcard-nav button {
                background-color: #007bff;
                border: none;
                color: white;
                padding: 10px 20px;
                font-size: 18px;
                border-radius: 5px;
                cursor: pointer;
                outline: none;
                transition: background-color 0.3s;
            }

            .flashcard-nav button:hover {
                background-color: #0056b3;
            }

            .flashcard-nav button:disabled {
                background-color: #cccccc;
                cursor: not-allowed;
            }

            .flashcard-count {
                font-size: 18px;
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
                        <h2 class="text-center">Flashcard Page</h2>
                        <div class="flashcard-container">
                            <div class="flashcard-count">
                                <span id="currentFlashcardNumber">1</span> / <span id="totalFlashcards">${listFlashcardSet.size()}</span>
                            </div>
                            <div class="flashcard" onclick="this.classList.toggle('flipped')">
                                <c:forEach var="fls" items="${listFlashcardSet}">
                                    <div class="flashcard-inner">
                                        <div class="flashcard-front">
                                            <p>${fls.name}</p>
                                        </div>
                                        <div class="flashcard-back">
                                            <p>${fls.answer}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="flashcard-nav">
                                <button id="prevFlashcard" disabled>Previous</button>
                                <button id="nextFlashcard">Next</button>
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
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const flashcards = document.querySelectorAll('.flashcard-inner');
                const currentFlashcardNumber = document.getElementById('currentFlashcardNumber');
                const totalFlashcardsElement = document.getElementById('totalFlashcards');
                const totalFlashcards = flashcards.length;
                const prevButton = document.getElementById('prevFlashcard');
                const nextButton = document.getElementById('nextFlashcard');
                let currentIndex = 0;

                // Function to update flashcard display
                function updateFlashcardDisplay() {
                    flashcards.forEach((flashcard, index) => {
                        flashcard.style.display = index === currentIndex ? 'block' : 'none';
                    });

                    currentFlashcardNumber.textContent = currentIndex + 1;
                    prevButton.disabled = currentIndex === 0;
                    nextButton.disabled = currentIndex === totalFlashcards - 1;
                }

                // Add event listeners to buttons
                prevButton.addEventListener('click', () => {
                    if (currentIndex > 0) {
                        currentIndex--;
                        updateFlashcardDisplay();
                    }
                });

                nextButton.addEventListener('click', () => {
                    if (currentIndex < totalFlashcards - 1) {
                        currentIndex++;
                        updateFlashcardDisplay();
                    }
                });

                // Initialize the display
                if (totalFlashcardsElement) {
                    totalFlashcardsElement.textContent = totalFlashcards;
                }
                updateFlashcardDisplay();
            });
        </script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>

    </body>
</html>
