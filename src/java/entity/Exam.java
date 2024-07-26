package entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class Exam {

    private Long id;
    private String title;
    private Long duration;
    private Classroom takenClass;
    private User createdBy;

}
