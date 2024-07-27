package constant;

public final class ClassQueryConstant {

    public static final String FIND_ALL = """
                      select *
                      from class
                      """;

    public static final String FIND_BY_ID = FIND_ALL + """
                                   where class_id = ?
                                   """;

    public static final String FIND_BY_SUBJECT = FIND_ALL + """
                                        where subject_id = ?
                                        """;

    public static final String FIND_BY_STUDENT = """
                                                 select
                                                    c.*
                                                 from
                                                    student_class sc
                                                 join
                                                    class c on sc.class_id = c.class_id
                                                 where
                                                    sc.user_id = ?
                                                 """;

    public static final String FIND_ALL_STUDENTS = """
                               select
                                   c.class_id, 
                                   c.name as class_name, 
                                   c.max_attendance as class_max_attendance, 
                                   c.teacher_id, 
                                   c.subject_id, 
                                   u.id as student_id, 
                                   u.full_name as student_full_name, 
                                   u.email as student_email, 
                                   u.status as student_status
                               from class c
                               join student_class sc on c.class_id = sc.class_id
                               join user u on sc.user_id = u.id
                               where c.class_id = ?
                               """;

    public static final String ADD_NEW_STUDENT_TO_CLASS = """
                                      insert into student_class (user_id, class_id)
                                      values (?, ?)
                                      """;

    public static final String LEAVE_CLASS = """
                         delete from student_class
                         where user_id = ?
                          and class_id = ?
                         """;

    public static final String FIND_ALL_CLASSES = """
                              select c.class_id, c.name, c.max_attendance, c.teacher_id, c.subject_id from class c
                              join user u on c.teacher_id = u.id and u.role_id = ?
                              join subject s on c.subject_id = s.id
                              """;

    public static final String TOTAL_CLASSES = """
                               SELECT COUNT(*) AS total FROM class
                           """;

    public static final String TOTAL_CLASSES_OF_A_STUDENT = """
                                                            select count(sc.user_id) as total_classes
                                                            from class c
                                                            join student_class sc on c.class_id = sc.class_id
                                                            where sc.user_id = ?
                                                            """;
    
    public static final String GET_CLASS_STATISTICS = """
                                                      SELECT 
                                                          s.id AS subject_id,
                                                          s.name AS subject_name,
                                                          s.code AS subject_code,
                                                          s.category AS subject_category,
                                                          c.class_id,
                                                          c.name AS class_name,
                                                          u.id AS teacher_id,
                                                          u.full_name AS teacher_full_name,
                                                          COUNT(sc.user_id) AS total_students_in_class
                                                      FROM
                                                          subject s
                                                          JOIN class c ON s.id = c.subject_id
                                                          JOIN user u ON c.teacher_id = u.id
                                                          JOIN student_class sc ON sc.class_id = c.class_id
                                                      WHERE
                                                          s.status LIKE ? and s.id = ?
                                                      GROUP BY 
                                                          s.id, s.name, s.code, s.category,
                                                          c.class_id, c.name,
                                                          u.id, u.full_name
                                                      HAVING 
                                                          MAX(CASE WHEN sc.user_id = ? THEN 1 ELSE 0 END) = ?;
                                                      """;
}
