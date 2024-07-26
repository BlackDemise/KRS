package mapper;

import java.sql.ResultSet;

import entity.Answer;
import java.sql.SQLException;
import repository.impl.QuestionRepositoryImpl;

public class AnswerMapper {

    public static Answer answerMapper(ResultSet rs) throws SQLException {
        QuestionRepositoryImpl qri = QuestionRepositoryImpl.getInstance();
        return new Answer(rs.getLong("answer_id"),
                rs.getString("answer"),
                null,
                null,
                rs.getInt("is_correct") != 0,
                qri.findById(rs.getLong("question_id"))
        );
    }
}
