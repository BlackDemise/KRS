package repository.impl;

import constant.FlashcardQuery;
import constant.ISubjectQuery;
import entity.Flashcard;
import entity.FlashcardAccess;
import entity.FlashcardSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;
import mysql.DatabaseConnection;
import repository.FlashcardRepository;

public class FlashcardRepositoryImpl implements FlashcardRepository {

    private static final FlashcardRepositoryImpl instance = new FlashcardRepositoryImpl();

    private FlashcardRepositoryImpl() {
    }

    public static FlashcardRepositoryImpl getInstance() {
        return instance;
    }

    public long save(Flashcard fl) {
        boolean isAddAction = fl.getId() == null;
        int check = 0;
        Connection con = null;

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(isAddAction ? FlashcardQuery.ADD : ISubjectQuery.UPDATE, java.sql.Statement.RETURN_GENERATED_KEYS)) {
            con = c;
            c.setAutoCommit(false);

            ps.setString(1, fl.getName());
            ps.setString(2, fl.getDescription());
            ps.setString(3, fl.getStatus().getFlashcardStatus());
            ps.setDate(4, fl.getCreatedAt() == null ? java.sql.Date.valueOf(LocalDate.now()) : java.sql.Date.valueOf(fl.getCreatedAt()));
            ps.setDate(5, fl.getLastModifiedAt() == null ? java.sql.Date.valueOf(LocalDate.now()) : java.sql.Date.valueOf(fl.getLastModifiedAt()));
            ps.setLong(6, fl.getSubject().getId());
            ps.setLong(7, fl.getCreatedBy());
            ps.setLong(8, fl.getLastModifiedBy());

            if (!isAddAction) {
                ps.setLong(9, fl.getId());
            }

            check = ps.executeUpdate();
            c.commit();

            if (isAddAction) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    fl.setId(rs.getLong(1));
                }
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
        return check > 0 ? fl.getId() : -1;
    }

    public long saveFlashcardSet(FlashcardSet fls) {
        boolean isAddAction = fls.getId() == null;
        int check = 0;
        Connection con = null;

        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(isAddAction ? FlashcardQuery.ADD_FLASHCARD_SET : ISubjectQuery.UPDATE, java.sql.Statement.RETURN_GENERATED_KEYS)) {
            con = c;
            c.setAutoCommit(false);

            ps.setString(1, fls.getName());
            ps.setString(2, fls.getAnswer());
            ps.setDate(3, fls.getCreatedAt() == null ? java.sql.Date.valueOf(LocalDate.now()) : java.sql.Date.valueOf(fls.getCreatedAt()));
            ps.setDate(4, fls.getLastModifiedAt() == null ? java.sql.Date.valueOf(LocalDate.now()) : java.sql.Date.valueOf(fls.getLastModifiedAt()));
            ps.setLong(5, fls.getFlashcard().getId());
            ps.setLong(6, fls.getCreatedBy());
            ps.setLong(7, fls.getLastModifiedBy());

            if (!isAddAction) {
                ps.setLong(8, fls.getId());
            }

            check = ps.executeUpdate();
            c.commit();

            if (isAddAction) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    fls.setId(rs.getLong(1));
                }
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

        return check > 0 ? fls.getId() : -1;
    }
    
    public boolean saveFlashcardAccess(FlashcardAccess flashcardAccess) throws SQLException {
        Connection con = null;
        int rowAffected = -1;
        try (Connection c = DatabaseConnection.getConnection(); 
                PreparedStatement ps = c.prepareStatement(FlashcardQuery.ADD_FLASHCARD_ACCESS)) {
            con = c;
            c.setAutoCommit(false);
            ps.setLong(1, flashcardAccess.getFlashcard().getId());
            ps.setLong(2, flashcardAccess.getUser().getId());
            ps.setDate(3, java.sql.Date.valueOf(flashcardAccess.getAccessTime()));
            
            rowAffected = ps.executeUpdate();
            c.commit();
        } catch (SQLException ex) {
            if (con != null) {
                con.rollback();
            }
            Logger.getLogger(FlashcardRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rowAffected > 0;
    }
}
