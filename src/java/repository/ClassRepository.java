package repository;

import dto.StudentDto;
import entity.Classroom;
import java.util.List;

public interface ClassRepository {
    List<Classroom> findAll();
    List<Classroom> findBySubject(Long subjectId);
    Classroom findById(Long classId);
    List<StudentDto> findAllStudents(Long classId);
    boolean add(Long studentId, Long classId);
    boolean leave(Long studentId, Long classId);
    int getTotalClasses(Long studentId);
}
