package repository.impl;

import constant.EUserStatus;
import dto.StudentDto;
import entity.Classroom;
import entity.User;
import mysql.DatabaseConnection;
import repository.ClassRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import static mapper.ClassMapper.classMapper;
import constant.ClassQueryConstant;
import dto.ClassDto;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ClassRepositoryImpl implements ClassRepository {

    private static final ClassRepositoryImpl instance = new ClassRepositoryImpl();
    private static final UserRepositoryImpl userRepository = UserRepositoryImpl.getInstance();
    private static final SubjectRepositoryImpl subjectRepository = SubjectRepositoryImpl.getInstance();

    private ClassRepositoryImpl() {
    }

    public static ClassRepositoryImpl getInstance() {
        return instance;
    }

    @Override
    public List<Classroom> findAll() {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ClassQueryConstant.FIND_ALL); ResultSet rs = ps.executeQuery()) {
            List<Classroom> classes = new ArrayList<>();
            while (rs.next()) {
                classes.add(classMapper(rs));
            }
            return classes;
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    @Override
    public List<Classroom> findBySubject(Long subjectId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ClassQueryConstant.FIND_BY_SUBJECT)) {
            ps.setLong(1, subjectId);
            try (ResultSet rs = ps.executeQuery()) {
                List<Classroom> classes = new ArrayList<>();
                while (rs.next()) {
                    classes.add(classMapper(rs));
                }
                return classes;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    @Override
    public Classroom findById(Long classId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ClassQueryConstant.FIND_BY_ID)) {
            ps.setLong(1, classId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return classMapper(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    @Override
    public List<StudentDto> findAllStudents(Long classId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ClassQueryConstant.FIND_ALL_STUDENTS)) {
            ps.setLong(1, classId);
            try (ResultSet rs = ps.executeQuery()) {
                List<StudentDto> studentsInClass = new ArrayList<>();
                while (rs.next()) {
                    StudentDto student = new StudentDto(rs.getLong("student_id"),
                            rs.getString("student_full_name"),
                            rs.getString("student_email"),
                            EUserStatus.valueOf(rs.getString("student_status").toUpperCase()));
                    student.setSelected(true); // Set selected to true for students already in the class
                    studentsInClass.add(student);
                }
                return studentsInClass;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    @Override
    public boolean add(Long studentId, Long classId) {
        int rows = 0;
        Connection con = null;
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ClassQueryConstant.ADD_NEW_STUDENT_TO_CLASS)) {
            con = c;
            c.setAutoCommit(false);
            ps.setLong(1, studentId);
            ps.setLong(2, classId);
            rows = ps.executeUpdate();
            if (rows > 0) {
                c.commit();
            }
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace(System.err);
                }
            }
            e.printStackTrace(System.err);
        }
        return rows > 0;
    }

    @Override
    public boolean leave(Long studentId, Long classId) {
        int rows = 0;
        Connection con = null;
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ClassQueryConstant.LEAVE_CLASS)) {
            c.setAutoCommit(false);
            con = c;
            ps.setLong(1, studentId);
            ps.setLong(2, classId);
            rows = ps.executeUpdate();
            if (rows > 0) {
                c.commit();
            }
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace(System.err);
                }
            }
            e.printStackTrace(System.err);
        }
        return rows > 0;
    }

    public List<Classroom> findAll(int itemsPerPage, int currentPage, String sortField, String sortOrder) {
        int offset = (currentPage - 1) * itemsPerPage;
        String query = "SELECT class.*, user.full_name AS teacher_name, subject.code AS subject_code FROM class "
                + "JOIN user ON class.teacher_id = user.id "
                + "JOIN subject ON class.subject_id = subject.id ";

        if (sortField != null && !sortField.isEmpty() && sortOrder != null && !sortOrder.isEmpty()) {
            query += " ORDER BY " + sortField + " " + sortOrder;
        }

        query += " LIMIT ? OFFSET ?";

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(query)) {
            ps.setInt(1, itemsPerPage);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            List<Classroom> classes = new ArrayList<>();
            while (rs.next()) {
                Classroom classroom = classMapper(rs);
                classroom.getTeacher().setFullName(rs.getString("teacher_name"));
                classroom.getSubject().setCode(rs.getString("subject_code"));
                classes.add(classroom);
            }
            return classes;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    public int getTotalClasses() {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ClassQueryConstant.TOTAL_CLASSES)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return 0;
    }

    public void save(Classroom classroom) {
        boolean isAddAction = classroom.getId() == null;
        Connection con = null;

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(isAddAction
                ? "INSERT INTO class (name, subject_id, teacher_id, status) VALUES (?, ?, ?, ?)"
                : "UPDATE class SET name = ?, subject_id = ?, teacher_id = ?, status = ? WHERE class_id = ?",
                Statement.RETURN_GENERATED_KEYS)) {

            con = c;
            c.setAutoCommit(false);

            ps.setString(1, classroom.getTitle());
            ps.setLong(2, classroom.getSubject().getId());
            ps.setLong(3, classroom.getTeacher().getId());
            ps.setString(4, classroom.getStatus());

            if (!isAddAction) {
                ps.setLong(5, classroom.getId());
            }

            ps.executeUpdate();
            c.commit();

            if (isAddAction) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    classroom.setId(rs.getLong(1));
                }
            }
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace(System.err);
                }
            }
            e.printStackTrace(System.err);
        }
    }

