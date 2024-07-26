
package constant;


public interface IPostQuery {
    String FIND_ALL = """
                      select *
                      from post
                      order by post_at desc
                      """;
    String FIND_BY_ID =  """
                                   select *
                                   from post
                                   where post_id = ?
                                   """;
    String FIND_BY_USER =  """
                                        select *
                                       from post
                                       where user_id = ?
                                       """;
    
    String DELETE_BY_ID = """
                          delete from post
                          where post_id = ?
                          """;
    String ADD = """
                 insert into post ( title, content, user_id)
                 values ( ?, ?, ?)
                 """;
    String UPDATE = """
                    update post
                    set title = ?,
                        content = ?
                    where post_id = ?
                    """;
}
