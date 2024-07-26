package constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EUserRole {
    ROLE_ADMINISTRATOR("Administrator"),
    ROLE_OPERATOR("Operator"),
    ROLE_MANAGER("Manager"),
    ROLE_TEACHER("Teacher"),
    ROLE_STUDENT("Student");
    
    private final String userRole;
}
