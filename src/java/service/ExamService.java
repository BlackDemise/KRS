package service;

import dto.ExamDetailsDto;
import java.util.List;

public interface ExamService {

    int getTotalExamsByStudent(Long studentId);
    int getTotalPracticesByStudent(Long studentId);
    List<ExamDetailsDto> getExamStatisticsOfAStudent(Long studentId);
}
