package repository.impl;

import constant.EFlashcardStatus;
import constant.FlashcardQuery;
import entity.Flashcard;
import entity.FlashcardAccess;
import entity.FlashcardSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import mysql.DatabaseConnection;
import repository.FlashcardRepository;
import service.impl.SubjectServiceImpl;

public class FlashcardRepositoryImpl implements FlashcardRepository {

    private static final FlashcardRepositoryImpl instance = new FlashcardRepositoryImpl();

    private final SubjectServiceImpl subjectService = SubjectServiceImpl.getInstance();

    private FlashcardRepositoryImpl() {
    }

    public static FlashcardRepositoryImpl getInstance() {
        return instance;
    }

    public long save(Flashcard fl) {
        boolean isAddAction = fl.getId() == null;
        int check = 0;
        Connection con = null;


        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(isAddAction ? FlashcardQuery.ADD : FlashcardQuery.UPDATE, java.sql.Statement.RETURN_GENERATED_KEYS)) {
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


        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(isAddAction ? FlashcardQuery.ADD_FLASHCARD_SET : FlashcardQuery.UPDATE_FLASHCARD_SET, java.sql.Statement.RETURN_GENERATED_KEYS)) {

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
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(FlashcardQuery.ADD_FLASHCARD_ACCESS)) {
            con = c;
            c.setAutoCommit(false);
            ps.setLong(1, flashcardAccess.getFlashcard().getId());
            ps.setLong(2, flashcardAccess.getUser().getId());
            ps.setObject(3, flashcardAccess.getAccessTime());

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

    public List<Flashcard> findTop3Recent(Long userId, int totalCard) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(FlashcardQuery.FIND_TOP_3_RECENT)) {
            c.setAutoCommit(false);
            ps.setLong(1, userId);
            ps.setLong(2, totalCard);

            try (ResultSet rs = ps.executeQuery()) {
                List<Flashcard> flashcards = new ArrayList();
                while (rs.next()) {
                    flashcards.add(Flashcard.builder()
                            .id(rs.getLong("id"))
                            .name(rs.getString("name"))
                            .description(rs.getString("description"))
                            .status(EFlashcardStatus.valueOf(rs.getString("status").toUpperCase()))
                            .createdAt(rs.getDate("created_at").toLocalDate())
                            .lastModifiedAt(rs.getDate("last_modified_at").toLocalDate())
                            .subject(subjectService.findById(rs.getLong("subject_id")))
                            .createdBy(rs.getLong("created_by"))
                            .lastModifiedBy(rs.getLong("last_modified_by"))
                            .build());
                }
                return flashcards;
            }

        } catch (SQLException ex) {

            Logger.getLogger(FlashcardRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return Collections.emptyList();
    }

    public int countFlashcardSet(Long flashcardId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(FlashcardQuery.TOTAL_FLASHCARD_SET)) {
            ps.setLong(1, flashcardId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return 0;
    }

    public List<FlashcardSet> findFlashcardSet(Long flashcardId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(FlashcardQuery.FLASHCARD_SET_DETAILS)) {
            ps.setLong(1, flashcardId);

            try (ResultSet rs = ps.executeQuery()) {
                List<FlashcardSet> flashcards = new ArrayList();
                while (rs.next()) {
                    flashcards.add(FlashcardSet.builder()
                            .id(rs.getLong("id"))
                            .name(rs.getString("name"))
                            .answer(rs.getString("answer"))
                            .createdAt(rs.getDate("created_at").toLocalDate())
                            .lastModifiedAt(rs.getDate("last_modified_at").toLocalDate())
                            .flashcard(findById(rs.getLong("flashcard_id")))
                            .createdBy(rs.getLong("created_by"))
                            .lastModifiedBy(rs.getLong("last_modified_by"))
                            .build()
                    );
                }
                return flashcards;
            }

        } catch (SQLException ex) {

            Logger.getLogger(FlashcardRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return Collections.emptyList();
    }

    public Flashcard findById(Long id) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(FlashcardQuery.FIND_BY_ID)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return Flashcard.builder()
                        .id(rs.getLong("id"))
                        .name(rs.getString("name"))
                        .description(rs.getString("description"))
                        .status(EFlashcardStatus.valueOf(rs.getString("status").toUpperCase()))
                        .createdAt(rs.getDate("created_at").toLocalDate())
                        .lastModifiedAt(rs.getDate("last_modified_at").toLocalDate())
                        .subject(subjectService.findById(rs.getLong("subject_id")))
                        .createdBy(rs.getLong("created_by"))
                        .lastModifiedBy(rs.getLong("last_modified_by"))
                        .build();
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    public List<Flashcard> findAll() {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(FlashcardQuery.FIND_ALL); ResultSet rs = ps.executeQuery()) {
            List<Flashcard> flashcard = new ArrayList<>();
            while (rs.next()) {
                flashcard.add(Flashcard.builder()
                        .id(rs.getLong("id"))
                        .name(rs.getString("name"))
                        .description(rs.getString("description"))
                        .status(EFlashcardStatus.valueOf(rs.getString("status").toUpperCase()))
                        .createdAt(rs.getDate("created_at").toLocalDate())
                        .lastModifiedAt(rs.getDate("last_modified_at").toLocalDate())
                        .subject(subjectService.findById(rs.getLong("subject_id")))
                        .createdBy(rs.getLong("created_by"))
                        .lastModifiedBy(rs.getLong("last_modified_by"))
                        .build());
            }
            return flashcard;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    public List<Flashcard> findByName(String name) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(FlashcardQuery.FIND_BY_TITLE);) {
            ps.setString(1, "%" + name + "%");
            try (ResultSet rs = ps.executeQuery()) {
                List<Flashcard> flashcard = new ArrayList<>();
                while (rs.next()) {
                    flashcard.add(Flashcard.builder()
                            .id(rs.getLong("id"))
                            .name(rs.getString("name"))
                            .description(rs.getString("description"))
                            .status(EFlashcardStatus.valueOf(rs.getString("status").toUpperCase()))
                            .createdAt(rs.getDate("created_at").toLocalDate())
                            .lastModifiedAt(rs.getDate("last_modified_at").toLocalDate())
                            .subject(subjectService.findById(rs.getLong("subject_id")))
                            .createdBy(rs.getLong("created_by"))
                            .lastModifiedBy(rs.getLong("last_modified_by"))
                            .build());
                }
                return flashcard;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    public List<Flashcard> findByCreator(Long createdBy) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(FlashcardQuery.FIND_BY_CREATOR);) {
            ps.setLong(1, createdBy);
            try (ResultSet rs = ps.executeQuery()) {
                List<Flashcard> flashcard = new ArrayList<>();
                while (rs.next()) {
                    flashcard.add(Flashcard.builder()
                            .id(rs.getLong("id"))
                            .name(rs.getString("name"))
                            .description(rs.getString("description"))
                            .status(EFlashcardStatus.valueOf(rs.getString("status").toUpperCase()))
                            .createdAt(rs.getDate("created_at").toLocalDate())
                            .lastModifiedAt(rs.getDate("last_modified_at").toLocalDate())
                            .subject(subjectService.findById(rs.getLong("subject_id")))
                            .createdBy(rs.getLong("created_by"))
                            .lastModifiedBy(rs.getLong("last_modified_by"))
                            .build());
                }
                return flashcard;
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    public void deleteFlashcardSet(Long id) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement("DELETE FROM flashcard_set WHERE id = ?")) {
            ps.setLong(1, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FlashcardRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
