package service.impl;

import dto.ExamDetailsDto;
import dto.ExamStatistics;
import dto.QuestionDto;
import entity.Exam;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import repository.impl.ExamRepositoryImpl;
import service.ExamService;

public class ExamServiceImpl implements ExamService {

    private static final ExamServiceImpl instance = new ExamServiceImpl();

    private ExamServiceImpl() {
    }

    public static ExamServiceImpl getInstance() {
        return instance;
    }

    private final ExamRepositoryImpl examRepository = ExamRepositoryImpl.getInstance();

    @Override
    public int getTotalExamsByStudent(Long studentId) {
        return examRepository.getTotalExamsByStudent(studentId);
    }

    @Override
    public int getTotalPracticesByStudent(Long studentId) {
        return examRepository.getTotalPracticesByStudent(studentId);
    }

    public Map<Long, ExamStatistics> getExamStatisticsOfAStudent(Long studentId) {
        List<ExamDetailsDto> examDetails = examRepository.getExamStatisticsOfAStudent(studentId);
        Map<Long, ExamStatistics> examStatisticsMap = new HashMap();
        for (ExamDetailsDto edd : examDetails) {
            Long examId = edd.getExamId();
            String examTitle = edd.getExamTitle();
            String className = edd.getClassName();
            Long submittedAnswer = edd.getSubmittedAnswerId();
            Long correctAnswer = edd.getCorrectAnswerId();
            LocalDateTime takenAt = edd.getTakenAt();

            if (!examStatisticsMap.containsKey(examId)) {
                examStatisticsMap.put(examId, new ExamStatistics(examId, examTitle, className, 0, 0, takenAt));
            }

            ExamStatistics examStatistics = examStatisticsMap.get(examId);
            examStatistics.incrementMaxScore();

            if (submittedAnswer != null && correctAnswer != null && submittedAnswer.equals(correctAnswer)) {
                examStatistics.incrementActualScore();
            }
        }
        return examStatisticsMap;
    }

    public Map<Exam, Integer> findByClassId(Long classId) {
        return examRepository.findByClassId(classId);
    }
    
    public Map<Long, List<QuestionDto>> findQuestionsInAnExam(Long examId) {
        return examRepository.findQuestionsInAnExam(examId);
    }
    
    public Exam findById(Long examId) {
        return examRepository.findById(examId);
    }
}
