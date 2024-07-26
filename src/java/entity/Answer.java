package entity;

import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Answer {

    private Long answerId;
    private String answer;
    private LocalDate createdTime;
    private LocalDate lastModifiedTime;
    private boolean isCorrect;
    private Question question;

}
