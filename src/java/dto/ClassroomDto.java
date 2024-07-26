
package dto;

import entity.Classroom;
import entity.User;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class ClassroomDto {
    private Classroom classRoom;
    private List<User> students;
}
