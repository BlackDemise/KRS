/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository.impl;

import constant.ICommentQuery;
import entity.Comment;
import java.util.List;
import repository.CommentRepository;

import mysql.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import static mapper.CommentMapper.commentMapper;

/**
 *
 * @author Admin
 */
public class CommentRepositoryImpl implements CommentRepository {

    @Override
    public List<Comment> findAll(Long post_id) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ICommentQuery.FIND_ALL);) {
            ps.setLong(1, post_id);
            try (ResultSet rs = ps.executeQuery()) {

                List<Comment> coms = new ArrayList();
                while (rs.next()) {
                    coms.add(commentMapper(rs));
                }
                return coms;
            } catch (SQLException e) {
                e.printStackTrace(System.err);
            }

        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    @Override
    public Comment findById(Long cmt_id) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ICommentQuery.FIND_BY_ID)) {
            ps.setLong(1, cmt_id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return commentMapper(rs);
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
    public List<Comment> findByUserID(Long user_id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Comment> findByPostID(Long post_id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean add(Comment cmt) {
        int rows = 0;
        Connection con = null;
        try (Connection c = DatabaseConnection.getConnection();
                PreparedStatement ps = c.prepareStatement(ICommentQuery.ADD)) {
            con = c;
            c.setAutoCommit(false);
            ps.setString(1, cmt.getContent());
            ps.setLong(2, cmt.getUser_id().getId());
            ps.setLong(3, cmt.getPost_id().getPost_id());
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
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ICommentQuery.DELETE_BY_ID)) {
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
    public Comment save(Comment cmt) {
        int check = 0;
        Connection con = null;

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ICommentQuery.UPDATE)) {
            con = c;
            c.setAutoCommit(false);

            ps.setString(1, cmt.getContent());
            
            ps.setLong(2, cmt.getComment_id());
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
        return check > 0 ? cmt : null;
    }

}
