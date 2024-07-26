package constant;

public interface IAnswerQuery {
    String FIND_ALL = """
                      select *
                      from answer
                      """;
    
    String FIND_BY_ID = FIND_ALL + """
                                   where answer_id = ?
                                   """;
    
    String FIND_BY_QUESTION_IN_EXAM = """
                                      SELECT e.exam_id, q.question_id, q.content, a.answer_id, a.answer, a.is_correct
                                      FROM exam e
                                      JOIN exam_question eq ON e.exam_id = eq.exam_id
                                      JOIN question q ON eq.question_id = q.question_id
                                      LEFT JOIN answer a ON q.question_id = a.question_id
                                      WHERE e.exam_id = ?
                                      """;
}
