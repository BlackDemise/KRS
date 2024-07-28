package mapper;

import entity.Exam;
import java.sql.ResultSet;
import java.sql.SQLException;
import repository.impl.ClassRepositoryImpl;
import service.impl.UserServiceImpl;

public class ExamMapper {
    private static final UserServiceImpl userService = UserServiceImpl.getInstance();
    
    public static Exam examMapper(ResultSet rs) throws SQLException {
        ClassRepositoryImpl cri = ClassRepositoryImpl.getInstance();
        return new Exam(rs.getLong("exam_id"),
                rs.getString("title"),
                rs.getLong("duration"),
                cri.findById(rs.getLong("class_id")),
                userService.findById(rs.getLong("created_by")));
    }
}
