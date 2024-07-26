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
import java.sql.Date;
import constant.ExamQueryConstant;
import dto.ExamDetailsDto;
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
    public List<Exam> findByClassId(Long classId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ExamQueryConstant.FIND_BY_CLASS_ID)) {
            ps.setLong(1, classId);

            try (ResultSet rs = ps.executeQuery()) {
                List<Exam> exams = new ArrayList();
                while (rs.next()) {
                    exams.add(examMapper(rs));
                }

                return exams;
            }
        } catch (SQLException | NullPointerException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
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
            ps.setDate(6, Date.valueOf(examDetails.getTakenAt()));

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
        try (Connection c = DatabaseConnection.getConnection();
                PreparedStatement ps = c.prepareStatement(ExamQueryConstant.GET_EXAM_STATISTICS_OF_A_STUDENT)) {
            ps.setLong(1, studentId);
            
            try (ResultSet rs = ps.executeQuery()) {
                List<ExamDetailsDto> examDetailsDtos = new ArrayList();
                
                while (rs.next()) {
                    examDetailsDtos.add(new ExamDetailsDto(rs.getLong("exam_id"), 
                            rs.getLong("question_id"), 
                            rs.getLong("user_id"),
                            rs.getLong("submitted_answer"),
                            rs.getLong("correct_answer")));
                }
                
                return examDetailsDtos;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ExamRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return Collections.emptyList();
    }

}
