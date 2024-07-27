package controller.flashcard;

import constant.EFlashcardStatus;
import entity.Flashcard;
import entity.FlashcardSet;
import entity.Subject;
import entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import service.impl.FlashcardServiceImpl;
import service.impl.SubjectServiceImpl;

@WebServlet(name = "FlashcardServlet", urlPatterns = {"/flashcard/all-flashcard", "/flashcard/my-flashcard", "/flashcard/add-flashcard"})
public class FlashcardServlet extends HttpServlet {

    private final SubjectServiceImpl subjectService = SubjectServiceImpl.getInstance();
    private final FlashcardServiceImpl flashcardService = FlashcardServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        final String ACTION = request.getServletPath();
        switch (ACTION) {
            case "/flashcard/all-flashcard":
                request.setAttribute("currentSite", "/flashcard/all-flashcard");
                request.getRequestDispatcher("/flashcard/all-flashcard.jsp").forward(request, response);
                break;
            case "/flashcard/my-flashcard":
                
                request.setAttribute("currentSite", "/flashcard/my-flashcard");
                request.getRequestDispatcher("/flashcard/my-flashcard.jsp").forward(request, response);
                break;
            case "/flashcard/add-flashcard":
                List<Subject> subjects = subjectService.findAll();
                request.setAttribute("subjects", subjects);
                request.setAttribute("currentSite", "/flashcard/all-flashcard");
                request.getRequestDispatcher("/flashcard/add-flashcard.jsp").forward(request, response);
                break;
            default:
//                showAllLesson(request, response);
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
            case "/flashcard/all-flashcard":
//                addLesson(request, response);
                break;
            case "/flashcard/my-flashcard":
//                updateLesson(request, response);
                break;
            case "/flashcard/add-flashcard":
                addFlashcard(request, response);
                break;
            default:
//                showAllLesson(request, response);
                break;
        }
    }

    private void addFlashcard(HttpServletRequest request, HttpServletResponse response) {
        String title = request.getParameter("title");
        String subject = request.getParameter("subject");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String[] term = request.getParameterValues("term");
        String[] definition = request.getParameterValues("definition");

        if (term != null && definition != null && term.length > 0 && definition.length > 0) {
            HttpSession session = request.getSession(false);
            User current = (User) session.getAttribute("user");
            Long createdById = current.getId();

            Flashcard fl = new Flashcard(null, title, description, EFlashcardStatus.valueOf(status), LocalDate.now(), LocalDate.now(), subjectService.findById(Long.valueOf(subject)), createdById, createdById);
            Long isSave = flashcardService.save(fl, request);

            if (isSave == -1) {
                try {
                    request.getRequestDispatcher("/flashcard/add-flashcard.jsp").forward(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(FlashcardServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else {
                for (int i = 0; i < term.length; i++) {
                    //chưa xong
                    FlashcardSet fls = new FlashcardSet(null, term[i], definition[i], LocalDate.now(), LocalDate.now(), fl, createdById, createdById);
                    long isFSSaved = flashcardService.saveFlashcardSet(fls, request);
                    if (isFSSaved == -1) {
                        try {
                            request.getRequestDispatcher("/flashcard/add-flashcard.jsp").forward(request, response);
                        } catch (ServletException | IOException ex) {
                            Logger.getLogger(FlashcardServlet.class.getName()).log(Level.SEVERE, null, ex);
                        } finally {
                            return;
                        }
                    }
                }
                try {
                    request.getRequestDispatcher("/flashcard/all-flashcard.jsp").forward(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(FlashcardServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } else {
            try {
                request.getRequestDispatcher("/flashcard/add-flashcard").include(request, response);
            } catch (ServletException | IOException ex) {
                Logger.getLogger(FlashcardServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

}
