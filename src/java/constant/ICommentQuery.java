/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package constant;

/**
 *
 * @author Admin
 */
public interface ICommentQuery {

    String FIND_ALL = """
                      select *
                      from comment
                      where post_id=?
                      order by create_at desc
                      """;
    String FIND_BY_ID = """
                             select *
                                   from comment
                                   where comment_id = ?
                                   """;
    String FIND_BY_USER = """          
                                    select *
                                    from comment
                                    where user_id = ?
                                    """;

    String DELETE_BY_ID = """
                          delete from comment
                          where comment_id = ?
                          """;
    String ADD = """
                 insert into comment (content, user_id, post_id)
                 values ( ?, ?, ?)
                 """;
    String UPDATE = """
                    update comment
                    set content = ?                     
                    where comment_id = ?
                    """;

}
