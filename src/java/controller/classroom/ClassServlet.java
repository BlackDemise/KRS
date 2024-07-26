package controller.classroom;

import constant.EUserStatus;
import dto.ClassroomDto;
import entity.Classroom;
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
import java.util.List;
import org.apache.poi.ss.usermodel.Cell;
import static org.apache.poi.ss.usermodel.CellType.STRING;

@WebServlet(name = "ClassServlet", urlPatterns = {"/class", "/class/add", "/class/toggle", "/class/update", "/class/uploadStudents"})
@MultipartConfig
public class ClassServlet extends HttpServlet {

    private final SubjectRepositoryImpl subjectRepository = SubjectRepositoryImpl.getInstance();
    private final UserRepositoryImpl userRepository = UserRepositoryImpl.getInstance();
    private final ClassRepositoryImpl classRepository = ClassRepositoryImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String ACTION = request.getServletPath();
        switch (ACTION) {
            case "/class":
                handleAllClasses(request, response);
                break;
            case "/class/add":
                handleAddGet(request, response);
                break;
            case "/class/update":
                handleUpdateGet(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String ACTION = request.getServletPath();
        switch (ACTION) {
            case "/class/add":
                handleAddPost(request, response);
                break;
            case "/class/update":
                handleUpdatePost(request, response);
                break;
            case "/class/toggle":
                handleTogglePost(request, response);
                break;
            case "/class/uploadStudents":
                handleUploadStudents(request, response);
                break;
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
                classroom.setStatus("INACTIVE");
            } else {
                classroom.setStatus("ACTIVE");
            }

            classRepository.updateStatus(classroom);

            response.sendRedirect(request.getContextPath() + "/class?statusChanged=successful");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/class?statusChanged=failed");
        }
    }

    private void handleUploadStudents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String classIdStr = request.getParameter("classId");
        if (classIdStr == null || classIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Class ID is required");
            return;
        }

        Long classId;
        try {
            classId = Long.parseLong(classIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Class ID");
            return;
        }

        Part filePart = request.getPart("studentsFile");
        if (filePart == null || filePart.getSize() == 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "File is required");
            return;
        }

        Classroom classroom = classRepository.findById(classId);
        if (classroom == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Class not found");
            return;
        }

        importStudentsFromExcel(filePart, classroom);
        response.sendRedirect(request.getContextPath() + "/class?uploaded=successful");
    }

    private void importStudentsFromExcel(Part filePart, Classroom classroom) {
        try (InputStream inputStream = filePart.getInputStream(); Workbook workbook = new XSSFWorkbook(inputStream)) {

            Sheet sheet = workbook.getSheetAt(0);
            List<User> students = new ArrayList<>();

            for (Row row : sheet) {
                if (row.getRowNum() == 0) { // Skip header row
                    continue;
                }

                String studentName = row.getCell(0).getStringCellValue();
                String studentEmail = row.getCell(1).getStringCellValue();
                String studentPhoneNumber = getCellAsString(row.getCell(2));
                LocalDate studentDob = getCellAsDate(row.getCell(3)); // Assuming date is in LocalDate format

                // Create User object with data from the Excel file
                User student = userRepository.findByEmail(studentEmail);
                students.add(student);
            }

            for (User student : students) {
                // Add student to class
//                userRepository.save(student);
                classRepository.addStudentToClass(student, classroom);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
