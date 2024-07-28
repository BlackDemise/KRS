package util;

import entity.User;
import java.time.LocalDate;
import java.util.List;
import java.util.regex.Pattern;

public class UserValidation {

    public static boolean isValidFullName(String fullName) {
        String fullNameRegex = "^[\\w ]{6,30}$";
        Pattern pattern = Pattern.compile(fullNameRegex, Pattern.UNICODE_CHARACTER_CLASS);
        return pattern.matcher(fullName).matches();
    }

    public static boolean isValidEmail(String email, List<User> users) {
        String emailRegex = "^[a-zA-Z0-9._%+-]+@(gmail\\.com|fpt\\.edu\\.vn)$";
        Pattern pattern = Pattern.compile(emailRegex);
        boolean isDuplicated = false;
        for (User u : users) {
            if (email.equals(u.getEmail())) {
                isDuplicated = true;
                break;
            }
        }
        return pattern.matcher(email).matches() && !isDuplicated;
    }

    public static boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9._%+-]+@(gmail\\.com|fpt\\.edu\\.vn)$";
        Pattern pattern = Pattern.compile(emailRegex);
        return pattern.matcher(email).matches();
    }

    public static boolean isValidPhoneNumber(String phoneNumber) {
        String phoneNumberRegex = "^0[0-9]{9,10}$";
        Pattern pattern = Pattern.compile(phoneNumberRegex);
        return pattern.matcher(phoneNumber).matches();
    }

    public static boolean isValidDOB(LocalDate dob) {
        LocalDate currentTime = LocalDate.now();
        int currentYear = currentTime.getYear();
        int dobYear = dob.getYear();
        return currentYear - dobYear >= 18;
    }

    public static boolean isChangingPasswordValid(String newPass, String confirmPass) {
        return newPass.equals(confirmPass);
    }

    public static boolean isPasswordStrong(String password) {
        String passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,40}$";
        Pattern pattern = Pattern.compile(passwordRegex);
        return pattern.matcher(password).matches();
    }
}
