package constant;

public final class ExamQueryConstant {

    public static final String FIND = """
                  select e.exam_id, e.title, e.duration, e.class_id, 
                         q.question_id, q.content, q.lesson_id, a.answer_id, a.answer, a.is_correct
                  from exam e
                  join exam_question eq on e.exam_id = eq.exam_id
                  join question q on eq.question_id = q.question_id
                  join answer a on q.question_id = a.question_id
                  """;

    public static final String FIND_BY_ID = FIND + """
                               where e.exam_id = ?
                               """;

    public static final String FIND_BY_CLASS_ID = """
                                     select e.exam_id, e.title, e.duration, c.class_id
                                     from exam e
                                     join class c on e.class_id = c.class_id
                                     where c.class_id = ?
                                     """;
    
    public static final String GET_TOTAL_QUESTION = """
                                select count(question_id)
                                from exam_question
                                where exam_id = ?
                                """;
    
    public static final String GET_TOTAL_EXAM_BY_STUDENT = """
                                                           select count(ed.user_id) as total_exams
                                                           from exam_details ed
                                                           where ed.user_id = ?
                                                           """;
    
    public static final String GET_TOTAL_PRACTICES_BY_STUDENT = """
                                                                select count(student_id) as total_practices
                                                                from practice_details
                                                                where student_id = ?
                                                                """;
    
    public static final String GET_EXAM_STATISTICS_OF_A_STUDENT = """
                                                                  select eq.exam_id, eq.question_id, ed.user_id, ed.submitted_answer, ed.correct_answer
                                                                  from exam_question eq
                                                                  left join exam_details ed on eq.exam_id = ed.exam_id and eq.question_id = ed.question_id
                                                                  where ed.user_id = ?
                                                                  """;
}
