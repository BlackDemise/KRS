/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package constant;

/**
 *
 * @author Hai Duc
 */
public class FlashcardQuery {

    public static final String ADD = """
                                     INSERT INTO flashcard (name, description, status, created_at, last_modified_at,
                                     subject_id, created_by, last_modified_by) VALUES
                                     (?,?,?,?,?,?,?,?)
                                     """;
    
    public static final String ADD_FLASHCARD_SET = """
                                                   INSERT INTO flashcard_set (name, answer, status, created_at, last_modified_at,
                                                   flashcard_id, created_by, last_modified_by)
                                                   VALUES (?,?,?,?,?,?,?,?)
                                                   """;
}
