package filter;

import constant.EUserRole;
import entity.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class SessionFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        String requestURI = httpRequest.getRequestURI();

        if (isLoggedIn) {
            assert session != null;
            User u = (User) session.getAttribute("user");

            EUserRole r = u.getRole().getTitle();
            boolean isAuthenticated;
            switch (r) {
                case ROLE_ADMINISTRATOR -> {
                    isAuthenticated = true;
                }
                case ROLE_MANAGER -> {
                    isAuthenticated = (requestURI.contains("/user") || requestURI.contains("/subject")
                            || requestURI.contains("/class") || requestURI.contains("/lessson")
                            || requestURI.contains("/question") || requestURI.contains("/answer") || requestURI.contains("/dashboard"))
                            && !requestURI.contains("/user/add") && !requestURI.contains("/user/update")
                            && !requestURI.contains("/user/toggle");
                }
                case ROLE_TEACHER -> {
                    isAuthenticated = (requestURI.contains("/user") || requestURI.contains("/subject")
                            || requestURI.contains("/class") || requestURI.contains("/lessson")
                            || requestURI.contains("/question") || requestURI.contains("/answer") || requestURI.contains("/dashboard"))
                            && !requestURI.contains("/user/add") && !requestURI.contains("/user/update")
                            && !requestURI.contains("/user/toggle") && !requestURI.contains("/subject/add")
                            && !requestURI.contains("/subject/update") && !requestURI.contains("/subject/updateStatus")
                            && !requestURI.contains("/class/add") && !requestURI.contains("/class/update")
                            || requestURI.contains("/flashcard/all-flashcard") || requestURI.contains("/flashcard/my-flashcard")
                            || requestURI.contains("/flashcard/add-flashcard");
                }
                case ROLE_STUDENT -> {
                    isAuthenticated = requestURI.contains("/my-subjects") || requestURI.endsWith("/dashboard")
                            || requestURI.endsWith("/user/profile") || requestURI.endsWith("/user/change-password")
                            && !requestURI.contains("/user/add") && !requestURI.contains("/user/update")
                            && !requestURI.contains("/user/toggle") && !requestURI.contains("/subject/add")
                            && !requestURI.contains("/subject/update") && !requestURI.contains("/subject/updateStatus")
                            && !requestURI.contains("/class/add") && !requestURI.contains("/class/update")
                            || requestURI.contains("/flashcard/all-flashcard") || requestURI.contains("/flashcard/my-flashcard")
                            || requestURI.contains("/flashcard/add-flashcard");
                }
                default -> {
                    isAuthenticated = false;
                }
            }
            if (isAuthenticated) {
                chain.doFilter(request, response);
            } else {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN);
            }
        } else {
            boolean isHomepage = requestURI.endsWith("/");
            boolean isLogin = requestURI.endsWith("/login");
            boolean isRegister = requestURI.endsWith("/register");
            boolean isVerifyEmail = requestURI.endsWith("/main/verify-email.jsp");
            boolean isEnterEmail = requestURI.endsWith("/main/enter-email.jsp");

            if (isHomepage || isLogin || isRegister || isEnterEmail) {
                chain.doFilter(request, response);
            } else {
                httpResponse.sendRedirect("/login?proceed=no");
            }
        }
    }
}
