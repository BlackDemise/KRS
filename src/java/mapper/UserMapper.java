package mapper;

import constant.EUserStatus;
import java.sql.ResultSet;

import entity.User;
import java.sql.SQLException;
import repository.impl.RoleRepositoryImpl;

public class UserMapper {

    public static User userMapper(ResultSet rs) throws SQLException {
        RoleRepositoryImpl rri = RoleRepositoryImpl.getInstance();
        return new User(rs.getLong("id"),
                rs.getString("full_name"),
                rs.getString("email"),
                rs.getString("phone_number"),
                rs.getDate("dob").toLocalDate(),
                rs.getString("password"),
                rs.getString("note"),
                rs.getString("avatar"),
                rs.getDate("created_at").toLocalDate(),
                rs.getDate("last_modified_at").toLocalDate(),
                rs.getLong("created_by"),
                rs.getLong("last_modified_by"),
                EUserStatus.valueOf(rs.getString("status").toUpperCase()),
                rri.findById(rs.getLong("role_id")));
    }
}
