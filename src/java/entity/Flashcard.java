/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import constant.EFlashcardStatus;
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
public class Flashcard {
    private Long id;
    private String name;
    private String description;
    private EFlashcardStatus status;
    private LocalDate createdAt;
    private LocalDate lastModifiedAt;
    private Subject subject;
    private long createdBy;
    private Long lastModifiedBy;
}
