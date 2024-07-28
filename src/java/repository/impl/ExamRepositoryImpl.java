package repository.impl;

import constant.ExamDetailsQueryConstant;
import entity.Exam;
import entity.ExamDetails;
import repository.ExamRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import mapper.ExamMapper;
import static mapper.ExamMapper.examMapper;
import mysql.DatabaseConnection;
import constant.ExamQueryConstant;
import dto.ExamDetailsDto;
import dto.QuestionDto;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ExamRepositoryImpl implements ExamRepository {

    private static final ExamRepositoryImpl instance = new ExamRepositoryImpl();

    private ExamRepositoryImpl() {
    }

    public static ExamRepositoryImpl getInstance() {
        return instance;
    }

    @Override
    public Exam findById(Long examId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ExamQueryConstant.FIND_BY_ID)) {

            ps.setLong(1, examId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return ExamMapper.examMapper(rs);
                }
            }
        } catch (SQLException | NullPointerException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    @Override
    public Map<Exam, Integer> findByClassId(Long classId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ExamQueryConstant.FIND_BY_CLASS_ID)) {
            ps.setLong(1, classId);

            try (ResultSet rs = ps.executeQuery()) {
                Map<Exam, Integer> exams = new HashMap();
                while (rs.next()) {
                    exams.put(examMapper(rs), rs.getInt("total_questions"));
                }

                return exams;
            }
        } catch (SQLException | NullPointerException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyMap();
    }

    public boolean saveExamDetails(ExamDetails examDetails) throws SQLException {
        Connection con = null;
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ExamDetailsQueryConstant.SAVE)) {
            con = c;
            c.setAutoCommit(false);

            ps.setLong(1, examDetails.getStudent().getId());
            ps.setLong(2, examDetails.getExam().getId());
            ps.setLong(3, examDetails.getQuestion().getId());
            ps.setLong(4, examDetails.getSubmittedAnswer().getAnswerId());
            ps.setLong(5, examDetails.getSubmittedAnswer().getAnswerId());
            ps.setObject(6, examDetails.getTakenAt());

            int rowAffected = ps.executeUpdate();
            c.commit();
            return rowAffected > 0;
        } catch (SQLException | NullPointerException e) {
            if (con != null) {
                con.rollback();
            }
            e.printStackTrace(System.err);
        }
        return false;
    }

    @Override
    public int getTotalExamsByStudent(Long studentId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ExamQueryConstant.GET_TOTAL_EXAM_BY_STUDENT)) {
            ps.setLong(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total_exams");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ExamRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    @Override
    public int getTotalPracticesByStudent(Long studentId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ExamQueryConstant.GET_TOTAL_PRACTICES_BY_STUDENT)) {
            ps.setLong(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total_practices");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ExamRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    @Override
    public List<ExamDetailsDto> getExamStatisticsOfAStudent(Long studentId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ExamQueryConstant.GET_EXAM_STATISTICS_OF_A_STUDENT)) {
            ps.setLong(1, studentId);
            ps.setLong(2, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                List<ExamDetailsDto> examDetailsDtos = new ArrayList();

                while (rs.next()) {
                    examDetailsDtos.add(new ExamDetailsDto(
                            rs.getLong("exam_id"),
                            rs.getString("exam_title"),
                            rs.getString("class_name"),
                            rs.getLong("question_id"),
                            rs.getLong("user_id"),
                            rs.getLong("submitted_answer"),
                            rs.getLong("correct_answer"),
                            null
                    ));
                }

                return examDetailsDtos;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ExamRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }

        return Collections.emptyList();
    }

    public Map<Long, List<QuestionDto>> findQuestionsInAnExam(Long examId) {
        Map<Long, List<QuestionDto>> questionsMap = new HashMap<>();

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ExamQueryConstant.GET_ALL_QUESTIONS_IN_AN_EXAM)) {
            ps.setLong(1, examId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Long questionId = rs.getLong("question_id");
                    QuestionDto questionDto = QuestionDto.builder()
                            .questionId(questionId)
                            .questionContent(rs.getString("content"))
                            .answer(rs.getString("answer"))
                            .answerId(rs.getLong("answer_id"))
                            .isCorrect(rs.getBoolean("is_correct"))
                            .build();

                    questionsMap.computeIfAbsent(questionId, k -> new ArrayList<>()).add(questionDto);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ExamRepository.class.getName()).log(Level.SEVERE, null, ex);
        }

        return questionsMap;
    }
}
