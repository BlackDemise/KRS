package dto;

import entity.Category;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SubjectDto {
    private Long subjectId;
    private String subjectName;
    private String subjectCode;
    private Category subjectCategory;
    private Long totalStudents;
}
