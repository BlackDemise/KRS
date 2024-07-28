package controller.main;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import constant.IGoogleConnection;
import constant.UserQueryConstant;
import dto.ExamStatistics;
import dto.GoogleUserDto;
import entity.Token;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import mysql.DatabaseConnection;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import org.mindrot.jbcrypt.BCrypt;
import repository.impl.TokenRepository;
import repository.impl.UserRepositoryImpl;
import service.impl.ClassServiceImpl;
import service.impl.ExamServiceImpl;
import service.impl.UserServiceImpl;
import util.SendEmail;
import util.UserValidation;

@WebServlet(name = "MainServlet", urlPatterns = {"/contact", "/google-login", "/login", "/logout", "/change-password", "/register",
    "/reset-password", "/send-code", "/validate-otp", "/register/verify", "/dashboard"})
public class MainServlet extends HttpServlet {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SMTP_AUTH_USER = "ttd21072004@gmail.com";
    private static final String SMTP_AUTH_PWD = "nprg luav iglp rltu";
    private static final long EMAIL_INTERVAL = 5 * 60 * 1000; // 5 phút tính bằng milliseconds

    private final UserServiceImpl userService = UserServiceImpl.getInstance();
    private final ClassServiceImpl classService = ClassServiceImpl.getInstance();
    private final ExamServiceImpl examService = ExamServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        final String ACTION = request.getServletPath();

