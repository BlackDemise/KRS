package constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum EUserStatus {
    ACTIVE("Active"),
    INACTIVE("Inactive");
    
    private final String userStatus;
}
