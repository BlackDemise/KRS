package repository.impl;

import entity.Subject;
import constant.SubjectQuery;
import dto.SubjectDto;
import java.util.List;
import mysql.DatabaseConnection;
import repository.SubjectRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;
import static mapper.SubjectMapper.subjectMapper;
import service.impl.CategoryServiceImpl;

public class SubjectRepositoryImpl implements SubjectRepository {

    private static final SubjectRepositoryImpl instance = new SubjectRepositoryImpl();

    public static SubjectRepositoryImpl getInstance() {
        return instance;
    }

    private final CategoryServiceImpl categoryService = CategoryServiceImpl.getInstance();

    @Override
    public List<Subject> findAll() {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(SubjectQuery.FIND_ALL); ResultSet rs = ps.executeQuery()) {

            List<Subject> subjects = new ArrayList<>();

            while (rs.next()) {
                subjects.add(subjectMapper(rs));
            }
            return subjects;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();  // Return an empty list instead of null
    }

    @Override
    public List<Subject> findByCode(String code) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(SubjectQuery.FIND_BY_CODE)) {
            ps.setString(1, "%" + code + "%");
            ResultSet rs = ps.executeQuery();
            List<Subject> subjects = new ArrayList<>();

            while (rs.next()) {
                subjects.add(subjectMapper(rs));
            }
            return subjects;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    @Override
    public Subject findById(Long id) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(SubjectQuery.FIND_BY_ID)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return subjectMapper(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    @Override
    public Subject save(Subject s) {
        boolean isAddAction = s.getId() == null;
        int check = 0;
        Connection con = null;

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(isAddAction ? SubjectQuery.ADD : SubjectQuery.UPDATE, java.sql.Statement.RETURN_GENERATED_KEYS)) {
            con = c;
            c.setAutoCommit(false);

            ps.setString(1, s.getName());
            ps.setString(2, s.getCode());
            ps.setString(3, s.getDescription());
            ps.setString(4, s.getNote());
            ps.setString(5, s.getStatus().toString());
            ps.setLong(6, s.getCategory().getId());
            ps.setDate(7, s.getCreatedAt() == null ? java.sql.Date.valueOf(LocalDate.now()) : java.sql.Date.valueOf(s.getCreatedAt()));
            ps.setDate(8, s.getLastModifiedAt() == null ? java.sql.Date.valueOf(LocalDate.now()) : java.sql.Date.valueOf(s.getLastModifiedAt()));
            ps.setLong(9, s.getCreatedBy());
            ps.setLong(10, s.getLastModifiedBy());

            if (!isAddAction) {
                ps.setLong(11, s.getId());
            }

            check = ps.executeUpdate();
            c.commit();

            if (isAddAction) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    s.setId(rs.getLong(1));
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

        return check > 0 ? s : null;
    }

    @Override
    public boolean deleteById(Long id) {
        int check = 0;
        Connection con = null;
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(SubjectQuery.DELETE)) {
            con = c;
            c.setAutoCommit(false);
            ps.setLong(1, id);
            check = ps.executeUpdate();
            c.commit();
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
        return check > 0;
    }

    @Override
    public List<Subject> findAll(int itemsPerPage, int currentPage) {
        int offset = (currentPage - 1) * itemsPerPage;

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(SubjectQuery.FIND_ALL + " LIMIT ? OFFSET ?")) {

            ps.setInt(1, itemsPerPage);
            ps.setInt(2, offset);

            ResultSet rs = ps.executeQuery();
            List<Subject> subjects = new ArrayList<>();

            while (rs.next()) {
                subjects.add(subjectMapper(rs));
            }
            return subjects;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    public List<Subject> findAll(int itemsPerPage, int currentPage, String sortField, String sortOrder) {
        int offset = (currentPage - 1) * itemsPerPage;
        String query = SubjectQuery.FIND_ALL + " ORDER BY " + sortField + " " + sortOrder + " LIMIT ? OFFSET ?";

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(query)) {

            ps.setInt(1, itemsPerPage);
            ps.setInt(2, offset);

            ResultSet rs = ps.executeQuery();
            List<Subject> subjects = new ArrayList<>();

            while (rs.next()) {
                subjects.add(subjectMapper(rs));
            }
            return subjects;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    public List<Subject> findByName(String name, int itemsPerPage, int currentPage, String sortField, String sortOrder) {
        int offset = (currentPage - 1) * itemsPerPage;
        String query = SubjectQuery.FIND_BY_NAME + " ORDER BY " + sortField + " " + sortOrder + " LIMIT ? OFFSET ?";

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(query)) {
            ps.setString(1, "%" + name + "%");
            ps.setInt(2, itemsPerPage);
            ps.setInt(3, offset);

            ResultSet rs = ps.executeQuery();
            List<Subject> subjects = new ArrayList<>();

            while (rs.next()) {
                subjects.add(subjectMapper(rs));
            }
            return subjects;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    public int countByName(String name) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(SubjectQuery.COUNT_BY_NAME)) {
            ps.setString(1, "%" + name + "%");

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return 0;
    }

    public int countAll() {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(SubjectQuery.COUNT_ALL)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return 0;
    }

    public Subject findByNameExact(String name) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(SubjectQuery.FIND_BY_NAME_EXACT)) {
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return subjectMapper(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    public void saveSubjectManager(String managerEmail, Long subjectId) {
        Connection con = null;

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(SubjectQuery.ADD_SUBJECT_MANAGER)) {
            con = c;
            c.setAutoCommit(false);
            ps.setString(1, managerEmail);
            ps.setLong(2, subjectId);

            ps.executeUpdate();
            c.commit();
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

    public void deleteSubjectManagers(Long subjectId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(SubjectQuery.DELETE_SUBJECT_MANAGERS)) {
            ps.setLong(1, subjectId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
    }

    public void removeSubjectManagers(String managerEmail, Long subjectId) {
        Connection con = null;
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(SubjectQuery.DELETE_SUBJECT_MANAGERS)) {
            con = c;
            c.setAutoCommit(false);
            ps.setString(1, managerEmail);
            ps.setLong(2, subjectId);
            ps.executeUpdate();
            c.commit();
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

    public List<SubjectDto> getSubjectStatisticsByStudent(Long studentId, String searchQuery) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(SubjectQuery.GET_SUBJECT_STATISTICS)) {
            ps.setString(1, searchQuery);
            ps.setLong(2, studentId);
            ps.setLong(3, 1L);

            try (ResultSet rs = ps.executeQuery()) {
                List<SubjectDto> subjectDtos = new ArrayList();

                while (rs.next()) {
                    subjectDtos.add(SubjectDto.builder()
                            .subjectId(rs.getLong("subject_id"))
                            .subjectName(rs.getString("subject_name"))
                            .subjectCode(rs.getString("subject_code"))
                            .subjectCategory(categoryService.findById(rs.getLong("subject_category")))
                            .totalStudents(rs.getLong("students_in_subject"))
                            .build());
                }

                return subjectDtos;
            }

        } catch (SQLException ex) {
            Logger.getLogger(SubjectRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }

        return Collections.emptyList();
    }
}
