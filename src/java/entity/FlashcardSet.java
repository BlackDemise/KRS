
package entity;

import constant.EFlashcardStatus;
import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FlashcardSet {
    private Long id;
    private String name;
    private String answer;
    private LocalDate createdAt;
    private LocalDate lastModifiedAt;
    private Flashcard flashcard;
    private long createdBy;
    private Long lastModifiedBy;

}
