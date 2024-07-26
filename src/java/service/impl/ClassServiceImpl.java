/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service.impl;

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

    @Override
    public List<Classroom> findAll() {
        return classRepository.findAll();
    }

    @Override
    public List<Classroom> findAll(int itemsPerPage, int currentPage) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Classroom> findByFilters(String className, String teacherName, String subjectName, int itemsPerPage, int currentPage) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<StudentDto> findAllStudents(Long classId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int getTotalClasses() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public int getTotalClassesByFilters(String className, String teacherName, String subjectName) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void save(Classroom classroom) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void addStudentToClass(User student, Classroom classroom) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void clearStudents(Long classId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void updateStatus(Classroom classroom) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Classroom findById(Long classId) {
        return classRepository.findById(classId);
    }

    @Override
    public int getTotalClasses(Long studentId) {
        return classRepository.getTotalClasses(studentId);
    }

    public List<Classroom> findByStudent(Long studentId) {
        return classRepository.findByStudent(studentId);
    }
}
