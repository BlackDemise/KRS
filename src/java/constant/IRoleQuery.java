package constant;

public interface IRoleQuery {
    String FIND_ALL = """
                      select *
                      from role
                      where title not like ?
                      """;
    String FIND_BY_ID = """
                            select *
                            from role
                            where id = ?
                            """;
    String FIND_BY_TITLE = """
                           select *
                           from role
                           where title like ?
                           """;
}
