package mapper;

import entity.Lesson;
import java.sql.ResultSet;
import java.sql.SQLException;
import repository.impl.SubjectRepositoryImpl;

public class LessonMapper {
    public static Lesson lessonMapper(ResultSet rs) throws SQLException {
        SubjectRepositoryImpl sri = SubjectRepositoryImpl.getInstance();
        return new Lesson(rs.getLong("lesson_id"),
                              rs.getString("name"),
                            rs.getString("status"),
                                sri.findById(rs.getLong("subject_id")));
    }
}









