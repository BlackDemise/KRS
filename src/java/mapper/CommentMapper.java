/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package mapper;

import entity.Comment;
import repository.impl.PostRepositoryImpl;
import repository.impl.UserRepositoryImpl;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public class CommentMapper {
    public static Comment commentMapper(ResultSet rs) throws SQLException {
        UserRepositoryImpl user = UserRepositoryImpl.getInstance();
        PostRepositoryImpl post = new PostRepositoryImpl();
        return new Comment(rs.getLong("comment_id"),
                rs.getString("content"),
                user.findById(rs.getLong("user_id")),
                post.findById(rs.getLong("post_id")),
                rs.getDate("create_at").toLocalDate()        
        );
    }
    
}
