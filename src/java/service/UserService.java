package service;

import dto.StudentDto;
import entity.User;
import jakarta.servlet.http.HttpServletRequest;
import java.util.List;

public interface UserService {

    List<User> findAll();

    List<User> findAllWithPaging(int itemsPerPage, int page);

    List<User> findAllTeachers();
    
    List<StudentDto> findAllStudents();

    User findById(Long userId);

    User findByEmailToLogin(String email, String password);

    User findByEmailToResetPassword(String email);

    User save(User u, HttpServletRequest request);

    boolean findByEmailToChangePassword(User u, String oldPassword, String newPassword, 
            String confirmPassword, HttpServletRequest request);

    boolean toggleById(Long userId);
}
