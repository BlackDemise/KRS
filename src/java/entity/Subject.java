package entity;

import constant.ESubjectStatus;
import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Subject {

    private Long id;
    private String name;
    private String code;
    private String description;
    private String note;
    private ESubjectStatus status;
    private Category category;
    private LocalDate createdAt;
    private LocalDate lastModifiedAt;
    private long createdBy;
    private Long lastModifiedBy;

}
