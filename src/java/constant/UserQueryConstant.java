package constant;

public final class UserQueryConstant {

    public static final String FIND_ALL = """
                      select *
                      from user
                      """;

    public static final String FIND_ALL_WITH_PAGING = FIND_ALL + """
                                             limit ?
                                             offset ?
                                             """;

    public static final String FIND_BY_ID = FIND_ALL + """
                                   where id = ?
                                   """;

    public static final String FIND_BY_EMAIL = FIND_ALL + """
                                      where email like ?
                                      and status like ?
                                      """;
    
    public static final String FIND_BY_ROLE = FIND_ALL + """
                                                         where role_id = ?
                                                         """;

    public static final String ADD = """
                 insert into user (full_name, avatar, note, email, phone_number, dob, password, status, role_id, created_at, last_modified_at, created_by, last_modified_by)
                 values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                 """;

    public static final String UPDATE = """
                    update user
                    set full_name = ?,
                        avatar = ?,
                        note = ?,
                        email = ?,
                        phone_number = ?,
                        dob = ?,
                        password = ?,
                        status = ?,
                        role_id = ?,
                        created_at = ?,
                        last_modified_at = ?,
                        created_by = ?,
                        last_modified_by = ?
                    where id = ?
                    """;

    public static final String TOGGLE = """
                    update user
                    set status = ?
                    where id = ?
                    """;

    public static final String RESET_PASSWORD = """
                            update user
                            set password = ?
                            where email = ?
                            """;
    
     public static final String FIND_MANAGER_BY_ID = "SELECT u.* FROM user u " +
                                                    "INNER JOIN subject_manager sm ON u.id = sm.user_id " +
                                                    "WHERE sm.subject_id = ?";
    
    private UserQueryConstant() {
        throw new AssertionError("This class is used for storing constants only!");
    }

}
