package entity;

import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class Category {

    private Long id;
    private String name;
    private String description;
    private String note;
    private String status;
    private LocalDate createdAt;
    private LocalDate lastModifiedAt;
    private long createdBy;
    private Long lastModifiedBy;
}
