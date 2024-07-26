package repository.impl;

import constant.EUserStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import entity.User;
import java.sql.SQLException;
import mysql.DatabaseConnection;
import repository.UserRepository;
import dto.StudentDto;
import java.util.logging.Level;
import java.util.logging.Logger;

import static mapper.UserMapper.userMapper;
import org.mindrot.jbcrypt.BCrypt;
import constant.UserQueryConstant;
import java.util.Collection;

public class UserRepositoryImpl implements UserRepository {

    private static final UserRepositoryImpl instance = new UserRepositoryImpl();

    public UserRepositoryImpl() {
    }

    public static UserRepositoryImpl getInstance() {
        return instance;
    }

    public List<User> findAll() {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(UserQueryConstant.FIND_ALL); ResultSet rs = ps.executeQuery()) {
            List<User> users = new ArrayList<>();
            while (rs.next()) {
                users.add(userMapper(rs));
            }
            return users;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    @Override
    public List<User> findAll(int itemsPerPage, int page) {
        int offset = (page - 1) * itemsPerPage;
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(UserQueryConstant.FIND_ALL_WITH_PAGING)) {
            ps.setInt(1, itemsPerPage);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();
            List<User> users = new ArrayList<>();
            while (rs.next()) {
                users.add(userMapper(rs));
            }
            return users;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    @Override
    public User findById(Long id) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(UserQueryConstant.FIND_BY_ID)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return userMapper(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    @Override
    public User findByEmail(String email, String password) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(UserQueryConstant.FIND_BY_EMAIL)) {
            ps.setString(1, email);
            ps.setString(2, EUserStatus.ACTIVE.getUserStatus());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                if (BCrypt.checkpw(password, hashedPassword)) {
                    return userMapper(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    @Override
    public User findByEmail2(String email) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(UserQueryConstant.FIND_BY_EMAIL)) {
            ps.setString(1, email);
            ps.setString(2, EUserStatus.ACTIVE.getUserStatus());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return userMapper(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    @Override
    public User save(User u) {
        Long createdById = u.getCreatedById();
        Long lastModifiedById = u.getLastModifiedById();
        boolean isAddAction = u.getId() == null;
        int check = 0;
        Connection con = null;
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(isAddAction ? UserQueryConstant.ADD : UserQueryConstant.UPDATE)) {
            con = c;
            c.setAutoCommit(false);
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getAvatar());
            ps.setString(3, u.getNote());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getPhoneNumber());
            ps.setDate(6, Date.valueOf(u.getDob()));
            ps.setString(7, u.getPassword());
            ps.setString(8, u.getUserStatus().getUserStatus());
            ps.setLong(9, u.getRole().getId());
            ps.setDate(10, Date.valueOf(u.getCreatedAt()));
            ps.setDate(11, Date.valueOf(u.getLastModifiedAt()));
            ps.setLong(12, createdById == null ? -1 : createdById);
            ps.setLong(13, lastModifiedById == null ? -1 : lastModifiedById);
            if (!isAddAction) {
                ps.setLong(14, u.getId());
            }

            check = ps.executeUpdate();
            c.commit();
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace(System.err);
                }
                e.printStackTrace(System.err);
            }

        }
        return check > 0 ? u : null;
    }

    @Override
    public boolean toggleById(Long id) {
        int check = 0;
        Connection con = null;
        EUserStatus status = findById(id).getUserStatus();
        String toggle = status.getUserStatus().toLowerCase();

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(UserQueryConstant.TOGGLE)) {
            con = c;
            c.setAutoCommit(false);
            ps.setString(1, "active".equals(toggle) ? EUserStatus.INACTIVE.getUserStatus() : EUserStatus.ACTIVE.getUserStatus());
            ps.setLong(2, id);
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

    public List<StudentDto> findAllStudents() {
        String sql = "SELECT u.id AS studentId, u.full_name AS studentFullName, u.email AS studentEmail, u.status AS studentStatus FROM user u WHERE u.role_id = ?";
        List<StudentDto> students = new ArrayList<>();
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, 5L); // Replace with actual role ID for students
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                students.add(new StudentDto(
                        rs.getLong("studentId"),
                        rs.getString("studentFullName"),
                        rs.getString("studentEmail"),
                        EUserStatus.valueOf(rs.getString("studentStatus").toUpperCase())
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return students;
    }

    public List<User> findAllTeachers() {
        String sql = "SELECT * FROM user WHERE role_id = ?"; // Assuming role_id for teachers is 4
        List<User> teachers = new ArrayList<>();
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, 4); // Assuming role_id for teachers is 4
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                teachers.add(userMapper(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return teachers;
    }

    public boolean changePassword(String email, String newPassword) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(UserQueryConstant.RESET_PASSWORD)) {
            c.setAutoCommit(false);
            ps.setString(1, newPassword);
            ps.setString(2, email);

            int rowAffected = ps.executeUpdate();
            c.commit();
            return rowAffected > 0;

        } catch (SQLException ex) {
            try (Connection c = DatabaseConnection.getConnection()) {
                if (c != null) {
                    c.rollback();

                }
            } catch (SQLException ex1) {
                Logger.getLogger(UserRepositoryImpl.class
                        .getName()).log(Level.SEVERE, "Password cannot be changed!", ex1);

            }
            Logger.getLogger(UserRepositoryImpl.class
                    .getName()).log(Level.SEVERE, "Password cannot be changed!", ex);
        }
        return false;
    }

    public User findByEmail(String email) {
        String sql = "SELECT * FROM user WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return userMapper(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> findByRole(Long roleId) {
        List<User> listUser = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(UserQueryConstant.FIND_BY_ROLE)) {
            ps.setLong(1, 3);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listUser.add(userMapper(rs));
            }
            return listUser;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Collections.emptyList();
    }

    public List<User> findManagerById(Long subjectId) {
        List<User> listManager = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(UserQueryConstant.FIND_MANAGER_BY_ID)) {
            ps.setLong(1, subjectId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listManager.add(userMapper(rs));
            }
            return listManager;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Collections.emptyList();
    }

    public List<User> findStudentById(Long studentId) {
        List<User> lisStudents = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(UserQueryConstant.FIND_STUDENT_BY_ID)) {
            ps.setLong(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                lisStudents.add(userMapper(rs));
            }
            return lisStudents;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Collections.emptyList();
    }
}
