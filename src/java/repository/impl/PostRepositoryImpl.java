/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository.impl;

import constant.IPostQuery;
import entity.Post;
import entity.User;
import java.util.List;
import mysql.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import static mapper.PostMapper.postMapper;
import repository.PostRepository;


/**
 *
 * @author Admin
 */
public class PostRepositoryImpl implements PostRepository{
    private static final PostRepositoryImpl instance = new PostRepositoryImpl();

    public PostRepositoryImpl() {
    }

    public static PostRepositoryImpl getInstance() {
        return instance;
    }
    @Override
    public List<Post> findAll() {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(IPostQuery.FIND_ALL); ResultSet rs = ps.executeQuery();) {

            List<Post> posts = new ArrayList();
            while (rs.next()) {
                posts.add(postMapper(rs));
            }
            return posts;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }
   
    @Override
    public Post findById(Long post_id) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(IPostQuery.FIND_BY_ID)) {
            ps.setLong(1, post_id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return postMapper(rs);
                }
            } catch (SQLException e) {
                e.printStackTrace(System.err);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    @Override
    public List<Post> findByUserID(Long user_id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    @Override
    public boolean add(Post p) {
        int rows = 0;
        Connection con = null;
        try (Connection c = DatabaseConnection.getConnection();
                PreparedStatement ps = c.prepareStatement(IPostQuery.ADD)) {
            con = c;
            c.setAutoCommit(false);
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getContent());
            ps.setLong(3, p.getUser_id().getId());
            rows = ps.executeUpdate();
            if (rows > 0) {
                c.commit();
            }
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace(System.err);
                }
            }
            e.printStackTrace(System.err);
        }
        return rows > 0;
    }
    @Override
    public boolean deleteById(Long id) {
        int check = 0;
        Connection con = null;
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(IPostQuery.DELETE_BY_ID)) {
            con = c;
            c.setAutoCommit(false);
            ps.setLong(1, id);
            check = ps.executeUpdate();
            c.commit();
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace(System.err);
                }
            }
            e.printStackTrace(System.err);
        }
        return check>0;
    }
    
    @Override
    public Post save(Post s) {
        int check = 0;
        Connection con = null;

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(IPostQuery.UPDATE)) {
            con = c;
            c.setAutoCommit(false);

            ps.setString(1, s.getTitle());
            ps.setString(2, s.getContent());

            
            ps.setLong(3, s.getPost_id());
            check = ps.executeUpdate();
            c.commit();
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace(System.err);
                }
            }
            e.printStackTrace(System.err);
        }
        return check > 0 ? s : null;
    }
   
}
