package controller.lesson;

import entity.Lesson;
import entity.Subject;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.regex.Pattern;
import repository.impl.LessonRepositoryImpl;
import repository.impl.SubjectRepositoryImpl;

@WebServlet(name = "LessonServlet", urlPatterns = {"/lesson", "/lesson/add", "/lesson/delete", "/lesson/update", "/lesson/search"})
public class LessonServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        final String ACTION = request.getServletPath();
        switch (ACTION) {
            case "/lesson/add":
                request.setAttribute("currentSite", "/lesson/add");
                request.getRequestDispatcher("/lesson/add.jsp").forward(request, response);
                break;
            case "/lesson/update":
                updateLesson(request, response);
                break;
            case "/lesson/search":
                searchLesson(request, response);
                break;
            default:
                showAllLesson(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        final String ACTION = request.getServletPath();
        switch (ACTION) {
            case "/lesson/add":
                addLesson(request, response);
                break;
            case "/lesson/update":
                updateLesson(request, response);
                break;
            case "/lesson/search":
                searchLesson(request, response);
                break;
            default:
                showAllLesson(request, response);
                break;
        }
    }

    private void showAllLesson(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        LessonRepositoryImpl lri = LessonRepositoryImpl.getInstance();
        List<Lesson> lLesson = lri.findAll();
        SubjectRepositoryImpl sri = SubjectRepositoryImpl.getInstance();
        List<Subject> lSubject = sri.findAll();
        request.setAttribute("lessonList", lLesson);
        request.setAttribute("subjectList", lSubject);
        request.setAttribute("currentSite", "/lesson");
        request.getRequestDispatcher("/lesson/all.jsp").forward(request, response);
    }

    protected void searchLesson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("SubjectId").equals("ALL") && request.getParameter("Status").equals("ALL")) {
            LessonRepositoryImpl lri = LessonRepositoryImpl.getInstance();
            List<Lesson> lLesson = lri.findAll();
            request.setAttribute("lessonList", lLesson);
        } else if (!request.getParameter("SubjectId").equals("ALL") && !request.getParameter("Status").equals("ALL")) {
            //get subject id and status
            Long SubjectId = Long.parseLong(request.getParameter("SubjectId"));
            String Status = request.getParameter("Status");
            //find lesson by subject id and status then send it
            LessonRepositoryImpl lri = LessonRepositoryImpl.getInstance();
            List<Lesson> lLesson = lri.findBySubjectAndStatus(SubjectId, Status);
            request.setAttribute("lessonList", lLesson);
        } else if (!request.getParameter("SubjectId").equals("ALL") && request.getParameter("Status").equals("ALL")) {
            //get subject id 
            Long SubjectId = Long.parseLong(request.getParameter("SubjectId"));
            //find lesson by subject id then send it
            LessonRepositoryImpl lri = LessonRepositoryImpl.getInstance();
            List<Lesson> lLesson = lri.findBySubject(SubjectId);
            request.setAttribute("lessonList", lLesson);
        } else if (request.getParameter("SubjectId").equals("ALL") && !request.getParameter("Status").equals("ALL")) {
            //get status
            String Status = request.getParameter("Status");
            //find lesson by status then send it
            LessonRepositoryImpl lri = LessonRepositoryImpl.getInstance();
            List<Lesson> lLesson = lri.findByStatus(Status);
            request.setAttribute("lessonList", lLesson);
        }
        SubjectRepositoryImpl sri = SubjectRepositoryImpl.getInstance();
        List<Subject> lSubject = sri.findAll();
        request.setAttribute("subjectList", lSubject);
        request.setAttribute("currentSite", "/lesson");
        request.getRequestDispatcher("/lesson/all.jsp").forward(request, response);
    }

    private void updateLesson(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //get lessonid, name, status, subject id
        LessonRepositoryImpl lri = LessonRepositoryImpl.getInstance();
        Long LessonId = Long.valueOf(request.getParameter("lessonId"));
        String LessonName = String.valueOf(request.getParameter("lessonName"));
        String Status = String.valueOf(request.getParameter("status"));
        SubjectRepositoryImpl sri = SubjectRepositoryImpl.getInstance();
        Long SubjectId = Long.valueOf(request.getParameter("subjectId"));

        Lesson lesson = new Lesson(LessonId, LessonName, Status, sri.findById(SubjectId));
        Lesson isUpdated = lri.save(lesson);
        if (isUpdated != null) {
            response.sendRedirect("/lesson?&updated=yes");
        } else {
            response.sendRedirect("/lesson?&updated=no");
        }
    }

    private void addLesson(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get lesson name, subject id, status
        String lessonName = request.getParameter("lessonName");

        long subjectId = Long.parseLong(request.getParameter("subjectId"));
        String Status = request.getParameter("status");

        SubjectRepositoryImpl sri = SubjectRepositoryImpl.getInstance();
        Subject s = sri.findById(subjectId);

        //check input
        String fullNameRegex = "^[\\w ]{0,99}$";
        Pattern pattern = Pattern.compile(fullNameRegex, Pattern.UNICODE_CHARACTER_CLASS);
        if (!pattern.matcher(lessonName).matches()) {
            request.setAttribute("lessonNameError", "Lesson name must be less than 100 characters");
            request.setAttribute("currentSite", "/lesson/add");
            request.getRequestDispatcher("/lesson/add.jsp").forward(request, response);
        }
        //add lesson
        LessonRepositoryImpl lri = LessonRepositoryImpl.getInstance();
        Lesson lesson = new Lesson(null, lessonName, Status, s);
        Lesson savedLesson = lri.save(lesson);
        List<Lesson> lLesson = lri.findBySubject(subjectId);
        request.setAttribute("lessonList", lLesson);
        request.setAttribute("subjectId", subjectId);
        if (savedLesson == null) {
            request.setAttribute("error", "Failed to add subject. Please try again.");
            request.setAttribute("currentSite", "/lesson");
            request.getRequestDispatcher("/lesson").forward(request, response);
        } else {
            request.setAttribute("success", "Subject added successfully.");
            request.setAttribute("currentSite", "/lesson");
            request.getRequestDispatcher("/lesson").forward(request, response);
        }
    }

}
