package service.impl;

import entity.Lesson;
import java.util.List;
import repository.impl.LessonRepositoryImpl;
import service.LessonService;

public class LessonServiceImpl implements LessonService {

    private static final LessonServiceImpl instance = new LessonServiceImpl();

    private LessonServiceImpl() {

    }

    public static LessonServiceImpl getInstance() {
        return instance;
    }

    private final LessonRepositoryImpl lessonRepository = LessonRepositoryImpl.getInstance();

    public List<Lesson> findBySubject(Long subjectId) {
        return lessonRepository.findBySubject(subjectId);
    }
    
    public Lesson findById(Long lessonId) {
        return lessonRepository.findById(lessonId);
    }

}
