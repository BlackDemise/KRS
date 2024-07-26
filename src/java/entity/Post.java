
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

public class Post {
    private Long post_id;
    private String title;
    private String content;
    private User user_id;
    private LocalDate post_at;
}
