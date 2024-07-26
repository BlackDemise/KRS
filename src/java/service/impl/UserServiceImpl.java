package service.impl;

import dto.StudentDto;
import entity.User;
import jakarta.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.mindrot.jbcrypt.BCrypt;
import repository.impl.UserRepositoryImpl;
import service.UserService;
import static util.UserValidation.isValidDOB;
import static util.UserValidation.isValidEmail;
import static util.UserValidation.isValidFullName;
import static util.UserValidation.isValidPhoneNumber;

public class UserServiceImpl implements UserService {

    private static final UserServiceImpl instance = new UserServiceImpl();

    private UserServiceImpl() {
    }

    public static UserServiceImpl getInstance() {
        return instance;
    }

    private final UserRepositoryImpl userRepository = UserRepositoryImpl.getInstance();

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public User save(User u, HttpServletRequest request) {
        boolean isValidFullName = isValidFullName(u.getFullName());
        boolean isValidEmail = u.getId() == null ? isValidEmail(u.getEmail(), findAll()) : isValidEmail(u.getEmail());
        boolean isValidDOB = isValidDOB(u.getDob());
        boolean isValidPhoneNumber = isValidPhoneNumber(u.getPhoneNumber());

        if (!isValidFullName || !isValidEmail || !isValidDOB || !isValidPhoneNumber) {
            request.setAttribute("fullName", u.getFullName());
            request.setAttribute("email", u.getEmail());
            request.setAttribute("dob", u.getDob());
            request.setAttribute("phoneNumber", u.getPhoneNumber());
            request.setAttribute("roleId", u.getRole().getId());
            request.setAttribute("status", u.getUserStatus().name());
            Map<String, String> errors = new HashMap<>();
            if (!isValidFullName) {
                errors.put("errorName", "Name can only contain alphanumeric characters and spacebar, with minimum length of 6 and maximum length of 30!");
            } else {
                errors.put("errorName", "None");
            }
            if (!isValidEmail) {
                errors.put("errorEmail", "Email must end with either @gmail.com or @fpt.edu.vn and contain only a-z, A-Z, 0-9 and (+-_%); or email might have already existed!");
            } else {
                errors.put("errorEmail", "None");
            }
            if (!isValidDOB) {
                errors.put("errorDob", "At least 18 years old is required to join the community!");
            } else {
                errors.put("errorDob", "None");
            }
            if (!isValidPhoneNumber) {
                errors.put("errorPhoneNumber", "Phone number must start with 0 and have either 10 or 11 digits!");
            } else {
                errors.put("errorPhoneNumber", "None");
            }
            errors.put("checkRole", "check");
            errors.put("checkStatus", "check");
            request.setAttribute("errors", errors);
            return null;
        }

        return userRepository.save(u);
    }

    @Override
    public List<User> findAllWithPaging(int itemsPerPage, int page) {
        List<User> users = userRepository.findAll();
        int numberOfUsers = users.size();
        int maximumPage = numberOfUsers / itemsPerPage + 1;
        boolean isValidPaging = itemsPerPage > 0 && page > 0 && page <= maximumPage;
        if (!isValidPaging) {
            itemsPerPage = 4;
            page = 1;
        }
        return userRepository.findAll(itemsPerPage, page);
    }

    @Override
    public User findById(Long userId) {
        return userId == null ? null : userRepository.findById(userId);
    }

    @Override
    public User findByEmailToLogin(String email, String password) {
        boolean isValidToProceed = email != null && !email.isEmpty() && password != null && !password.isEmpty();
        if (isValidToProceed) {
            return userRepository.findByEmail(email, password);
        }
        return null;
    }

    @Override
    public User findByEmailToResetPassword(String email) {
        return email == null ? null : userRepository.findByEmail2(email);
    }

    @Override
    public boolean findByEmailToChangePassword(User u, String oldPassword, String newPassword,
            String confirmPassword, HttpServletRequest request) {
        boolean isOldPasswordValid = oldPassword != null && BCrypt.checkpw(oldPassword, u.getPassword());
        boolean isTwoPasswordsMatched = newPassword != null && confirmPassword != null && newPassword.equals(confirmPassword);
        Map<String, String> errors = new HashMap<>();

        if (!isOldPasswordValid) {
            errors.put("invalidOldPass", "Old password is not valid!");
        } else {
            errors.put("invalidOldPass", "None");
        }
        if (!isTwoPasswordsMatched) {
            errors.put("passwordsMismatch", "The confirm password does not match the new one!");
        } else {
            errors.put("passwordsMismatch", "None");
        }
        request.setAttribute("errors", errors);
        if (isOldPasswordValid && isTwoPasswordsMatched) {
            newPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt(12));
            return userRepository.changePassword(u.getEmail(), newPassword);
        }
        request.setAttribute("oldPass", oldPassword);
        request.setAttribute("newPass", newPassword);
        request.setAttribute("confirmPass", confirmPassword);
        return false;
    }

    @Override
    public boolean toggleById(Long userId) {
        return userId == null ? false : userRepository.toggleById(userId);
    }

    @Override
    public List<User> findAllTeachers() {
        return userRepository.findAllTeachers();
    }

    @Override
    public List<StudentDto> findAllStudents() {
        return userRepository.findAllStudents();
    }

    public List<User> findByRole(Long roleId) {
        return userRepository.findByRole(roleId);
    }

    public List<User> findManagerById(Long subjectId) {
        return userRepository.findManagerById(subjectId);
    }
    
    public List<User> findStudentById(Long studentId) {
        return userRepository.findStudentById(studentId);
    }
}
