package service.impl;

import dto.ExamDetailsDto;
import java.util.List;
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

    @Override
    public List<ExamDetailsDto> getExamStatisticsOfAStudent(Long studentId) {
        return examRepository.getExamStatisticsOfAStudent(studentId);
    }
    
}
