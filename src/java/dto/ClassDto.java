package dto;

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
public class ClassDto {
    private Long subjectId;
    private String subjectName;
    private String subjectCode;
    private String subjectCategory;
    private Long classId;
    private String className;
    private Long teacherId;
    private String teacherFullName;
    private Long totalStudents;
}