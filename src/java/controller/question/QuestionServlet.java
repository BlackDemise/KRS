package controller.question;

import entity.Answer;
import entity.Question;
import entity.Subject;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import repository.impl.QuestionRepositoryImpl;
import repository.impl.SubjectRepositoryImpl;

@WebServlet(urlPatterns = {"/question", "/question/add", "/question/delete", "/question/update"})
public class QuestionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String ACTION = request.getServletPath();
        System.out.println("ACTION = " + ACTION);

        switch (ACTION) {
            case "/question/add":
                SubjectRepositoryImpl sri = SubjectRepositoryImpl.getInstance();
                List<Subject> subjects = sri.findAll();
                request.setAttribute("subjects", subjects);
                request.getRequestDispatcher("/admin/add-questions.jsp").forward(request, response);
                break;
            case "/question/update":
                updateQuestion(request, response);
                break;
            case "/question/delete":
                deleteQuestion(request, response);
                break;
            default:
                showAllQuestion(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String ACTION = request.getServletPath();

        switch (ACTION) {
            case "/question/add" -> {
                processAddQuestion(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void showAllQuestion(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        QuestionRepositoryImpl qri = QuestionRepositoryImpl.getInstance();
        List<Question> lQuestion = qri.findAll();
        request.setAttribute("questionList", lQuestion);
        request.getRequestDispatcher("/admin/all-questions.jsp").forward(request, response);
    }

    private void deleteQuestion(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        Long questionId = Long.valueOf(request.getParameter("questionId"));
        QuestionRepositoryImpl qri = QuestionRepositoryImpl.getInstance();
        Long lessonId = qri.findById(questionId).getLesson().getLessonId();
        boolean isDeleted = qri.deleteById(questionId);
        if (isDeleted) {
            response.sendRedirect("/question?lessonId=" + lessonId + "&deleted=yes");
        } else {
            response.sendRedirect("/question?lessonId=" + lessonId + "&deleted=no");
        }
    }

    private void updateQuestion(HttpServletRequest request, HttpServletResponse response) {
        //get lessonid, name, status, subject id
//        QuestionRepositoryImpl qri = QuestionRepositoryImpl.getInstance();
//        Long QuestionId = Long.valueOf(request.getParameter("QuestionId"));
//        String QuestionName = String.valueOf(request.getParameter("lessonName"));
//        SubjectRepositoryImpl sri = SubjectRepositoryImpl.getInstance();
//        Long SubjectId = Long.valueOf(request.getParameter("subjectId"));
//        SubjectRepositoryImpl
//        Lesson lesson = 
//        Question Question = new Question(QuestionId,LessonName,Status,sri.findSubjectById(SubjectId));
//        Lesson isUpdated = qri.save(Question);
//        if (isUpdated != null) {
//            response.sendRedirect("/lesson?&updated=yes");
//        } else {
//            response.sendRedirect("/lesson?&updated=no");
//        }
    }

    private void processAddQuestion(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Enumeration<String> parameterNames = request.getParameterNames();
        Map<String, String[]> parameterMap = new HashMap<>();

        // Collect all parameters in a map
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            parameterMap.put(paramName, paramValues);
        }

        List<Question> questions = new ArrayList<>();

        int questionIndex = 0;
        while (parameterMap.containsKey("question" + questionIndex)) {
            String questionTitle = parameterMap.get("question" + questionIndex)[0];
            String subjectId = parameterMap.get("subject" + questionIndex)[0];

            Question question = new Question();
            question.setTitle(questionTitle);
            question.setCreatedTime(LocalDate.now());
            question.setLastModifiedTime(LocalDate.now());
            // Set other fields like createdBy, lastModifiedBy, lesson based on your application context

            // Process each answer for this question
            List<Answer> answers = new ArrayList<>();
            char[] answerLabels = {'A', 'B', 'C', 'D'};
            for (char label : answerLabels) {
                String answerParam = "answer" + questionIndex + label;
                String correctParam = "correct" + questionIndex;

                if (parameterMap.containsKey(answerParam)) {
                    String answerText = parameterMap.get(answerParam)[0];
                    boolean isCorrect = parameterMap.containsKey(correctParam) && parameterMap.get(correctParam)[0].equals(String.valueOf(label));

                    Answer answer = new Answer();
                    answer.setAnswer(answerText);
                    answer.setCreatedTime(LocalDate.now());
                    answer.setLastModifiedTime(LocalDate.now());
                    answer.setCorrect(isCorrect);
                    answer.setQuestion(question); // Associate answer with question

                    answers.add(answer);
                }
            }

            // Assuming you have a method to set answers in the question (if needed)
//            question.setAnswers(answers);  // This can be optional or for internal logic
            questions.add(question);
            questionIndex++;

            for (Answer a : answers) {
                System.out.println(a.getAnswer() + " | " + a.isCorrect());
            }
        }

        // For demonstration purposes, we'll just print them out
        for (Question q : questions) {
            System.out.println("Question: " + q.getTitle());
//            for (Answer a : q.getAnswers()) {
//                System.out.println(" - Answer: " + a.getAnswer() + " (Correct: " + a.isCorrect() + ")");
//            }
        }

        response.sendRedirect("/admin/add-questions.jsp");

    }

}
