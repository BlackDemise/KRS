package controller.subject;

import constant.ESubjectStatus;
import dto.ManagerDto;
import entity.Category;
import entity.Subject;
import entity.User;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import service.impl.SubjectServiceImpl;
import service.impl.CategoryServiceImpl;
import service.impl.UserServiceImpl;
import util.SubjectValidation;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet(name = "SubjectServlet", urlPatterns = {"/subject", "/subject/add", "/subject/update", "/subject/updateStatus",
    "/subject/uploadExcel"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class SubjectServlet extends HttpServlet {

    private final SubjectServiceImpl subjectService = SubjectServiceImpl.getInstance();
    private final CategoryServiceImpl categoryService = CategoryServiceImpl.getInstance();
    private final UserServiceImpl userService = UserServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String ACTION = request.getServletPath();
        switch (ACTION) {
            case "/subject" ->
                displaySubjects(request, response);
            case "/subject/add" ->
                prepareAddSubject(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String ACTION = request.getServletPath();
        switch (ACTION) {
            case "/subject/add" ->
                saveSubject(request, response);
            case "/subject/update" ->
                updateSubject(request, response);
            case "/subject/updateStatus" ->
                toggleSubjectStatus(request, response);
            case "/subject/uploadExcel" ->
                uploadExcel(request, response);
        }
    }

    private void displaySubjects(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("searchQuery");
        String sortField = request.getParameter("sortField");
        String sortOrder = request.getParameter("sortOrder");

        if (sortField == null) {
            sortField = "id"; // Default sort field
        }
        if (sortOrder == null) {
            sortOrder = "asc"; // Default sort order
        }

        int currentPage = 1;
        int itemsPerPage = 4;

        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }

        if (request.getParameter("itemsPerPage") != null) {
            itemsPerPage = Integer.parseInt(request.getParameter("itemsPerPage"));
        }

        List<Subject> subjects;
        int totalSubjects;
        if (searchQuery != null && !searchQuery.isEmpty()) {
            subjects = subjectService.findByName(searchQuery, itemsPerPage, currentPage, sortField, sortOrder);
            totalSubjects = subjectService.countByName(searchQuery);
        } else {
            subjects = subjectService.findAll(itemsPerPage, currentPage, sortField, sortOrder);
            totalSubjects = subjectService.countAll();
        }
        int totalPages = (int) Math.ceil((double) totalSubjects / itemsPerPage);

        List<ManagerDto> listManagers = new ArrayList<>();
        for (Subject s : subjects) {
            List<User> managersList = userService.findManagerById(s.getId());
            listManagers.add(new ManagerDto(s, managersList));
        }

        int start = (currentPage - 1) * itemsPerPage + 1;
        int end = Math.min(currentPage * itemsPerPage, totalSubjects);

        request.setAttribute("subjects", listManagers);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("itemsPerPage", itemsPerPage);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("sortField", sortField);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("start", start);
        request.setAttribute("end", end);
        request.getRequestDispatcher("/subject/all.jsp").forward(request, response);
    }

    private void prepareAddSubject(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryService.findAll();
        List<User> managers = userService.findByRole(3L);
        request.setAttribute("managers", managers);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/subject/add.jsp").forward(request, response);
    }

    private void saveSubject(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String code = request.getParameter("code");
        Long categoryId = Long.valueOf(request.getParameter("category"));
        String[] managerIds = request.getParameterValues("managerIds");
        String description = request.getParameter("description");
        String note = request.getParameter("note");
        String statusParam = request.getParameter("status");
        ESubjectStatus status = null;

        boolean hasErrors = false;

        request.setAttribute("nameValue", name);
        request.setAttribute("codeValue", code);
        request.setAttribute("descriptionValue", description);
        request.setAttribute("noteValue", note);
        request.setAttribute("categoryValue", categoryId);
        request.setAttribute("statusValue", statusParam);

        if (name == null || name.isEmpty()) {
            request.setAttribute("nameError", "Name is required.");
            hasErrors = true;
        } else if (!SubjectValidation.validateName(name)) {
            request.setAttribute("nameError", "Invalid name. Please enter a valid name.");
            hasErrors = true;
        } else if (SubjectValidation.isDuplicateSubjectName(name)) {
            request.setAttribute("nameError", "Subject name already exists.");
            hasErrors = true;
        }

        if (code == null || code.isEmpty()) {
            request.setAttribute("codeError", "Code is required.");
            hasErrors = true;
        } else if (!SubjectValidation.validateCode(code)) {
            request.setAttribute("codeError", "Invalid code. Please enter a valid code.");
            hasErrors = true;
        }

        if (statusParam == null || statusParam.isEmpty()) {
            request.setAttribute("statusError", "Status is required.");
            hasErrors = true;
        } else {
            status = ESubjectStatus.valueOf(statusParam.toUpperCase());
        }

        if (hasErrors) {
            List<Category> categories = categoryService.findAll();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/subject/add.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");
        Long createdById = currentUser.getId();

        Category category = categoryService.findById(categoryId);
        Subject subject = new Subject(null, name, code, description, note, status, category, LocalDate.now(), LocalDate.now(), createdById, createdById);
        Subject savedSubject = subjectService.save(subject);
//        Long subjectId = savedSubject.getId();
//        for (String managerId : managerIds) {
//            subjectService.saveSubjectManager(Long.valueOf(managerId), subjectId);
//        }
        if (savedSubject == null) {
            request.setAttribute("errorMessage", "Failed to add subject. Please try again.");
            request.getRequestDispatcher("/subject/add.jsp").include(request, response);
        } else {
            response.sendRedirect("/subject?added=successful");
        }
    }

    private void updateSubject(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long subjectId = Long.valueOf(request.getParameter("id"));
        String subjectName = request.getParameter("nameSubject");
        String subjectCode = request.getParameter("codeSubject");
        Long categoryId = Long.valueOf(request.getParameter("categorySubject"));
        String statusParam = request.getParameter("statusSubject");
        ESubjectStatus status = null;
        String[] managerIds = request.getParameterValues("managerIds");

        boolean hasErrors = false;

        request.setAttribute("nameValue", subjectName);
        request.setAttribute("codeValue", subjectCode);
        request.setAttribute("categoryValue", categoryId);
        request.setAttribute("statusValue", statusParam);

        if (subjectName == null || subjectName.isEmpty()) {
            request.setAttribute("nameError", "Name is required.");
            hasErrors = true;
        } else if (!SubjectValidation.validateName(subjectName)) {
            request.setAttribute("nameError", "Invalid name. Please enter a valid name.");
            hasErrors = true;
        }

        if (subjectCode == null || subjectCode.isEmpty()) {
            request.setAttribute("codeError", "Code is required.");
            hasErrors = true;
        } else if (!SubjectValidation.validateCode(subjectCode)) {
            request.setAttribute("codeError", "Invalid code. Please enter a valid code.");
            hasErrors = true;
        }

        if (statusParam == null || statusParam.isEmpty()) {
            request.setAttribute("statusError", "Status is required.");
            hasErrors = true;
        } else {
            status = ESubjectStatus.valueOf(statusParam.toUpperCase());
        }

        if (hasErrors) {
            List<Category> categories = categoryService.findAll();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/subject.jsp").include(request, response);
            return;
        }

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        Long createdById = currentUser.getId();

        Category category = categoryService.findById(categoryId);
        Subject subject = new Subject(subjectId, subjectName, subjectCode, "", "", status, category, LocalDate.now(), LocalDate.now(), createdById, createdById);
        Subject updatedSubject = subjectService.save(subject);

        if (updatedSubject != null) {
//            subjectService.removeSubjectManagers(subjectId); // Remove existing managers
//            for (String managerId : managerIds) {
//                subjectService.saveSubjectManager(Long.valueOf(managerId), subjectId); // Add updated managers
//            }
            response.sendRedirect("/subject?updated=successful");
        } else {
            response.sendRedirect("/subject?updated=failed");
        }
    }

    private void toggleSubjectStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long subjectId = Long.valueOf(request.getParameter("id"));
        Subject subject = subjectService.findById(subjectId);
        if (subject != null) {
            subject.setStatus(subject.getStatus() == ESubjectStatus.ACTIVE ? ESubjectStatus.INACTIVE : ESubjectStatus.ACTIVE);
            Subject updatedSubject = subjectService.save(subject);
            if (updatedSubject != null) {
                response.sendRedirect("/subject?statusUpdated=successful");
            } else {
                response.sendRedirect("/subject?statusUpdated=failed");
            }
        } else {
            response.sendRedirect("/subject?statusUpdated=failed");
        }
    }

    private void uploadExcel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = null;
        try {
            filePart = request.getPart("excelFile");
        } catch (IOException | ServletException ex) {
            Logger.getLogger(SubjectServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (filePart != null) {
            if (filePart.getSize() > 0) {
                try (InputStream inputStream = filePart.getInputStream()) {
                    Workbook workbook = new XSSFWorkbook(inputStream);
                    Sheet sheet = workbook.getSheetAt(0); // Assuming you want to read the first sheet

                    Set<String> excelManagerEmails = new HashSet<>();

                    for (Row row : sheet) {
                        Cell idCell = row.getCell(0); // Assuming the manager ID is in the first column
                        if (idCell != null) {
                            String managerEmail = idCell.getStringCellValue().trim();
                            excelManagerEmails.add(managerEmail);
                        }
                    }

                    String subjectId = request.getParameter("subjectId");
                    List<User> dbManagers = userService.findManagerById(Long.valueOf(subjectId));

                    // Determine which manager IDs to add and which to remove
                    Set<String> dbManagerEmailsSet = new HashSet<>();
                    for (User u : dbManagers) {
                        dbManagerEmailsSet.add(u.getEmail());
                    }
                    Set<String> emailsToAdd = new HashSet<>(excelManagerEmails);
                    emailsToAdd.removeAll(dbManagerEmailsSet);
                    Set<String> emailsToRemove = new HashSet<>(dbManagerEmailsSet);
                    emailsToRemove.removeAll(excelManagerEmails);

                    // Add new manager IDs
                    for (String mngEmail : emailsToAdd) {
                        subjectService.saveSubjectManager(mngEmail, Long.valueOf(subjectId));
                    }

                    // Remove missing manager IDs
                    for (String mngEmail : emailsToRemove) {
                        subjectService.removeSubjectManagers(mngEmail, Long.valueOf(subjectId));
                    }

                    response.sendRedirect("/subject?msg=successful");
                } catch (Exception e) {
                    e.printStackTrace(System.out);
                    response.sendRedirect("/subject?msg=failed");
                }
            } else {
                response.sendRedirect("/subject?msg=empty-file");
            }
        } else {
            response.sendRedirect("/subject?msg=empty-file");
        }
    }
}
