package mapper;

import constant.EUserRole;
import java.sql.ResultSet;

import entity.Role;
import java.sql.SQLException;

public class RoleMapper {
    public static Role roleMapper(ResultSet rs) throws SQLException {
        return new Role(rs.getLong("id"),
                        EUserRole.valueOf(rs.getString("title")),
                        rs.getString("description"));
    }
}
