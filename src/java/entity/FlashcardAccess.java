package entity;

import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FlashcardAccess {
    private Long id;
    private Flashcard flashcard;
    private User user;
    private LocalDate accessTime;
}
