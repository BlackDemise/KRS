package repository;

import entity.Lesson;
import java.util.List;

public interface LessonRepository {
    List<Lesson> findAll();
    Lesson findById(Long lessonId);
    List<Lesson> findByStatus(String status);
    List<Lesson> findBySubject(Long subjectId);
    public Lesson save(Lesson l);
    public boolean deleteById(Long id);
    public List<Lesson> findBySubjectAndStatus(Long subject_id, String status);
}
