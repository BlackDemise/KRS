package constant;

public interface ITermQuery {
    String FIND_ALL = """
                      select *
                      from term
                      """;
    
    String FIND_BY_ID = FIND_ALL + """
                                   where term_id = ?
                                   """;
    
    String FIND_BY_NAME = FIND_ALL + """
                                     where name = ?
                                     """;
}
