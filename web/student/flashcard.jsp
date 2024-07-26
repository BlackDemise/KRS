<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Flashcards</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
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

        .flashcard-count {
            font-size: 18px;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2 class="text-center my-4">Flashcard Page</h2>
        <div class="flashcard-container">
            <div class="flashcard-count">
                <span id="currentFlashcardNumber">1</span> / <span id="totalFlashcards">${questions.size()}</span>
            </div>
            <div class="flashcard" onclick="this.classList.toggle('flipped')">
                <div class="flashcard-inner">
                    <div class="flashcard-front">
                        <c:out value="${questions[0].content}" /><br>
                        <c:forEach var="answer" items="${answers}">
                            <c:if test="${answer.question.id == questions[0].id}">
                                <c:out value="${answer.answer}" /><br>
                            </c:if>
                        </c:forEach>
                    </div>
                    <div class="flashcard-back">
                        <c:forEach var="answer" items="${answers}">
                            <c:if test="${answer.question.id == questions[0].id && answer.isCorrect}">
                                <c:out value="${answer.answer}" />
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="flashcard-nav">
                <button id="prevFlashcard">Previous</button>
                <button id="nextFlashcard">Next</button>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            let currentFlashcard = 0;
            const flashcards = [];
            <c:forEach var="question" items="${questions}">
                const answers = [];
                const correctAnswers = [];
                <c:forEach var="answer" items="${answers}">
                    <c:if test="${answer.question.id == question.id}">
                        answers.push("${answer.answer}");
                        <c:if test="${answer.isCorrect}">
                            correctAnswers.push("${answer.answer}");
                        </c:if>
                    </c:if>
                </c:forEach>
                flashcards.push({
                    question: "${question.content}",
                    answers: answers,
                    correctAnswers: correctAnswers
                });
            </c:forEach>

            function loadFlashcard(index) {
                document.querySelector(".flashcard-front").innerHTML = flashcards[index].question + '<br>' + flashcards[index].answers.join('<br>');
                document.querySelector(".flashcard-back").innerHTML = flashcards[index].correctAnswers.join('<br>');
                document.getElementById("currentFlashcardNumber").textContent = index + 1;
            }

            document.getElementById("prevFlashcard").addEventListener("click", function() {
                if (currentFlashcard > 0) {
                    currentFlashcard--;
                    loadFlashcard(currentFlashcard);
                    document.querySelector(".flashcard").classList.remove("flipped");
                }
            });

            document.getElementById("nextFlashcard").addEventListener("click", function() {
                if (currentFlashcard < flashcards.length - 1) {
                    currentFlashcard++;
                    loadFlashcard(currentFlashcard);
                    document.querySelector(".flashcard").classList.remove("flipped");
                }
            });

            loadFlashcard(currentFlashcard);
        });
    </script>
</body>

</html>
