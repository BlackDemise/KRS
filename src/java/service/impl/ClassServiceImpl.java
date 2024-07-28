/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service.impl;

import dto.ClassDto;
import dto.StudentDto;
import entity.Classroom;
import entity.User;
import java.util.List;
import repository.impl.ClassRepositoryImpl;
import repository.impl.SubjectRepositoryImpl;
import repository.impl.UserRepositoryImpl;
import service.ClassService;

/**
 *
 * @author Hai Duc
 */
public class ClassServiceImpl implements ClassService {

    private static final ClassServiceImpl instance = new ClassServiceImpl();

    private ClassServiceImpl() {
    }

    public static ClassServiceImpl getInstance() {
        return instance;
    }

    private final ClassRepositoryImpl classRepository = ClassRepositoryImpl.getInstance();
    private final UserRepositoryImpl userRepository = UserRepositoryImpl.getInstance();
    private final SubjectRepositoryImpl subjectRepository = SubjectRepositoryImpl.getInstance();

    public List<Classroom> findAll() {
        return classRepository.findAll();
    }

    public Classroom findById(Long classId) {
        return classRepository.findById(classId);
    }

    public int getTotalClasses(Long studentId) {
        return classRepository.getTotalClasses(studentId);
    }

    public List<Classroom> findByStudent(Long studentId) {
        return classRepository.findByStudent(studentId);
    }
    
    public List<ClassDto> getClassStatisticsByStudentAndSubject(Long studentId, Long subjectId) {
        return classRepository.getClassStatisticsByStudentAndSubject(subjectId, studentId);
    }
    
    public boolean addStudentToClass(String studentEmail, Long classroom){
        
            
        
        return classRepository.addStudentToClass(studentEmail, classroom);
    }
}
