package repository.impl;

import constant.IAnswerQuery;
import entity.Answer;
import java.util.List;
import mysql.DatabaseConnection;
import repository.AnswerRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import static mapper.AnswerMapper.answerMapper;

public class AnswerRepositoryImpl implements AnswerRepository {

    private static final AnswerRepositoryImpl instance = new AnswerRepositoryImpl();

    private AnswerRepositoryImpl() {
    }

    public static AnswerRepositoryImpl getInstance() {
        return instance;
    }

    @Override
    public List<Answer> findAll() {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(IAnswerQuery.FIND_ALL); ResultSet rs = ps.executeQuery()) {
            List<Answer> answers = new ArrayList();

            while (rs.next()) {
                answers.add(answerMapper(rs));
            }

            return answers;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    @Override
    public Answer findById(Long answerId) {
        try (Connection c = DatabaseConnection.getConnection();
                PreparedStatement ps = c.prepareStatement(IAnswerQuery.FIND_BY_ID)) {
            ps.setLong(1, answerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return answerMapper(rs);
                }
            }
        } catch (SQLException | NullPointerException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    @Override
    public List<Answer> findByQuestionInExam(Long examId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(IAnswerQuery.FIND_BY_QUESTION_IN_EXAM)) {
            ps.setLong(1, examId);

            try (ResultSet rs = ps.executeQuery()) {
                List<Answer> answers = new ArrayList();
                while (rs.next()) {
                    answers.add(answerMapper(rs));
                }

                return answers;
            }
        } catch (SQLException | NullPointerException e) {
            e.printStackTrace(System.err);
        }

        return Collections.emptyList();
    }

    public Map<Long, Long> getCorrectAnswersByExamId(Long examId) {
        Map<Long, Long> correctAnswers = new HashMap();

        String sql = "SELECT q.question_id AS question_id, a.answer_id AS answer_id "
                + "FROM question q "
                + "JOIN answer a ON q.question_id = a.question_id "
                + "JOIN exam_question eq ON eq.question_id = q.question_id "
                + "WHERE eq.exam_id = ? AND a.is_correct = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, examId);
            stmt.setBoolean(2, true);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Long questionId = rs.getLong("question_id");
                    Long answerId = rs.getLong("answer_id");
                    correctAnswers.put(questionId, answerId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }

        return correctAnswers;
    }
}
