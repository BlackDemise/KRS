package controller.student;

import dto.ClassDto;
import dto.SubjectDto;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import service.impl.ClassServiceImpl;
import service.impl.LessonServiceImpl;
import service.impl.MaterialServiceImpl;
import service.impl.SubjectServiceImpl;

@WebServlet(name = "StudentServlet", urlPatterns = {"/my-subjects", "/my-subjects/class"})
public class StudentServlet extends HttpServlet {

    private final ClassServiceImpl classService = ClassServiceImpl.getInstance();
    private final LessonServiceImpl lessonService = LessonServiceImpl.getInstance();
    private final MaterialServiceImpl materialService = MaterialServiceImpl.getInstance();
    private final SubjectServiceImpl subjectService = SubjectServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        final String ACTION = request.getServletPath();
        HttpSession session = request.getSession(false);
        User current = (User) session.getAttribute("user");
        Long studentId = current.getId();
        switch (ACTION) {
            case "/my-subjects" -> {
                List<SubjectDto> subjectDtos = subjectService.getSubjectStatisticsByStudent(studentId);

                request.setAttribute("currentSite", "/my-subjects");
                request.setAttribute("subjectDtos", subjectDtos);
                try {
                    request.getRequestDispatcher("/student/my-subjects.jsp").forward(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(StudentServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "/my-subjects/class" -> {
                Long subjectId = Long.valueOf(request.getParameter("subjectId"));
                if (subjectId != null) {
                    try {
                        request.getRequestDispatcher("/student/class-details.jsp").forward(request, response);
                    } catch (ServletException | IOException ex) {
                        Logger.getLogger(StudentServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else {
                    List<ClassDto> classDtos = classService.getClassStatisticsByStudentAndSubject(subjectId, studentId);

                    request.setAttribute("currentSite", "/my-subjects");
                    request.setAttribute("classDtos", classDtos);
                    try {
                        request.getRequestDispatcher("/student/my-classes.jsp").forward(request, response);
                    } catch (ServletException | IOException ex) {
                        Logger.getLogger(StudentServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }

//            case "/my-classes/flashcard" -> {
//                try {
//                    request.getRequestDispatcher("/student/flashcard.jsp").forward(request, response);
//                } catch (ServletException | IOException ex) {
//                    Logger.getLogger(StudentServlet.class.getName()).log(Level.SEVERE, null, ex);
//                }
//            }
        }
    }
}

/* What are you going to do with these methods?
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long lessonId = Long.valueOf(request.getParameter("lessonId"));
        
        QuestionRepositoryImpl qri = QuestionRepositoryImpl.getInstance();
        List<Question> questions = qri.findByLesson(lessonId);
        
        AnswerRepositoryImpl ari = AnswerRepositoryImpl.getInstance();
        List<Answer> answers = ari.findAll();
        
        request.setAttribute("questions", questions);
        request.setAttribute("answers", answers);
        request.getRequestDispatcher("/student/learn.jsp").forward(request, response);
    }

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User student = (User) session.getAttribute("user");

        Long examId = Long.valueOf(request.getParameter("examId"));
        AnswerRepositoryImpl ari = AnswerRepositoryImpl.getInstance();
        Map<Long, Long> correctAnswers = ari.getCorrectAnswersByExamId(examId);

        int score = 0;

        QuestionRepositoryImpl qri = QuestionRepositoryImpl.getInstance();
        ExamRepositoryImpl eri = ExamRepositoryImpl.getInstance();

        Exam e = eri.findById(examId);

        Long selectedAnswerId;
        for (Long questionId : correctAnswers.keySet()) {
            String answerParam = request.getParameter("question-" + questionId);
            if (answerParam != null) {
                selectedAnswerId = Long.valueOf(answerParam);
                if (correctAnswers.get(questionId).equals(selectedAnswerId)) {
                    score++;
                }
                Answer submitted = ari.findById(selectedAnswerId);
                Answer correct = ari.findById(correctAnswers.get(questionId));
                ExamDetails ed = new ExamDetails(null, student, e, qri.findById(questionId), submitted, correct, LocalDate.now());
                try {
                    eri.saveExamDetails(ed);
                } catch (SQLException ex) {
                    Logger.getLogger(ScoreTestServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

        request.setAttribute("score", score);
        request.setAttribute("totalQuestions", correctAnswers.size());
        request.getRequestDispatcher("/student/test-result.jsp").forward(request, response);
    }

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long examId = Long.valueOf(request.getParameter("id"));
        request.setAttribute("examId", examId);
        
        Long classId = Long.valueOf(request.getParameter("classId"));
        request.setAttribute("classId", classId);
        
        QuestionRepositoryImpl qri = QuestionRepositoryImpl.getInstance();
        List<Question> questions = qri.findByExam(examId);
        request.setAttribute("questions", questions);
        
        AnswerRepositoryImpl ari = AnswerRepositoryImpl.getInstance();
        List<Answer> answers = ari.findByQuestionInExam(examId);
        request.setAttribute("answers", answers);
        
        ExamRepositoryImpl eri = ExamRepositoryImpl.getInstance();
        Exam e = eri.findById(examId);
        request.setAttribute("duration", e.getDuration());
        
        request.getRequestDispatcher("/student/test.jsp").forward(request, response);
    }
 */
