
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

public class Comment {
    private Long comment_id;
    private String content;
    private User user_id;
    private Post post_id;
    private LocalDate created_at;
}
