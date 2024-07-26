package util;

import repository.impl.SubjectRepositoryImpl;
import entity.Subject;

public class SubjectValidation {

    private static final SubjectRepositoryImpl subjectRepository = SubjectRepositoryImpl.getInstance();

    // Validate Name: Only alphabets (both lowercase and uppercase), spaces, and positive integers, can be in English or Vietnamese
    public static boolean validateName(String name) {
        String nameRegex = "^[a-zA-ZÀ-ỹ\\s\\d]+$";
        return name != null && name.matches(nameRegex);
    }

    // Validate Code: Only alphabets (both lowercase and uppercase) and positive integers, can be in English or Vietnamese
    public static boolean validateCode(String code) {
        String codeRegex = "^[a-zA-ZÀ-ỹ\\d]+$";
        return code != null && code.matches(codeRegex);
    }

    // Check for duplicate subject name
    public static boolean isDuplicateSubjectName(String name) {
        Subject existingSubject = subjectRepository.findByNameExact(name);
        return existingSubject != null;
    }
}
