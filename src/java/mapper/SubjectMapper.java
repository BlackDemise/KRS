package mapper;

import constant.ESubjectStatus;
import entity.Category;
import entity.Subject;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SubjectMapper {

    public static Subject subjectMapper(ResultSet rs) throws SQLException {
        Category category = new Category(
                rs.getLong("category_id"),
                rs.getString("category_name"),
                rs.getString("category_description"),
                rs.getString("category_note"),
                rs.getString("category_status"),
                rs.getDate("category_created_at").toLocalDate(),
                rs.getDate("category_last_modified_at").toLocalDate(),
                rs.getLong("category_created_by"),
                rs.getLong("category_last_modified_by")
        );
        return new Subject(
                rs.getLong("id"),
                rs.getString("name"),
                rs.getString("code"),
                rs.getString("description"),
                rs.getString("note"),
                ESubjectStatus.valueOf(rs.getString("status").toUpperCase()),
                category,
                rs.getDate("subject_created_at").toLocalDate(),
                rs.getDate("subject_last_modified_at").toLocalDate(),
                rs.getLong("subject_created_by"),
                rs.getLong("subject_last_modified_by")
        );
    }
}
