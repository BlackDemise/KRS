package entity;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ExamDetails {
    private Long edId;
    private User student;
    private Exam exam;
    private Question question;
    private Answer submittedAnswer;
    private Answer correctAnswer;
    private LocalDateTime takenAt;
}
