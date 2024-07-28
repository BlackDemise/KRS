package controller.student;

import dto.ExamDetailsDto;
import dto.QuestionDto;
import dto.SubjectDto;
import entity.Answer;
import entity.Classroom;
import entity.Exam;
import entity.ExamDetails;
import entity.Lesson;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import repository.impl.AnswerRepositoryImpl;
import repository.impl.ExamRepositoryImpl;
import repository.impl.QuestionRepositoryImpl;
import service.impl.ClassServiceImpl;
import service.impl.ExamServiceImpl;
import service.impl.LessonServiceImpl;
import service.impl.SubjectServiceImpl;

@WebServlet(name = "StudentServlet", urlPatterns = {"/my-subjects", "/my-subjects/class", "/my-subjects/exam",
    "/my-subjects/exam/submit"})
public class StudentServlet extends HttpServlet {

    private final ClassServiceImpl classService = ClassServiceImpl.getInstance();
    private final LessonServiceImpl lessonService = LessonServiceImpl.getInstance();
    private final SubjectServiceImpl subjectService = SubjectServiceImpl.getInstance();
    private final ExamServiceImpl examService = ExamServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        final String ACTION = request.getServletPath();
        HttpSession session = request.getSession(false);
        User current = (User) session.getAttribute("user");
        Long studentId = current.getId();
        switch (ACTION) {
            case "/my-subjects" -> {
                String searchQuery = request.getParameter("searchQuery");
                if (searchQuery == null || searchQuery.isEmpty()) {
                    searchQuery = "%%";
                } else {
                    request.setAttribute("searchQuery", searchQuery);
                    searchQuery = "%" + searchQuery + "%";
                }
                List<SubjectDto> subjectDtos = subjectService.getSubjectStatisticsByStudent(studentId, searchQuery);
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
                String classIdParam = request.getParameter("classId");
                List<Classroom> classrooms = classService.findByStudent(studentId);
                request.setAttribute("classList", classrooms);

                Classroom selectedClass = null;

                if (classIdParam != null) {
                    Long classId = Long.valueOf(classIdParam);
                    for (Classroom c : classrooms) {
                        if (c.getId().equals(classId)) {
                            selectedClass = c;
                            break;
                        }
                    }
                }

                if (selectedClass == null && !classrooms.isEmpty()) {
                    selectedClass = classrooms.get(0);
                    classIdParam = selectedClass.getId().toString(); // Update classIdParam to the first class's ID
                }

                request.setAttribute("classroom", selectedClass);

                List<Lesson> lessons = lessonService.findBySubject(subjectId);
                request.setAttribute("currentSite", "/my-classes");
                request.setAttribute("lessonList", lessons);
                request.setAttribute("subjectId", subjectId);

                // Fetch exams for the selected class
                if (selectedClass != null) {
                    Map<Exam, Integer> exams = examService.findByClassId(selectedClass.getId());
                    request.setAttribute("exams", exams);
                }

                try {
                    request.getRequestDispatcher("/student/class-details.jsp").forward(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(StudentServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "/my-subjects/exam" -> {
                String examId = request.getParameter("id");
                if (examId != null) {
                    Long eId = Long.valueOf(examId);
                    Exam exam = examService.findById(eId);
                    Map<Long, List<QuestionDto>> questionsMap = examService.findQuestionsInAnExam(eId);
                    request.setAttribute("questionsMap", questionsMap);
                    request.setAttribute("exam", exam);
                }

                try {
                    request.getRequestDispatcher("/student/test.jsp").forward(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(StudentServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        final String ACTION = request.getServletPath();
        HttpSession session = request.getSession(false);
        User current = (User) session.getAttribute("user");
        Long studentId = current.getId();
        switch (ACTION) {
            case "/my-subjects/exam/submit" -> {
                Long examId = Long.valueOf(request.getParameter("examId"));
                AnswerRepositoryImpl ari = AnswerRepositoryImpl.getInstance();
                Map<Long, Long> correctAnswers = ari.getCorrectAnswersByExamId(examId);
                for (Map.Entry<Long, Long> entry : correctAnswers.entrySet()) {
                    System.out.println("Question ID: " + entry.getKey() + ", Correct Answer ID: " + entry.getValue());
                }

                int score = 0;

                QuestionRepositoryImpl qri = QuestionRepositoryImpl.getInstance();
                ExamRepositoryImpl eri = ExamRepositoryImpl.getInstance();

                Exam e = eri.findById(examId);

                Long selectedAnswerId;
                List<ExamDetailsDto> examDetailsList = new ArrayList<>();

                for (Long questionId : correctAnswers.keySet()) {
                    String answerParam = request.getParameter("question_" + questionId);
                    System.out.println(answerParam);
                    if (answerParam != null) {
                        selectedAnswerId = Long.valueOf(answerParam);
                        if (correctAnswers.get(questionId).equals(selectedAnswerId)) {
                            score++;
                        }
                        Answer submitted = ari.findById(selectedAnswerId);
                        Answer correct = ari.findById(correctAnswers.get(questionId));
                        ExamDetailsDto edDto = new ExamDetailsDto();
                        edDto.setExamId(e.getId());
                        edDto.setExamTitle(e.getTitle());
                        edDto.setClassName(e.getTakenClass().getTitle());
                        edDto.setQuestionId(questionId);
                        edDto.setStudentId(studentId);
                        edDto.setSubmittedAnswerId(submitted.getAnswerId());
                        edDto.setCorrectAnswerId(correct.getAnswerId());
                        edDto.setTakenAt(LocalDateTime.now());

                        examDetailsList.add(edDto);

                        ExamDetails ed = new ExamDetails(null, current, e, qri.findById(questionId), submitted, correct, LocalDateTime.now());
                        try {
                            eri.saveExamDetails(ed);
                        } catch (SQLException ex) {
                            Logger.getLogger(StudentServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }

                request.setAttribute("score", score);
                request.setAttribute("totalQuestions", correctAnswers.size());
                request.setAttribute("examDetailsList", examDetailsList);
                try {
                    response.sendRedirect("/my-subjects");
                } catch (IOException ex) {
                    Logger.getLogger(StudentServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

            }
        }
    }
}

/* What are you going to do with these methods?


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
