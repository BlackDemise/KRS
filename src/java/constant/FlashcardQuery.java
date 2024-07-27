package constant;

public class FlashcardQuery {

    public static final String FIND_ALL = """
                                          select *
                                          from flashcard
                                          """;

    public static final String ADD = """
                                     INSERT INTO flashcard (name, description, status, created_at, last_modified_at,
                                     subject_id, created_by, last_modified_by) VALUES
                                     (?,?,?,?,?,?,?,?)
                                     """;

    public static final String ADD_FLASHCARD_SET = """
                                                   INSERT INTO flashcard_set (name, answer, created_at, last_modified_at,
                                                   flashcard_id, created_by, last_modified_by)
                                                   VALUES (?,?,?,?,?,?,?)
                                                   """;

    public static final String ADD_FLASHCARD_ACCESS = """
                                                      INSERT INTO flashcard_access (fl_id, user_id, access_time)
                                                      VALUES (?, ?, ?)
                                                      """;

    public static final String FIND_TOP_3_RECENT = """
                                                   SELECT fl.*
                                                   FROM flashcard fl
                                                   JOIN (
                                                       SELECT fl_id, MAX(access_time) as max_access_time
                                                       FROM flashcard_access
                                                       WHERE user_id = ?
                                                       GROUP BY fl_id
                                                       ORDER BY max_access_time DESC
                                                       LIMIT ?
                                                   ) fla ON fl.id = fla.fl_id
                                                   ORDER BY fla.max_access_time DESC;
                                                   """;

    public static final String TOTAL_FLASHCARD_SET = """
                                                     select count(fls.flashcard_id) as total_cards from flashcard fl 
                                                     join flashcard_set fls on fl.id = fls.flashcard_id
                                                     where fls.flashcard_id = ?;
                                                     """;

    public static final String FLASHCARD_SET_DETAILS = """
                                                     select fls.* from flashcard fl
                                                     join flashcard_set fls on fl.id = fls.flashcard_id
                                                     where fl.id = ?
                                                     """;

    public static final String FIND_BY_ID = """
                                             select * from flashcard where id = ?
                                             """;

    public static final String FIND_BY_TITLE = """
                                          SELECT * FROM flashcard WHERE name like ?
                                          """;

    public static final String FIND_BY_CREATOR = """
                                          select *
                                          from flashcard fl
                                          where fl.created_by = ?
                                          """;

    public static final String UPDATE = """
                                        update flashcard set name=?, description=?, status=?, created_at=?, last_modified_at=?,
                                        subject_id=?, created_by=?, last_modified_by=?
                                        where id = ?
                                        """;

    public static final String UPDATE_FLASHCARD_SET = """
                                                      update flashcard_set set name=?, answer=?, created_at=?,
                                                      last_modified_at=?, flashcard_id=?, created_by=?, last_modified_by=?
                                                      where id = ?
                                                      """;
}
