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
}
