package mapper;

import entity.Question;
import java.sql.ResultSet;
import java.sql.SQLException;
import repository.impl.LessonRepositoryImpl;

public class QuestionMapper {

    public static Question questionMapper(ResultSet rs) throws SQLException {
        LessonRepositoryImpl lri = LessonRepositoryImpl.getInstance();
        return new Question(rs.getLong("question_id"),
                rs.getString("content"),
                null,
                null,
                null,
                null,
                lri.findById(rs.getLong("lesson_id"))
        );
    }
}
