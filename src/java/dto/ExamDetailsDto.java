package dto;

import java.time.LocalDateTime;
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
public class ExamDetailsDto {

    private Long examId;
    private String examTitle;
    private String className;
    private Long questionId;
    private Long studentId;
    private Long submittedAnswerId;
    private Long correctAnswerId;
    private LocalDateTime takenAt;
}