        switch (ACTION) {
            case "/google-login" -> {
                try {
                    loginByGoogle(request, response);
                } catch (IOException ex) {
                    Logger.getLogger(MainServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "/logout" -> {
                try {
                    logout(request, response);
                } catch (IOException ex) {
                    Logger.getLogger(MainServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "/register" -> {
                try {
                    request.getRequestDispatcher("/main/register.jsp").forward(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(MainServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "/register/verify" -> {
                try {
                    verify(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(MainServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "/login" -> {
                try {
                    request.getRequestDispatcher("/main/login.jsp").forward(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(MainServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "/dashboard" -> {
                try {
                    HttpSession session = request.getSession(false);
                    User currentUser = (User) session.getAttribute("user");
                    String userRole = currentUser.getRole().getTitle().getUserRole();
                    switch (userRole) {
                        case "Student" -> {
                            Long studentId = currentUser.getId();
                            int totalClasses = classService.getTotalClasses(studentId);
                            int totalExams = examService.getTotalExamsByStudent(studentId);
                            int totalPractices = examService.getTotalPracticesByStudent(studentId);
                            Map<Long, ExamStatistics> examStatisticsMap = examService.getExamStatisticsOfAStudent(studentId);
                            request.setAttribute("currentSite", "/dashboard");
                            request.setAttribute("totalClasses", totalClasses);
                            request.setAttribute("totalExams", totalExams);
                            request.setAttribute("totalPractices", totalPractices);
                            request.setAttribute("examStatistics", examStatisticsMap);
                        }
                    }
                    request.setAttribute("currentSite", "/dashboard");
                    request.getRequestDispatcher("/main/dashboard.jsp").forward(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(MainServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        final String ACTION = request.getServletPath();

        switch (ACTION) {
            case "/contact" -> {
                try {
                    contactAdmin(request, response);
                } catch (IOException ex) {
                    Logger.getLogger(MainServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "/login" -> {
                try {
                    login(request, response);
                } catch (IOException | ServletException ex) {
                    Logger.getLogger(MainServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "/register" -> {
                try {
                    register(request, response);
                } catch (IOException | ServletException ex) {
                    Logger.getLogger(MainServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "/reset-password" -> {
                try {
                    resetPassword(request, response);
                } catch (IOException | ServletException ex) {
                    Logger.getLogger(MainServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "/send-code" -> {
                try {
                    sendCode(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(MainServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "/validate-otp" -> {
                try {
                    validateOtp(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(MainServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    private void loginByGoogle(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String code = request.getParameter("code");
        String accessToken = getToken(code);
        GoogleUserDto user = getUserInfo(accessToken);

        User u = new User(user.getEmail());
        UserRepositoryImpl uri = UserRepositoryImpl.getInstance();
        boolean isDuplicated = false;
        List<User> users = uri.findAll();
        for (User us : users) {
            if (user.getEmail().equals(us.getEmail())) {
                isDuplicated = true;
                u = us;
                break;
            }
        }

        if (!isDuplicated) {
            uri.save(u);

        }
        response.sendRedirect("/main/login.jsp?isSuccessful=" + !isDuplicated);
    }

    private void contactAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        HttpSession session = request.getSession();
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        String resultMessage;

        if (!name.isEmpty() && !email.isEmpty() && !phone.isEmpty() && !message.isEmpty()
                && !name.isBlank() && !email.isBlank() && !phone.isBlank() && !message.isBlank()) {

            try {
                Long lastSentTime = (Long) session.getAttribute("lastSentTime");
                long currentTime = Instant.now().toEpochMilli();

                if (lastSentTime != null && (currentTime - lastSentTime < EMAIL_INTERVAL)) {
                    PrintWriter out = response.getWriter();
                    out.print("You can only send one email every 5 minutes. Please try again later.");
                    out.flush();
                    return;
                }

                session.setAttribute("lastSentTime", currentTime);
                sendEmail(name, email, phone, subject, message);
                resultMessage = "Thank you for your message!";
            } catch (IOException | MessagingException e) {
                resultMessage = "There was an error sending your message. Please try again later.";
            }
        } else {
            resultMessage = "Cannot send your message";
        }

        // Return the result message as JSON
        response.getWriter().write(resultMessage);

    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User u = userService.findByEmailToLogin(email, password);

        if (u != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", u);
            request.setAttribute("error", "");
            response.sendRedirect("/");
        } else {
            request.setAttribute("email", email);
            request.setAttribute("password", password);
            request.setAttribute("error", "Wrong credentials or your account has been disabled!");
            request.getRequestDispatcher("/main/login.jsp").include(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean isAfterChanging = request.getParameter("changed") != null;
        String actualUrl = isAfterChanging ? "?changed=successful" : "?logout=true";
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("/" + actualUrl);
    }

    private void register(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String fullName = request.getParameter("fullName").trim();
        String email = request.getParameter("email").trim();
        String rawPassword = request.getParameter("password").trim();
        String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt(12));
        String confirmPassword = request.getParameter("confirmPassword").trim();
        boolean hasError = false;

        if (fullName.isEmpty() || email.isEmpty() || rawPassword.isEmpty() || confirmPassword.isEmpty()) {
            setRequestAttributes(request, fullName, email, rawPassword, confirmPassword);
            request.setAttribute("error_empty", "Please do not leave this field blank!");
        }

        if (!UserValidation.isValidFullName(fullName)) {
            request.setAttribute("error_fullName", "Full name must be 6-30 characters long!");
            hasError = true;
        } else {
            request.setAttribute("error_fullName", "");
        }

        if (!UserValidation.isValidEmail(email)) {
            request.setAttribute("error_email", "Email must be in the form @gmail.com!");
            hasError = true;
        } else {
            request.setAttribute("error_email", "");
        }

        if (!confirmPassword.equals(rawPassword)) {
            request.setAttribute("error_confirmPassword", "Passwords do not match!");
            hasError = true;
        } else {
            request.setAttribute("error_confirmPassword", "");
        }

        if (!UserValidation.isPasswordStrong(rawPassword)) {
            request.setAttribute("error_password", "Passwords do not match!");
            hasError = true;
        } else {
            request.setAttribute("error_password", "");
        }
        
        if (hasError) {
            setRequestAttributes(request, fullName, email, rawPassword, confirmPassword);
            request.getRequestDispatcher("/main/register.jsp").forward(request, response);
            return;
        }

        UserRepositoryImpl uri = UserRepositoryImpl.getInstance();
        List<User> users = uri.findAll();
        for (User u : users) {
            if (u.getEmail().equals(email)) {
                request.setAttribute("error_email", "This email is already existed!");
                setRequestAttributes(request, fullName, email, rawPassword, confirmPassword);
                request.getRequestDispatcher("/main/register.jsp").forward(request, response);
                return;
            }
        }

        User u = new User(fullName, email, hashedPassword);
        User user = uri.save(u);
        if (user != null) {
            String token = UUID.randomUUID().toString();
            Token verificationToken = new Token();
            verificationToken.setUser(u);
            verificationToken.setToken(token);
            verificationToken.setExpiration(LocalDateTime.now().plusHours(1));

            TokenRepository tokenRepo = TokenRepository.getInstance();
            tokenRepo.saveToken(verificationToken);

            // Send verification email
            String verificationLink = "http://localhost:9999/register/verify?token=" + token;
            SendEmail.sendEmail("ttd21072004@gmail.com", email, "FPTU KRS",
                    "Here is your link to verify your email: " + verificationLink + "\nPlease keep in mind that this link will expire in one hour.");

            request.getRequestDispatcher("/main/verify-email.jsp").forward(request, response);
        } else {
            setRequestAttributes(request, fullName, email, rawPassword, confirmPassword);
            request.setAttribute("error", "Something went wrong!");
            request.getRequestDispatcher("/main/register.jsp").forward(request, response);
        }
    }

    private void resetPassword(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        String newPassword = request.getParameter("password");
        String confPassword = request.getParameter("confirmPassword");
        if (newPassword != null && confPassword != null && newPassword.equals(confPassword)) {

            try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(UserQueryConstant.RESET_PASSWORD)) {
                String encodedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt(12));
                ps.setString(1, encodedPassword);
                ps.setString(2, (String) session.getAttribute("email"));

                int rowCount = ps.executeUpdate();
                if (rowCount > 0) {
                    request.setAttribute("status", "resetSuccess");
                    response.sendRedirect("/main/login.jsp");
                } else {
                    request.setAttribute("status", "resetFailed");
                }
            } catch (SQLException e) {
                e.printStackTrace(System.err);
            }
        } else {
            request.setAttribute("message", "The 2 passwords do not match each other");
            request.getRequestDispatcher("/main/reset-password.jsp").include(request, response);
        }
    }

    private void sendCode(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        UserRepositoryImpl user = new UserRepositoryImpl();

        int otpvalue;
        HttpSession mySession = request.getSession();

        if (email != null && user.findByEmail2(email) != null) {
            // sending otp
            if (!email.isEmpty()) {
                Random rand = new Random();
                otpvalue = rand.nextInt(900000) + 100000;

                String to = email;// change accordingly
                // Get the session object
                Properties props = new Properties();
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                Session session = Session.getInstance(props, new Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication("ttd21072004@gmail.com", "nprg luav iglp rltu");
                    }
                });
                // compose message
                try {
                    MimeMessage message = new MimeMessage(session);
                    message.setFrom(new InternetAddress(email));// change accordingly
                    message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
                    message.setSubject("Hello");
                    message.setText("your OTP is: " + otpvalue);
                    // send message
                    Transport.send(message);
                } catch (MessagingException e) {
                    throw new RuntimeException(e);
                }
                request.setAttribute("message", "OTP is sent to your email");
                //request.setAttribute("connection", con);
                mySession.setAttribute("otp", otpvalue);
                mySession.setAttribute("email", email);
                request.getRequestDispatcher("/main/send-code.jsp").forward(request, response);
                //request.setAttribute("status", "success");
            }

        } else {
            mySession.setAttribute("message", "Your email does not match any account");
            request.getRequestDispatcher("/main/enter-email.jsp").forward(request, response);
        }
    }

    private void validateOtp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int value = Integer.parseInt(request.getParameter("otp"));
        HttpSession session = request.getSession();
        int otp = (int) session.getAttribute("otp");

        if (value == otp) {

            request.setAttribute("email", request.getParameter("email"));
            request.setAttribute("status", "success");
            request.setAttribute("message", "Successfully ! Now enter your new password");
            request.getRequestDispatcher("/main/reset-password.jsp").forward(request, response);

        } else {
            request.setAttribute("message", "Wrong OTP! Please check your OTP again.");
            request.getRequestDispatcher("/main/send-code.jsp").include(request, response);

        }

    }

    private void verify(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String token = request.getParameter("token");

        TokenRepository tokenRepo = TokenRepository.getInstance();
        Token verificationToken = tokenRepo.findToken(token);

        if (verificationToken != null && verificationToken.getExpiration().isAfter(LocalDateTime.now())) {
            UserRepositoryImpl uri = UserRepositoryImpl.getInstance();

            uri.save(verificationToken.getUser());
            tokenRepo.deleteToken(token);
            response.sendRedirect("/main/login.jsp?registered=true");
        } else {
            request.setAttribute("error", "Invalid or expired verification link.");
            request.getRequestDispatcher("/main/register.jsp").forward(request, response);
        }
    }

    private void sendEmail(String name, String email, String phone, String subject, String message) throws MessagingException {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SMTP_AUTH_USER, SMTP_AUTH_PWD);
            }
        });

        Message mimeMessage = new MimeMessage(session);
        mimeMessage.setFrom(new InternetAddress(SMTP_AUTH_USER));
        mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(SMTP_AUTH_USER));
        mimeMessage.setSubject(subject);
        mimeMessage.setText("Name: " + name + "\n" + "Email: " + email + "\n" + "Phone: " + phone + "\n" + "Message: " + message);

        Transport.send(mimeMessage);
    }

    private static String getToken(String code) throws ClientProtocolException, IOException {
        // call api to get token
        String response = Request.Post(IGoogleConnection.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", IGoogleConnection.GOOGLE_CLIENT_ID)
                        .add("client_secret", IGoogleConnection.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", IGoogleConnection.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", IGoogleConnection.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    private static GoogleUserDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = IGoogleConnection.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        GoogleUserDto googlePojo = new Gson().fromJson(response, GoogleUserDto.class);

        return googlePojo;
    }

    private void setRequestAttributes(HttpServletRequest request, String fullName, String email, String password, String confirmPassword) {
        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("password", password);
        request.setAttribute("confirmPassword", confirmPassword);
    }
}
