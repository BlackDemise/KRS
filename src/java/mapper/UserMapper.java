package mapper;

import constant.EUserStatus;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import entity.User;
import repository.impl.RoleRepositoryImpl;

public class UserMapper {

    public static User userMapper(ResultSet rs) throws SQLException {
        RoleRepositoryImpl rri = RoleRepositoryImpl.getInstance();
        
        Timestamp createdAtTimestamp = rs.getTimestamp("created_at");
        LocalDateTime createdAt = createdAtTimestamp != null ? createdAtTimestamp.toLocalDateTime() : null;
        
        Timestamp lastModifiedAtTimestamp = rs.getTimestamp("last_modified_at");
        LocalDateTime lastModifiedAt = lastModifiedAtTimestamp != null ? lastModifiedAtTimestamp.toLocalDateTime() : null;
        
        return new User(rs.getLong("id"),
                rs.getString("full_name"),
                rs.getString("email"),
                rs.getString("phone_number"),
                rs.getDate("dob").toLocalDate(),
                rs.getString("password"),
                rs.getString("note"),
                rs.getString("avatar"),
                createdAt,
                lastModifiedAt,
                rs.getLong("created_by"),
                rs.getLong("last_modified_by"),
                EUserStatus.valueOf(rs.getString("status").toUpperCase()),
                rri.findById(rs.getLong("role_id")));
    }
}
