/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package service;

import dto.StudentDto;
import entity.Classroom;
import entity.User;
import java.util.List;

/**
 *
 * @author Hai Duc
 */
public interface ClassService {

    List<Classroom> findAll();

    List<Classroom> findAll(int itemsPerPage, int currentPage);

    List<Classroom> findByFilters(String className, String teacherName, String subjectName, int itemsPerPage, int currentPage);

    List<StudentDto> findAllStudents(Long classId);

    int getTotalClasses();
    
    int getTotalClasses(Long studentId);

    int getTotalClassesByFilters(String className, String teacherName, String subjectName);

    void save(Classroom classroom);

    void addStudentToClass(User student, Classroom classroom);

    void clearStudents(Long classId);

    void updateStatus(Classroom classroom);

    Classroom findById(Long classId);

}
