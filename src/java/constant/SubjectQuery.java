package constant;

public final class SubjectQuery {

    public static final String FIND_ALL = """
                      SELECT s.id, s.name, s.code, s.description, s.note, s.status, s.category_id, 
                             c.name as category_name, c.description as category_description, c.note as category_note, 
                             c.status as category_status, c.created_at as category_created_at, c.last_modified_at as category_last_modified_at, 
                             c.created_by as category_created_by, c.last_modified_by as category_last_modified_by,
                             s.created_at as subject_created_at, s.last_modified_at as subject_last_modified_at, 
                             s.created_by as subject_created_by, s.last_modified_by as subject_last_modified_by
                      FROM subject s
                      JOIN category c ON s.category_id = c.id
                      """;

    public static final String FIND_BY_ID = """
                        SELECT s.id, s.name, s.code, s.description, s.note, s.status, s.category_id, 
                               c.name as category_name, c.description as category_description, c.note as category_note, 
                               c.status as category_status, c.created_at as category_created_at, c.last_modified_at as category_last_modified_at, 
                               c.created_by as category_created_by, c.last_modified_by as category_last_modified_by,
                               s.created_at as subject_created_at, s.last_modified_at as subject_last_modified_at, 
                               s.created_by as subject_created_by, s.last_modified_by as subject_last_modified_by
                        FROM subject s
                        JOIN category c ON s.category_id = c.id
                        WHERE s.id = ?
                        """;

    public static final String FIND_BY_CODE = """
                          SELECT s.id, s.name, s.code, s.status, c.id as category_id, c.name as category_name 
                          FROM subject s
                          JOIN category c ON s.category_id = c.id
                          WHERE s.code LIKE ?
                          """;

    public static final String FIND_BY_NAME = """
                          SELECT s.id, s.name, s.code, s.status, c.id as category_id, c.name as category_name 
                          FROM subject s
                          JOIN category c ON s.category_id = c.id
                          WHERE s.name LIKE ?
                          """;

    public static final String COUNT_BY_NAME = """
                           SELECT count(*)
                           FROM subject
                           WHERE name LIKE ?
                           """;

    public static final String UPDATE = "UPDATE subject SET name = ?, code = ?, description = ?, note = ?, status = ?, category_id = ? WHERE id = ?";

    public static final String DELETE = """
                    DELETE FROM subject
                    WHERE id = ?
                    """;

    public static final String ADD = "INSERT INTO subject "
            + "(name, code, description, note, status, category_id, created_at, last_modified_at, created_by, last_modified_by)"
            + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    public static final String FIND_BY_NAME_EXACT = """
                                SELECT s.id, s.name, s.code, s.status, c.id as category_id, c.name as category_name 
                                FROM subject s
                                JOIN category c ON s.category_id = c.id
                                WHERE s.name = ?
                                """;
    public static final String ADD_SUBJECT_MANAGER = """
                                 INSERT INTO subject_manager (user_id, subject_id)
                                 VALUES ((select id from user where email like ?), ?)   
                                 """;

    public static final String COUNT_ALL = """
                                            SELECT COUNT(*) FROM subject
                                            """;

    public static final String REMOVE_SUBJECT_MANAGERS = "DELETE FROM subject_managers WHERE subject_id = ?";

    public static final String GET_SUBJECT_STATISTICS = """
                                                        SELECT 
                                                            s.id AS subject_id, 
                                                            s.name AS subject_name,
                                                            s.code AS subject_code,
                                                            s.category_id AS subject_category, 
                                                            COUNT(sc.user_id) AS students_in_subject
                                                        FROM 
                                                            subject s
                                                        JOIN 
                                                            class c ON s.id = c.subject_id
                                                        JOIN 
                                                            student_class sc ON c.class_id = sc.class_id
                                                        WHERE
                                                            s.code like ?
                                                        GROUP BY 
                                                            s.id, s.name, s.code, s.category_id
                                                        HAVING
                                                            MAX(CASE WHEN sc.user_id = ? THEN 1 ELSE 0 END) = ?
                                                        """;

    public static final String DELETE_SUBJECT_MANAGERS = """
                                                         delete from subject_manager
                                                         where user_id = (select id from user where email like ?) and subject_id = ?
                                                         """;

}
