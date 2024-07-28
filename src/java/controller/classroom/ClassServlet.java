package controller.classroom;

import controller.subject.SubjectServlet;
import dto.ClassroomDto;
import entity.Classroom;
import entity.Exam;
import entity.Subject;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import repository.impl.ClassRepositoryImpl;
import repository.impl.SubjectRepositoryImpl;
import repository.impl.UserRepositoryImpl;
import util.ClassValidation;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.poi.ss.usermodel.Cell;
import service.impl.ExamServiceImpl;

@WebServlet(name = "ClassServlet", urlPatterns = {"/class", "/class/add", "/class/toggle", "/class/update",
    "/class/uploadExcel", "/class/exam", "/class/exam/edit"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class ClassServlet extends HttpServlet {

    private final SubjectRepositoryImpl subjectRepository = SubjectRepositoryImpl.getInstance();
    private final UserRepositoryImpl userRepository = UserRepositoryImpl.getInstance();
    private final ClassRepositoryImpl classRepository = ClassRepositoryImpl.getInstance();
    private final ExamServiceImpl examService = ExamServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String ACTION = request.getServletPath();
        switch (ACTION) {
            case "/class" ->
                handleAllClasses(request, response);
            case "/class/add" ->
                handleAddGet(request, response);
            case "/class/update" ->
                handleUpdateGet(request, response);
            case "/class/toggle" ->
                handleTogglePost(request, response);
            case "/class/exam" -> {
                String classId = request.getParameter("classId");
                if (classId != null) {
                    Long cId = Long.valueOf(classId);
                    Map<Exam, Integer> exams = examService.findByClassId(cId);
                    
                    request.setAttribute("currentSite", "/class");
                    request.setAttribute("exams", exams);
                    request.getRequestDispatcher("/class/all-exams.jsp").forward(request, response);
                }
            }
            case "/class/exam/edit" -> {
                String classId = request.getParameter("classId");
                if (classId != null) {
                    Long cId = Long.valueOf(classId);
                   
                    
                    request.setAttribute("currentSite", "/class");
 
                    request.getRequestDispatcher("/class/exam-details.jsp").forward(request, response);
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String ACTION = request.getServletPath();
        switch (ACTION) {
            case "/class/add" ->
                handleAddPost(request, response);
            case "/class/update" ->
                handleUpdatePost(request, response);
            case "/class/uploadExcel" ->
                uploadExcel(request, response);
        }
    }

    private void handleAllClasses(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int currentPage = 1;
        int itemsPerPage = 4; // Default items per page
        String sortField = request.getParameter("sortField");
        String sortOrder = request.getParameter("sortOrder");

        if (request.getParameter("currentPage") != null) {
            currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }

        if (request.getParameter("itemsPerPage") != null) {
            itemsPerPage = Integer.parseInt(request.getParameter("itemsPerPage"));
        }

        String searchQuery = request.getParameter("searchQuery");

        List<Classroom> classes;
        int totalClasses;

        if (searchQuery != null && !searchQuery.isEmpty()) {
            classes = classRepository.findByFilters(searchQuery, itemsPerPage, currentPage, sortField, sortOrder);
            totalClasses = classRepository.getTotalClassesByFilters(searchQuery);
        } else {
            classes = classRepository.findAll(itemsPerPage, currentPage, sortField, sortOrder);
            totalClasses = classRepository.getTotalClasses();
        }

        int totalPages = (int) Math.ceil((double) totalClasses / itemsPerPage);

        List<ClassroomDto> listStudents = new ArrayList<>();
        for (Classroom u : classes) {
            listStudents.add(new ClassroomDto(u, userRepository.findStudentById(u.getId())));
        }

        request.setAttribute("classes", listStudents);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("itemsPerPage", itemsPerPage);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("sortField", sortField);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("currentSite", "/class");
        request.getRequestDispatcher("/class/all.jsp").forward(request, response);
    }

    private void handleAddGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Subject> subjects = subjectRepository.findAll();
        List<User> teachers = userRepository.findAllTeachers();

        request.setAttribute("subjects", subjects);
        request.setAttribute("teachers", teachers);
        request.setAttribute("currentSite", "/class/add");
        request.getRequestDispatcher("/class/add.jsp").forward(request, response);
    }

    private void handleAddPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String className = request.getParameter("className");
        String codeStr = request.getParameter("code");
        String teacherIdStr = request.getParameter("teacher");
        String status = request.getParameter("status");

        request.setAttribute("className", className);
        request.setAttribute("codeStr", codeStr);
        request.setAttribute("teacherIdStr", teacherIdStr);
        request.setAttribute("status", status);

        boolean hasError = false;

        if (!ClassValidation.isValidClassName(className)) {
            request.setAttribute("classNameError", "Class Name can only contain letters, numbers, '-', '_' and '.'.");
            hasError = true;
        }

        if (codeStr == null || codeStr.isEmpty()) {
            request.setAttribute("codeError", "Code is required.");
            hasError = true;
        }

        if (teacherIdStr == null || teacherIdStr.isEmpty()) {
            request.setAttribute("teacherError", "Teacher is required.");
            hasError = true;
        }

        if (status == null || status.isEmpty()) {
            request.setAttribute("statusError", "Status is required.");
            hasError = true;
        }

        if (!hasError) {
            Long code = Long.parseLong(codeStr);
            Long teacherId = Long.parseLong(teacherIdStr);

            if (classRepository.classExists(className, code)) {
                request.setAttribute("duplicateError", "Class with the same name and code already exists.");
                hasError = true;
            } else {
                Classroom classroom = new Classroom();
                classroom.setTitle(className);
                classroom.setSubject(subjectRepository.findById(code));
                classroom.setTeacher(userRepository.findById(teacherId));
                classroom.setStatus(status);

                classRepository.save(classroom);

                response.sendRedirect(request.getContextPath() + "/class?added=successful");
                return;
            }
        }

        // Forward back to form with errors and previously entered data
        handleAddGet(request, response);
    }

    private void handleUpdateGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long classId = Long.parseLong(request.getParameter("classId"));
            Classroom classroom = classRepository.findById(classId);
            List<Subject> subjects = subjectRepository.findAll();
            List<User> teachers = userRepository.findAllTeachers();

            request.setAttribute("classroom", classroom);
            request.setAttribute("subjects", subjects);
            request.setAttribute("teachers", teachers);
            request.setAttribute("currentSite", "/class");
            request.getRequestDispatcher("/class/update.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error/error.jsp");
        }
    }

    private void handleUpdatePost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long classId = Long.parseLong(request.getParameter("classId"));
            String className = request.getParameter("className");
            Long subjectId = Long.parseLong(request.getParameter("subject"));
            Long teacherId = Long.parseLong(request.getParameter("teacher"));
            String status = request.getParameter("status");

            if (!ClassValidation.isValidClassName(className)) {
                request.setAttribute("classNameError", "Class Name can only contain letters, numbers, '-', '_' and '.'.");
                handleUpdateGet(request, response);
                return;
            }

            Classroom classroom = classRepository.findById(classId);
            classroom.setTitle(className);
            classroom.setSubject(subjectRepository.findById(subjectId));
            classroom.setTeacher(userRepository.findById(teacherId));
            classroom.setStatus(status);

            classRepository.save(classroom);

            response.sendRedirect(request.getContextPath() + "/class?updated=successful");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error/error.jsp");
        }
    }

    private void handleTogglePost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long classId = Long.parseLong(request.getParameter("classId"));
            String currentStatus = request.getParameter("currentStatus");

            Classroom classroom = classRepository.findById(classId);
            if ("ACTIVE".equalsIgnoreCase(currentStatus)) {
                classroom.setStatus("Inactive");
            } else {
                classroom.setStatus("Active");
            }

            classRepository.updateStatus(classroom);

            response.sendRedirect(request.getContextPath() + "/class?statusChanged=successful");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/class?statusChanged=failed");
        }
    }

    private void uploadExcel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = null;
        try {
            filePart = request.getPart("studentsFile");
        } catch (IOException | ServletException ex) {
            Logger.getLogger(SubjectServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (filePart != null) {
            if (filePart.getSize() > 0) {
                try (InputStream inputStream = filePart.getInputStream()) {
                    Workbook workbook = new XSSFWorkbook(inputStream);
                    Sheet sheet = workbook.getSheetAt(0); // Assuming you want to read the first sheet

                    Set<String> excelStudentEmails = new HashSet<>();

                    for (Row row : sheet) {
                        Cell idCell = row.getCell(0); // Assuming the manager ID is in the first column
                        if (idCell != null) {
                            String studentEmail = idCell.getStringCellValue().trim();
                            excelStudentEmails.add(studentEmail);
                        }
                    }

                    String classId = request.getParameter("classId");
                    List<User> dbStudents = userRepository.findStudentById(Long.valueOf(classId));

                    // Determine which manager IDs to add and which to remove
                    Set<String> dbStudentEmailsSet = new HashSet<>();
                    for (User u : dbStudents) {
                        dbStudentEmailsSet.add(u.getEmail());
                    }
                    Set<String> emailsToAdd = new HashSet<>(excelStudentEmails);
                    emailsToAdd.removeAll(dbStudentEmailsSet);
                    Set<String> emailsToRemove = new HashSet<>(dbStudentEmailsSet);
                    emailsToRemove.removeAll(excelStudentEmails);

                    // Add new manager IDs
                    for (String mngEmail : emailsToAdd) {
                        classRepository.addStudentToClass(mngEmail, Long.valueOf(classId));
                    }

                    // Remove missing manager IDs
                    for (String mngEmail : emailsToRemove) {
                        classRepository.deleteStudents(mngEmail, Long.valueOf(classId));
                    }

                    response.sendRedirect("/class?msg=successful");
                } catch (Exception e) {
                    e.printStackTrace(System.out);
                    response.sendRedirect("/class?msg=failed");
                }
            } else {
                response.sendRedirect("/class?msg=empty-file");
            }
        } else {
            response.sendRedirect("/class?msg=empty-file");
        }
    }

    private String getCellAsString(Cell cell) {
        return switch (cell.getCellType()) {
            case Cell.CELL_TYPE_STRING ->
                cell.getStringCellValue();
            case Cell.CELL_TYPE_NUMERIC ->
                String.format("%.0f", cell.getNumericCellValue());
            case Cell.CELL_TYPE_BOOLEAN ->
                Boolean.toString(cell.getBooleanCellValue());
            case Cell.CELL_TYPE_FORMULA ->
                cell.getCellFormula();
            case Cell.CELL_TYPE_BLANK ->
                "";
            default ->
                cell.toString();
        };// For numeric values, convert to String and ensure leading zeros are preserved
    }

    private LocalDate getCellAsDate(Cell cell) {
        if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
            // Assuming the date is in yyyy-MM-dd format
            return LocalDate.parse(cell.getStringCellValue(), DateTimeFormatter.ISO_LOCAL_DATE);
        } else if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
            // Convert Excel numeric date to LocalDate
            return cell.getDateCellValue().toInstant().atZone(java.time.ZoneId.systemDefault()).toLocalDate();
        } else {
            throw new IllegalArgumentException("Invalid date format");
        }
    }
}
