package constant;

public final class MaterialQueryConstant {
    public static final String FIND_ALL = """
                                          select *
                                          from material
                                          """;
    
    public static final String FIND_BY_ID = FIND_ALL + """
                                                       where material_id = ?
                                                       """;
    
    public static final String FIND_BY_LESSON = FIND_ALL + """
                                                           where lesson_id = ?
                                                           """;
}
