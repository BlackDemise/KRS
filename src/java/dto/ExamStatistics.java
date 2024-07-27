package dto;

import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class ExamStatistics {
    private Long examId;
    private String examTitle;
    private String className;
    private int actualScore;
    private int maxScore;
    private LocalDate takenAt;
    
    public void incrementActualScore() {
        actualScore++;
    }
    
    public void incrementMaxScore() {
        maxScore++;
    }
}

