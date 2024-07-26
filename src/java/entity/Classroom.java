package entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class Classroom {
    private Long id;
    private String title;
    private User teacher;
    private Subject subject;
    private String status;
}
