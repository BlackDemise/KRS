package dto;

import constant.EUserStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class StudentDto {

    private Long studentId;
    private String studentFullName;
    private String studentEmail;
    private EUserStatus studentStatus;
    private boolean selected;

    public StudentDto(Long studentId, String studentFullName, String studentEmail, EUserStatus studentStatus) {
        this.studentId = studentId;
        this.studentFullName = studentFullName;
        this.studentEmail = studentEmail;
        this.studentStatus = studentStatus;
        this.selected = false; // Default value for selected
    }
}
