package util;

import jakarta.servlet.http.HttpServletRequest;

public class AttributeSet {

    public static void checkAndSetAttribute(HttpServletRequest request, String parameterName, String... validValues) {
        String parameterValue = request.getParameter(parameterName);
        if (parameterValue != null) {
            for (String validValue : validValues) {
                if (parameterValue.equalsIgnoreCase(validValue)) {
                    request.setAttribute(parameterName, parameterValue);
                    break;
                }
            }
        }
    }
}
