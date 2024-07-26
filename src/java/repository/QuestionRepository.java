package repository;

import entity.Lesson;
import entity.Question;
import java.util.List;

public interface QuestionRepository {
    List<Question> findAll();
    List<Question> findByLesson(Long lessonId);
    List<Question> findByExam(Long examId);
    Question findById(Long questionId);
    Question saveBatch(List<Question> questions);
    Boolean deleteById(Long lessonId);
}
