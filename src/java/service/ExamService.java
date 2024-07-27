package service;

import dto.ExamStatistics;
import java.util.Map;

public interface ExamService {

    int getTotalExamsByStudent(Long studentId);
    int getTotalPracticesByStudent(Long studentId);
    Map<Long, ExamStatistics> getExamStatisticsOfAStudent(Long studentId);
}
