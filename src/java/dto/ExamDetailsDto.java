package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ExamDetailsDto {

    private Long examId;
    private Long questionId;
    private Long studentId;
    private Long submittedAnswerId;
    private Long correctAnswerId;
}
