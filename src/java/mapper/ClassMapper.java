package mapper;

import entity.Classroom;
import java.sql.ResultSet;
import java.sql.SQLException;
import repository.impl.SubjectRepositoryImpl;
import repository.impl.UserRepositoryImpl;

public class ClassMapper {
    public static Classroom classMapper(ResultSet rs) throws SQLException {
        UserRepositoryImpl uri = UserRepositoryImpl.getInstance();
        SubjectRepositoryImpl sri = SubjectRepositoryImpl.getInstance();
        
        return new Classroom(
            rs.getLong("class_id"),
            rs.getString("name"),
            uri.findById(rs.getLong("teacher_id")),
            sri.findById(rs.getLong("subject_id")),
            rs.getString("status")
        );
    }
}
