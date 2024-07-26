package mapper;

import entity.Exam;
import java.sql.ResultSet;
import java.sql.SQLException;
import repository.impl.ClassRepositoryImpl;

public class ExamMapper {

    public static Exam examMapper(ResultSet rs) throws SQLException {
        ClassRepositoryImpl cri = ClassRepositoryImpl.getInstance();
        return new Exam(rs.getLong("exam_id"),
                rs.getString("title"),
                rs.getLong("duration"),
                cri.findById(rs.getLong("class_id")),
                null);
    }
}
