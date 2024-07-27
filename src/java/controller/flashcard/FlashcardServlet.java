package controller.flashcard;

import constant.EFlashcardStatus;
import entity.Flashcard;
import entity.FlashcardAccess;
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
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import service.impl.FlashcardServiceImpl;
import service.impl.SubjectServiceImpl;
import service.impl.UserServiceImpl;

@WebServlet(name = "FlashcardServlet", urlPatterns = {"/flashcard/all-flashcard", "/flashcard/my-flashcard", "/flashcard/add-flashcard",
    "/flashcard/flashcard-details", "/flashcard/update-flashcard"})
public class FlashcardServlet extends HttpServlet {

    private final SubjectServiceImpl subjectService = SubjectServiceImpl.getInstance();
    private final FlashcardServiceImpl flashcardService = FlashcardServiceImpl.getInstance();
    private final UserServiceImpl userService = UserServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        final String ACTION = request.getServletPath();
        switch (ACTION) {
            case "/flashcard/all-flashcard" -> {
                String flTitle = request.getParameter("flTitle");
                List<Flashcard> listFlashcard;
                List<Integer> totalCards = new ArrayList();
                List<User> users = new ArrayList();
                if (flTitle == null) {
                    listFlashcard = flashcardService.findAll();
                } else {
                    listFlashcard = flashcardService.findByName(flTitle);
                }
                for (Flashcard fl : listFlashcard) {
                    users.add(userService.findById(fl.getCreatedBy()));
                    totalCards.add(flashcardService.countFlashcardSet(fl.getId()));
                }
                request.setAttribute("listFlashcard", listFlashcard);
                request.setAttribute("creators", users);
                request.setAttribute("totalCards", totalCards);
                request.setAttribute("currentSite", "/flashcard/all-flashcard");
                request.getRequestDispatcher("/flashcard/all-flashcard.jsp").forward(request, response);
            }
            case "/flashcard/my-flashcard" -> {
                HttpSession session = request.getSession(false);
                User current = (User) session.getAttribute("user");
                Long createdById = current.getId();

                List<Flashcard> top3Flashcard = flashcardService.findTop3Recent(createdById, 3);
                List<Integer> totalCardsOfTop3 = new ArrayList();
                List<User> users = new ArrayList();
                for (Flashcard fl : top3Flashcard) {
                    users.add(userService.findById(fl.getCreatedBy()));
                    totalCardsOfTop3.add(flashcardService.countFlashcardSet(fl.getId()));
                }
                request.setAttribute("creators", users);
                request.setAttribute("totalCardsOfTop3", totalCardsOfTop3);
                request.setAttribute("top3Flashcard", top3Flashcard);

                List<Flashcard> myFlashcards = flashcardService.findByCreator(createdById);
                request.setAttribute("myFlashcards", myFlashcards);

                //Loi chua su ly duoc
                List<Integer> totalMyCard = new ArrayList<>();
                for (Flashcard fl : myFlashcards) {
                    totalMyCard.add(flashcardService.countFlashcardSet(fl.getId()));
                }
                request.setAttribute("totalMyCard", totalMyCard);
                request.setAttribute("currentSite", "/flashcard/my-flashcard");
                request.getRequestDispatcher("/flashcard/my-flashcard.jsp").forward(request, response);
            }
            case "/flashcard/add-flashcard" -> {
                List<Subject> subjects = subjectService.findAll();
                request.setAttribute("subjects", subjects);
                request.setAttribute("currentSite", "/flashcard/all-flashcard");
                request.getRequestDispatcher("/flashcard/add-flashcard.jsp").forward(request, response);
            }
            case "/flashcard/flashcard-details" -> {
                String flashcardId = request.getParameter("flId");
                HttpSession session = request.getSession(false);
                User u = (User) session.getAttribute("user");
                LocalDateTime accessTime = LocalDateTime.now();
                FlashcardAccess fAccess = FlashcardAccess.builder()
                        .flashcard(flashcardService.findById(Long.valueOf(flashcardId)))
                        .user(u)
                        .accessTime(accessTime)
                        .build();
                try {
                    flashcardService.saveFlashcardAccess(fAccess);
                } catch (SQLException ex) {
                    Logger.getLogger(FlashcardServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                List<FlashcardSet> listFlashcardSet = flashcardService.findFlashcardSet(Long.valueOf(flashcardId));
                request.setAttribute("listFlashcardSet", listFlashcardSet);
                request.setAttribute("currentSite", "/flashcard/flashcard-details");
                request.getRequestDispatcher("/flashcard/flashcard-details.jsp").forward(request, response);
            }
            case "/flashcard/update-flashcard" -> {
                String flashcardId = request.getParameter("flId");
                Flashcard flashcard = flashcardService.findById(Long.valueOf(flashcardId));
                List<Subject> subjects = subjectService.findAll();
                List<FlashcardSet> flashcardSets = flashcardService.findFlashcardSet(Long.valueOf(flashcardId)); // Load the flashcards in the set
                request.setAttribute("flashcardSets", flashcardSets);
                request.setAttribute("title", flashcard.getName());
                request.setAttribute("description", flashcard.getDescription());
                request.setAttribute("subjects", subjects);
                request.setAttribute("status", flashcard.getStatus());
                request.setAttribute("subject", flashcard.getSubject().getId());
                request.setAttribute("flashcardId", flashcardId);
                request.setAttribute("currentSite", "/flashcard/add-flashcard");
                request.getRequestDispatcher("/flashcard/add-flashcard.jsp").forward(request, response);
            }
            default -> {
//                showAllLesson(request, response);
                break;
            }
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
        try {
            Flashcard flashcard = createFlashcardFromRequest(request);
            if (flashcard == null) {
                forwardToForm(request, response);
                return;
            }

            Long flashcardId = flashcardService.save(flashcard, request);
            if (flashcardId == -1) {
                forwardToForm(request, response);
                return;
            }

            if (!saveFlashcardSets(request, flashcard)) {
                forwardToForm(request, response);
                return;
            }

            handleDeletedFlashcardSets(request);

            response.sendRedirect("/flashcard/all-flashcard?msg=successful");
        } catch (ServletException | IOException ex) {
            Logger.getLogger(FlashcardServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private Flashcard createFlashcardFromRequest(HttpServletRequest request) {
        String title = request.getParameter("title");
        String subject = request.getParameter("subject");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String flashcardId = request.getParameter("flashcardId");

        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");
        Long createdById = currentUser.getId();

        if (title == null || subject == null || description == null || status == null) {
            return null;
        }

        EFlashcardStatus flashcardStatus = EFlashcardStatus.valueOf(status);
        Subject subjectEntity = subjectService.findById(Long.valueOf(subject));
        LocalDate now = LocalDate.now();

        if (flashcardId == null) {
            return new Flashcard(null, title, description, flashcardStatus, now, now, subjectEntity, createdById, createdById);
        } else {
            return new Flashcard(Long.valueOf(flashcardId), title, description, flashcardStatus, now, now, subjectEntity, createdById, createdById);
        }
    }

    private boolean saveFlashcardSets(HttpServletRequest request, Flashcard flashcard) {
        String[] names = request.getParameterValues("name");
        String[] answers = request.getParameterValues("answer");
        String[] flashcardSetIds = request.getParameterValues("flashcardSet");

        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");
        Long createdById = currentUser.getId();
        LocalDate now = LocalDate.now();

        if (names == null || answers == null || names.length == 0 || answers.length == 0) {
            return false;
        }

        for (int i = 0; i < names.length; i++) {
            String name = names[i];
            String answer = answers[i];
            String flashcardSetId = flashcardSetIds != null && flashcardSetIds.length > i ? flashcardSetIds[i] : null;

            FlashcardSet flashcardSet;
            if (flashcardSetId == null) {
                flashcardSet = new FlashcardSet(null, name, answer, now, now, flashcard, createdById, createdById);
            } else {
                flashcardSet = new FlashcardSet(Long.valueOf(flashcardSetId), name, answer, now, now, flashcard, createdById, createdById);
            }

            long isSaved = flashcardService.saveFlashcardSet(flashcardSet, request);
            if (isSaved == -1) {
                return false;
            }
        }
        return true;
    }

    private void handleDeletedFlashcardSets(HttpServletRequest request) {
        String deletedFlashcardSets = request.getParameter("deletedFlashcardSets");
        if (deletedFlashcardSets != null && !deletedFlashcardSets.isEmpty()) {
            String[] ids = deletedFlashcardSets.split(",");
            for (String id : ids) {
                if (!id.isEmpty()) {
                    flashcardService.deleteFlashcardSet(Long.valueOf(id));
                }
            }
        }
    }

    private void forwardToForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String urlPath = request.getServletPath();
        if ("/flashcard/add-flashcard".equals(urlPath)) {
            request.getRequestDispatcher("/flashcard/add-flashcard.jsp").forward(request, response);
        } else if ("/flashcard/update-flashcard".equals(urlPath)) {
            request.getRequestDispatcher("/flashcard/update-flashcard.jsp").forward(request, response);
        }
    }
}
