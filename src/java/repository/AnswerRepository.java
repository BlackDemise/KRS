package repository;

import entity.Answer;
import java.util.List;

public interface AnswerRepository {
    List<Answer> findAll();
    Answer findById(Long answerId);
    List<Answer> findByQuestionInExam(Long questionId);
}
