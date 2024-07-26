/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package repository;

import entity.Comment;
import java.util.List;

/**
 *
 * @author Admin
 */
public interface CommentRepository {
    List<Comment> findAll(Long post_id);
    Comment findById(Long post_id);
    List<Comment> findByUserID(Long user_id);
    List<Comment> findByPostID(Long post_id);
    boolean add(Comment c);
    boolean deleteById(Long id);
    Comment save(Comment c);
}
