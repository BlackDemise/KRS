/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service.impl;

import entity.Flashcard;
import entity.FlashcardAccess;
import entity.FlashcardSet;
import jakarta.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import repository.impl.FlashcardRepositoryImpl;
import service.FlashcardService;
import util.FlashcardValidation;

/**
 *
 * @author Hai Duc
 */
public class FlashcardServiceImpl implements FlashcardService {

    private static final FlashcardServiceImpl instance = new FlashcardServiceImpl();

    private FlashcardServiceImpl() {
    }

    public static FlashcardServiceImpl getInstance() {
        return instance;
    }

    private final FlashcardRepositoryImpl flashcardRepository = FlashcardRepositoryImpl.getInstance();

    public long save(Flashcard fl, HttpServletRequest request) {
        boolean isValidName = FlashcardValidation.isValidName(fl.getName());
        boolean isValidDescription = FlashcardValidation.isValidDescription(fl.getDescription());
        boolean isValidStatus = FlashcardValidation.isValidStatus(fl.getStatus().getFlashcardStatus());
        if (!isValidName || !isValidDescription || !isValidStatus) {
            request.setAttribute("title", fl.getName());
            request.setAttribute("description", fl.getDescription());
            request.setAttribute("status", fl.getStatus().getFlashcardStatus());
            request.setAttribute("subject", fl.getSubject().getId());
            Map<String, String> errors = new HashMap<>();
            if (!isValidName) {
                errors.put("errorName", "Name can only contain alphanumeric characters and spacebar, with minimum length of 1 and maximum length of 100!");
            } else {
                errors.put("errorName", "None");
            }
            if (!isValidDescription) {
                errors.put("errorDescription", "Description can only contain alphanumeric characters and spacebar, with minimum length of 1 and maximum length of 1000!");
            } else {
                errors.put("errorDescription", "None");
            }
            if (!isValidStatus) {
                errors.put("errorStatus", "You must choose status");
            } else {
                errors.put("errorStatus", "None");
            }

            request.setAttribute("errors", errors);
            return -1;
        }
        return flashcardRepository.save(fl);
    }

    public long saveFlashcardSet(FlashcardSet fls, HttpServletRequest request) {
        boolean isValidTerm = FlashcardValidation.isValidTerm(fls.getName());
        boolean isValidDefinition = FlashcardValidation.isValidDefinition(fls.getAnswer());
        if (!isValidTerm || !isValidDefinition) {
            request.setAttribute("term", fls.getName());
            request.setAttribute("definition", fls.getAnswer());
            Map<String, String> errors = new HashMap<>();
            if (!isValidTerm) {
                errors.put("errorTerm", "Term can only contain alphanumeric characters and spacebar, with minimum length of 1 and maximum length of 100!");
            } else {
                errors.put("errorTerm", "None");
            }
            if (!isValidDefinition) {
                errors.put("errorDefinition", "Definition can only contain alphanumeric characters and spacebar, with minimum length of 1 and maximum length of 1000!");
            } else {
                errors.put("errorDefinition", "None");
            }

            request.setAttribute("errors", errors);
            return -1;
        }
        return flashcardRepository.saveFlashcardSet(fls);
    }

    public List<Flashcard> findTop3Recent(Long UserId, int totalCard) {
        return flashcardRepository.findTop3Recent(UserId, totalCard);
    }

    public int countFlashcardSet(Long flashcardId) {
        return flashcardRepository.countFlashcardSet(flashcardId);
    }

    public List<FlashcardSet> findFlashcardSet(Long flashcardId) {
        return flashcardRepository.findFlashcardSet(flashcardId);
    }

    public List<Flashcard> findAll() {
        return flashcardRepository.findAll();
    }

    public List<Flashcard> findByName(String name) {
        return flashcardRepository.findByName(name);
    }

    public Flashcard findById(Long flashcardId) {
        return flashcardRepository.findById(flashcardId);
    }

    public boolean saveFlashcardAccess(FlashcardAccess flashcard) throws SQLException {
        return flashcardRepository.saveFlashcardAccess(flashcard);
    }

    public List<Flashcard> findByCreator(Long creatorId) {
        return flashcardRepository.findByCreator(creatorId);
    }
    
    public void deleteFlashcardSet(Long id){
        flashcardRepository.deleteFlashcardSet(id);
    }
}
