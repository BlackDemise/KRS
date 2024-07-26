package constant;

public final class ExamDetailsQueryConstant {
    public static final String SAVE = """
                                      insert into exam_details (user_id, exam_id, question_id, submitted_answer, correct_answer, taken_at) values
                                      (?, ?, ?, ?, ?, ?)
                                      """;
    
    private ExamDetailsQueryConstant() {
        throw new AssertionError("This class is used for storing constants only!");
    }
}
