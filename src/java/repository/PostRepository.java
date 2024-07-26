/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package repository;

import entity.Post;
import java.util.List;

/**
 *
 * @author Admin
 */
public interface PostRepository {
    List<Post> findAll();
    Post findById(Long post_id);
    List<Post> findByUserID(Long user_id);
    boolean add(Post p);
    boolean deleteById(Long id);
    Post save(Post s);
}

