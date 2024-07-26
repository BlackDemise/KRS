package repository.impl;

import constant.ILessonQuery;
import entity.Lesson;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import static mapper.LessonMapper.lessonMapper;
import mysql.DatabaseConnection;
import repository.LessonRepository;

public class LessonRepositoryImpl implements LessonRepository {

    private static final LessonRepositoryImpl instance = new LessonRepositoryImpl();

    private LessonRepositoryImpl() {
    }

    public static LessonRepositoryImpl getInstance() {
        return instance;
    }

    @Override
    public List<Lesson> findAll() {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ILessonQuery.FIND_ALL); ResultSet rs = ps.executeQuery();) {

            List<Lesson> lessons = new ArrayList();
            while (rs.next()) {
                lessons.add(lessonMapper(rs));
            }
            return lessons;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    @Override
    public Lesson findById(Long lessonId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ILessonQuery.FIND_BY_ID)) {
            ps.setLong(1, lessonId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return lessonMapper(rs);
                }
            } catch (SQLException e) {
                e.printStackTrace(System.err);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    @Override
    public List<Lesson> findBySubject(Long subjectId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ILessonQuery.FIND_BY_SUBJECT)) {
            ps.setLong(1, subjectId);

            try (ResultSet rs = ps.executeQuery()) {
                List<Lesson> lessons = new ArrayList();
                while (rs.next()) {
                    lessons.add(lessonMapper(rs));
                }
                
                return lessons;
            } catch (SQLException e) {
                e.printStackTrace(System.err);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();

    }
    @Override
    public Lesson save(Lesson l) {
        boolean isAddAction = l.getLessonId() == null;
        int check = 0;
        Connection con = null;

        try (Connection c = DatabaseConnection.getConnection(); 
                PreparedStatement ps = c.prepareStatement(isAddAction ? ILessonQuery.ADD : ILessonQuery.UPDATE_BY_ID)) {
            con = c;
            c.setAutoCommit(false);

            ps.setString(1, l.getName());
            ps.setString(2, l.getStatus());
            ps.setLong(3, l.getSubject().getId());

            if (!isAddAction) {
                ps.setLong(4, l.getLessonId());
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
            }
            e.printStackTrace(System.err);
        }

        return check > 0 ? l : null;
    }
    @Override
    public boolean deleteById(Long id) {
        int check = 0;
        Connection con = null;
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ILessonQuery.DELETE)) {
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
        return check>0;
    }

    @Override
    public List<Lesson> findBySubjectAndStatus(Long subject_id, String status) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ILessonQuery.FIND_BY_SUBJECT_AND_STATUS)) {
            ps.setLong(1, subject_id);
            ps.setString(2, status);

            try (ResultSet rs = ps.executeQuery()) {
                List<Lesson> lessons = new ArrayList();
                while (rs.next()) {
                    lessons.add(lessonMapper(rs));
                }
                
                return lessons;
            } catch (SQLException e) {
                e.printStackTrace(System.err);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    @Override
    public List<Lesson> findByStatus(String status) {try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ILessonQuery.FIND_BY_STATUS)) {
            ps.setString(1, status);

            try (ResultSet rs = ps.executeQuery()) {
                List<Lesson> lessons = new ArrayList();
                while (rs.next()) {
                    lessons.add(lessonMapper(rs));
                }
                
                return lessons;
            } catch (SQLException e) {
                e.printStackTrace(System.err);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();}

    }