//    public void addStudentToClass(User student, Classroom classroom) {
//        String sql = "INSERT INTO student_class (user_id, class_id) VALUES (?, ?)";
//        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
//            ps.setLong(1, student.getId());
//            ps.setLong(2, classroom.getId());
//            ps.executeUpdate();
//        } catch (SQLException e) {
//            e.printStackTrace(System.err);
//        }
//    }
    public void clearStudents(Long classId) {
        String sql = "DELETE FROM student_class WHERE class_id = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, classId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
    }

    public void updateStatus(Classroom classroom) {
        String sql = "UPDATE class SET status = ? WHERE class_id = ?";
        try (Connection connection = DatabaseConnection.getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, classroom.getStatus());
            ps.setLong(2, classroom.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Classroom> findByFilters(String className, int itemsPerPage, int currentPage, String sortField, String sortOrder) {
        int offset = (currentPage - 1) * itemsPerPage;
        String query = "SELECT class.*, user.full_name AS teacher_name, subject.code AS subject_code FROM class "
                + "JOIN user ON class.teacher_id = user.id "
                + "JOIN subject ON class.subject_id = subject.id "
                + "WHERE class.name LIKE ? ";

        // Add sorting clause if sortField and sortOrder are provided
        if (sortField != null && !sortField.isEmpty() && sortOrder != null && !sortOrder.isEmpty()) {
            query += " ORDER BY " + sortField + " " + sortOrder;
        }

        query += " LIMIT ? OFFSET ?";

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(query)) {
            ps.setString(1, "%" + className + "%");
            ps.setInt(2, itemsPerPage);
            ps.setInt(3, offset);
            ResultSet rs = ps.executeQuery();
            List<Classroom> classes = new ArrayList<>();
            while (rs.next()) {
                Classroom classroom = classMapper(rs);
                classroom.getTeacher().setFullName(rs.getString("teacher_name"));
                classroom.getSubject().setCode(rs.getString("subject_code"));
                classes.add(classroom);
            }
            return classes;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    public int getTotalClassesByFilters(String className) {
        String query = "SELECT COUNT(*) AS total FROM class "
                + "JOIN user ON class.teacher_id = user.id "
                + "JOIN subject ON class.subject_id = subject.id "
                + "WHERE class.name LIKE ?";

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(query)) {
            ps.setString(1, "%" + className + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return 0;
    }

    public List<Classroom> findAllClasses() {
        List<Classroom> classes = new ArrayList<>();
        String sql = "SELECT * FROM class"; // Adjust table name as necessary

        try (Connection connection = DatabaseConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(sql); ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Classroom classroom = new Classroom();
                classroom.setId(resultSet.getLong("id"));
                classroom.setTitle(resultSet.getString("title"));
                classroom.setTeacher(userRepository.findById(resultSet.getLong("teacher_id")));
                classroom.setSubject(subjectRepository.findById(resultSet.getLong("subject_id")));

                classes.add(classroom);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return classes;
    }

    public boolean classExists(String className, Long code) {
        String sql = "SELECT COUNT(*) FROM class WHERE name = ? AND subject_id = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, className);
            ps.setLong(2, code);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public int getTotalClasses(Long studentId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ClassQueryConstant.TOTAL_CLASSES_OF_A_STUDENT)) {
            ps.setLong(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total_classes");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Classroom> findByStudent(Long studentId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ClassQueryConstant.FIND_BY_STUDENT)) {
            ps.setLong(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                List<Classroom> classrooms = new ArrayList();

                while (rs.next()) {
                    classrooms.add(classMapper(rs));
                }

                return classrooms;
            }

        } catch (SQLException ex) {
            Logger.getLogger(ClassRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }

        return Collections.emptyList();
    }

    public void addStudentToClass(User student, Classroom classroom) {

        String sql = "INSERT INTO student_class (user_id, class_id) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, student.getId());
            ps.setLong(2, classroom.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
    }

    public void save(User user) {
        String sql = "INSERT INTO user (full_name, email, phone_number, dob, password, note, avatar, created_at, last_modified_at, created_by_id, last_modified_by_id, user_status, role_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhoneNumber());
            ps.setDate(4, Date.valueOf(user.getDob()));
            ps.setString(5, user.getPassword());
            ps.setString(6, user.getNote());
            ps.setString(7, user.getAvatar());
            ps.setDate(8, Date.valueOf(user.getCreatedAt()));
            ps.setDate(9, Date.valueOf(user.getLastModifiedAt()));
            ps.setLong(10, user.getCreatedById());
            ps.setLong(11, user.getLastModifiedById());
            ps.setString(12, user.getUserStatus().name());
            ps.setLong(13, user.getRole().getId());

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                user.setId(rs.getLong(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<ClassDto> getClassStatisticsByStudentAndSubject(Long studentId, Long subjectId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ClassQueryConstant.GET_CLASS_STATISTICS)) {
            ps.setString(1, "Active");
            ps.setLong(2, subjectId);
            ps.setLong(3, studentId);
            ps.setLong(4, 1L);

            try (ResultSet rs = ps.executeQuery()) {
                List<ClassDto> classDtos = new ArrayList();

                while (rs.next()) {
                    classDtos.add(ClassDto.builder()
                            .subjectId(rs.getLong("subject_id"))
                            .subjectName(rs.getString("subject_name"))
                            .subjectCode(rs.getString("subject_code"))
                            .subjectCategory(rs.getString("subject_category"))
                            .classId(rs.getLong("class_id"))
                            .className(rs.getString("class_name"))
                            .teacherId(rs.getLong("teacher_id"))
                            .teacherFullName(rs.getString("teacher_full_name"))
                            .build());
                }

                return classDtos;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ClassRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }

        return Collections.emptyList();
    }
}
