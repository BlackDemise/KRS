package repository.impl;

import constant.IQuestionQuery;
import entity.Lesson;
import entity.Question;
import java.util.List;
import repository.QuestionRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import static mapper.QuestionMapper.questionMapper;
import mysql.DatabaseConnection;

public class QuestionRepositoryImpl implements QuestionRepository {

    private static final QuestionRepositoryImpl instance = new QuestionRepositoryImpl();

    private QuestionRepositoryImpl() {
    }

    public static QuestionRepositoryImpl getInstance() {
        return instance;
    }

    @Override
    public List<Question> findAll() {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(IQuestionQuery.FIND_ALL); ResultSet rs = ps.executeQuery()) {
            List<Question> questions = new ArrayList();
            while (rs.next()) {
                questions.add(questionMapper(rs));
            }

            return questions;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }

        return Collections.emptyList();
    }

    @Override
    public List<Question> findByLesson(Long lessonId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(IQuestionQuery.FIND_BY_LESSON)) {
            ps.setLong(1, lessonId);

            try (ResultSet rs = ps.executeQuery()) {
                List<Question> questions = new ArrayList();
                while (rs.next()) {
                    questions.add(questionMapper(rs));
                }

                return questions;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }

        return Collections.emptyList();
    }

    @Override
    public Question findById(Long questionId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(IQuestionQuery.FIND_BY_ID)) {
            ps.setLong(1, questionId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return questionMapper(rs);
                }

            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }

        return null;
    }

    @Override
    public Question saveBatch(List<Question> questions) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Boolean deleteById(Long questionId) {
        int check = 0;
        Connection con = null;
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(IQuestionQuery.DELETE_BY_ID)) {
            con = c;
            c.setAutoCommit(false);
            ps.setLong(1, questionId);
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
    public List<Question> findByExam(Long examId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(IQuestionQuery.FIND_BY_EXAM)) {
            ps.setLong(1, examId);

            try (ResultSet rs = ps.executeQuery()) {
                List<Question> questions = new ArrayList();

                while (rs.next()) {
                    questions.add(questionMapper(rs));
                }

                return questions;
            }
        } catch (SQLException | NullPointerException e) {
            e.printStackTrace(System.err);
        }
        
        return Collections.emptyList();
    }
}
