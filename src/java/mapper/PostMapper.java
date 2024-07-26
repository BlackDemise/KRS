/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package mapper;

import entity.Post;
import java.sql.ResultSet;
import java.sql.SQLException;
import repository.impl.UserRepositoryImpl;

/**
 *
 * @author Admin
 */
public class PostMapper {
    public static Post postMapper(ResultSet rs) throws SQLException {
        UserRepositoryImpl user = UserRepositoryImpl.getInstance();
        
        return new Post(rs.getLong("post_id"),
                rs.getString("title"),
                rs.getString("content"),
                user.findById(rs.getLong("user_id")),
                rs.getDate("post_at").toLocalDate()        
        );
    }
    
}
