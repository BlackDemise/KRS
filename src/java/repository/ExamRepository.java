package repository;

import dto.ExamDetailsDto;
import entity.Exam;
import java.util.List;
import java.util.Map;

public interface ExamRepository {
    Exam findById(Long examId);
    Map<Exam, Integer> findByClassId(Long classId);
    int getTotalExamsByStudent(Long studentId);
    int getTotalPracticesByStudent(Long studentId);
    List<ExamDetailsDto> getExamStatisticsOfAStudent(Long studentId);
}
