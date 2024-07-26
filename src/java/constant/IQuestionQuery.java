package constant;

public interface IQuestionQuery {
    String FIND_ALL = """
                      select *
                      from question
                      """;
    
    String FIND_BY_ID = FIND_ALL + """
                                   where question_id = ?
                                   """;
    String FIND_BY_LESSON = FIND_ALL + """
                                       where lesson_id = ?
                                       """;
    
    String FIND_BY_EXAM = """
                          select e.exam_id, e.title, e.duration, e.class_id, 
                                 q.question_id, q.content, q.lesson_id
                          from exam e
                          join exam_question eq on e.exam_id = eq.exam_id
                          join question q on eq.question_id = q.question_id
                          where e.exam_id = ?
                          """;
    
    String ADD = """
                 insert into question (content, lesson_id)
                 values (?, ?)
                 """;
    
    String DELETE_BY_ID = """
                          delete from question
                          where question_id = ?
                          """;
    
    String DELETE_BY_LESSON = """
                              delete from lesson
                              where subject_id = ?
                              """;
}
