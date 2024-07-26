/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.regex.Pattern;

/**
 *
 * @author Hai Duc
 */
public class ClassValidation {

    public static boolean isValidClassName(String className) {
        String regex = "^[\\w .-_]{6,30}$";
        Pattern pattern = Pattern.compile(regex, Pattern.UNICODE_CHARACTER_CLASS);
        return pattern.matcher(className).matches();
    }

    public static boolean isValidMaxAttendance(String maxAttendanceStr) {
        try {
            Long maxAttendance = Long.parseLong(maxAttendanceStr);
            return maxAttendance > 0 && maxAttendance <= 100;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
