package constant;

public interface ILessonQuery {
    String FIND_ALL = """
                      select *
                      from lesson
                      """;
    
    String FIND_BY_SUBJECT = FIND_ALL + """
                                   where subject_id = ?
                                   """;
    
//    String FIND_BY_ID = FIND_ALL + """
//                                   where lesson_id = ?
//                                   """;
    String FIND_BY_ID = """
                        select * from lesson where lesson_id = ?
                        """;
    String FIND_BY_STATUS = FIND_ALL + """
                                   where status = ?
                                   """;
    String FIND_BY_SUBJECT_AND_STATUS = FIND_ALL + """
                                   where subject_id = ? and status = ?
                                   """;
    
    String ADD = """
                 insert into lesson (name, status, subject_id)
                 values (?, ?, ?)
                 """;
    
    String DELETE_BY_SUBJECT = """
                               delete from lesson
                               where subject_id = ?
                               """;
    
    String DELETE_BY_ID = """
                          delete from lesson
                          where lesson_id = ?
                          """;
    
    String UPDATE_BY_SUBJECT = """
                               update lesson
                               set name = ?
                               where subject_id = ?
                               """;
    
    String UPDATE_BY_ID = """
                          update lesson
                          set name = ?,
                              status = ?,
                              subject_id = ?
                          where lesson_id = ?
                          """;
    String DELETE = """
                    delete from lesson
                    where lesson_id = ?
                    """;
    
}
