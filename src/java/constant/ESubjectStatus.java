package constant;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ESubjectStatus {
    ACTIVE("Active"),
    INACTIVE("Inactive");

    private final String subjectStatus;
}
