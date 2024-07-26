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

public class Question {

    private Long id;
    private String title;
    private LocalDate createdTime;
    private LocalDate lastModifiedTime;
    private User createdBy;
    private User lastModifiedBy;
    private Lesson lesson;
    
    
}
