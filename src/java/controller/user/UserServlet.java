package controller.user;

import constant.EUserStatus;
import entity.Role;
import entity.Token;
import entity.User;
import jakarta.servlet.ServletContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.mindrot.jbcrypt.BCrypt;
import repository.impl.RoleRepositoryImpl;
import repository.impl.TokenRepository;
import service.impl.UserServiceImpl;
import static util.AttributeSet.checkAndSetAttribute;
import util.PasswordGenerator;
import util.SendEmail;

@WebServlet(name = "UserServlet", urlPatterns = {"/user", "/user/add", "/user/toggle", "/user/update",
    "/user/profile", "/user/change-password", "/user/verify-profile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class UserServlet extends HttpServlet {

    private final UserServiceImpl userService = UserServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String ACTION = request.getServletPath();
        switch (ACTION) {
            case "/user" -> {
                checkAndSetAttribute(request, "added", "successful");
                checkAndSetAttribute(request, "toggled", "successful", "failed");
                checkAndSetAttribute(request, "updated", "successful", "failed");
                request.setAttribute("currentSite", "/user");
                request.getRequestDispatcher("/user/all.jsp").forward(request, response);
            }
            case "/user/add" -> {
                request.setAttribute("currentSite", "/user/add");
                request.getRequestDispatcher("/user/add.jsp").forward(request, response);
            }
            case "/user/toggle" -> {
                toggleAnUser(request, response);
            }
            case "/user/profile" -> {
                request.setAttribute("currentSite", "/user/profile");
                request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
            }
            case "/user/change-password" -> {
                request.setAttribute("currentSite", "/user/change-password");
                request.getRequestDispatcher("/user/change-password.jsp").forward(request, response);
            }
            case "/user/verify-profile" -> {
                verifyProfile(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        final String ACTION = request.getServletPath();
        switch (ACTION) {
            case "/user/add" -> {
                saveAnUser(request, response);
            }
            case "/user/update" -> {
                updateAnUser(request, response);
            }
            case "/user/profile" -> {
                try {
                    updateProfile(request, response);
                } catch (IOException | ServletException ex) {
                    Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            case "/user/change-password" -> {
                try {
                    changePassword(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    private void toggleAnUser(HttpServletRequest request, HttpServletResponse response) {
        Long userId = Long.valueOf(request.getParameter("id"));

        try {
            boolean isToggled = userService.toggleById(userId);
            request.setAttribute("currentSite", "/user");
            if (isToggled) {
                response.sendRedirect("/user?toggled=successful");
            } else {
                response.sendRedirect("/user?toggled=failed");
            }
        } catch (NumberFormatException | IOException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void saveAnUser(HttpServletRequest request, HttpServletResponse response) {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        Long roleId = Long.valueOf(request.getParameter("role"));
        RoleRepositoryImpl rri = RoleRepositoryImpl.getInstance();
        Role role = rri.findById(roleId);
        EUserStatus userStatus = EUserStatus.valueOf(request.getParameter("status").toUpperCase());
        String phoneNumber = request.getParameter("phoneNumber");
        LocalDate dob = LocalDate.parse(request.getParameter("dob"));
        String rawPassword = PasswordGenerator.generatePassword();
        String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt(12));

        HttpSession session = request.getSession();
        User current = (User) session.getAttribute("user");
        Long createdById = current.getId();

        User u = userService.save(new User(fullName, email, phoneNumber, dob, hashedPassword, userStatus, role, createdById, createdById), request);
        if (u == null) {
            request.setAttribute("currentSite", "/user/add");
            try {
                request.getRequestDispatcher("/user/add.jsp").include(request, response);
            } catch (ServletException | IOException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            SendEmail.sendEmail("ttd21072004@gmail.com", email, "FPTU KRS",
                    "Your account has been verified by our administrator.\nYour password is: " + rawPassword + "\nWe recommend you to change the first-time password for security concerns.");
            request.setAttribute("errors", "");
            try {
                response.sendRedirect("/user?added=successful");
            } catch (IOException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private void updateAnUser(HttpServletRequest request, HttpServletResponse response) {
        Long id = Long.valueOf(request.getParameter("id"));
        User toUpdate = userService.findById(id);

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        LocalDate dob = LocalDate.parse(request.getParameter("dob"));
        String note = request.getParameter("note");

        RoleRepositoryImpl rri = RoleRepositoryImpl.getInstance();
        Role role = rri.findById(Long.valueOf(request.getParameter("role")));

        Part filePart = null;
        try {
            filePart = request.getPart("updated-avatar-" + id);
        } catch (IOException | ServletException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (filePart != null) {
            String fileName = filePart.getSubmittedFileName();
            if (filePart.getSize() > 0) {
                ServletContext servletContext = request.getServletContext();

                String relativePath = "assets/images/" + fileName;
                String avatarPath = servletContext.getRealPath(relativePath);

                String correctedPath = avatarPath.replace(File.separator + "build", "");

                try (InputStream inputStream = filePart.getInputStream(); FileOutputStream outputStream = new FileOutputStream(correctedPath)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                } catch (Exception e) {
                    e.printStackTrace(System.out);
                }

                toUpdate.setAvatar(fileName);
            }
        }

        toUpdate.setFullName(fullName);
        toUpdate.setEmail(email);
        toUpdate.setPhoneNumber(phoneNumber);
        toUpdate.setDob(dob);
        toUpdate.setRole(role);
        toUpdate.setNote(note);

        User u = userService.save(toUpdate, request);

        if (u != null) {
            try {
                response.sendRedirect("/user?updated=successful");
            } catch (IOException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                response.sendRedirect("/user?updated=failed");
            } catch (IOException ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        User current = (User) session.getAttribute("user");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        boolean isUpdatingEmail = current.getEmail().equals(email);
        String phoneNumber = request.getParameter("phoneNumber");
        LocalDate dob = LocalDate.parse(request.getParameter("dob"));

        String fileName = current.getAvatar();
        Part filePart = request.getPart("updated-avatar");
        if (filePart != null) {
            fileName = filePart.getSubmittedFileName();
            if (filePart.getSize() > 0) {
                ServletContext servletContext = request.getServletContext();

                String relativePath = "assets/images/" + fileName;
                String avatarPath = servletContext.getRealPath(relativePath);

                String correctedPath = avatarPath.replace(File.separator + "build", "");

                try (InputStream inputStream = filePart.getInputStream(); FileOutputStream outputStream = new FileOutputStream(correctedPath)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                } catch (Exception e) {
                    e.printStackTrace(System.out);
                }

            }
        }

        Long currentUserId = current.getId();

        User toUpdate = new User(currentUserId, fullName, email, phoneNumber, dob, current.getPassword(), current.getNote(),
                fileName, current.getCreatedAt(), LocalDate.now(), current.getCreatedById(), current.getLastModifiedById(),
                current.getUserStatus(), current.getRole());

        if (isUpdatingEmail) {
            User u = userService.save(toUpdate, request);

            if (u != null) {
                current.setAvatar(fileName);
                current.setFullName(fullName);
                current.setEmail(email);
                current.setPhoneNumber(phoneNumber);
                current.setDob(dob);
                current.setLastModifiedById(currentUserId);
                current.setLastModifiedAt(LocalDate.now());
                response.sendRedirect("/user/profile.jsp?updated=successful");
            } else {
                request.setAttribute("currentSite", "/user/profile");
                request.getRequestDispatcher("/user/profile.jsp").include(request, response);
            }
        } else {
            String token = UUID.randomUUID().toString();
            Token verificationToken = new Token();
            verificationToken.setUser(toUpdate);
            verificationToken.setToken(token);
            verificationToken.setExpiration(LocalDateTime.now().plusHours(1));

            TokenRepository tokenRepo = TokenRepository.getInstance();
            tokenRepo.saveToken(verificationToken);

            // Send verification email
            String verificationLink = "http://localhost:9999/user/verify-profile?token=" + token;
            SendEmail.sendEmail("ttd21072004@gmail.com", email, "FPTU KRS",
                    "We receive a request to update email. If this is not you, please contact us immediately.\nClick here to verify: " + verificationLink + "\nPlease keep in mind that this link will expire in one hour, and after you click this, your email will be changed instantly.");

            response.sendRedirect("/user?updation=pending");
        }

    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        String oldPass = request.getParameter("oldPass");
        String newPass = request.getParameter("newPass");
        String confirmPass = request.getParameter("confirmPass");

        boolean isPasswordChanged = userService.findByEmailToChangePassword(currentUser, oldPass,
                newPass, confirmPass, request);
        if (isPasswordChanged) {
            response.sendRedirect("/logout?changed=successful");
        } else {
            request.setAttribute("currentSite", "/user/change-password");
            request.getRequestDispatcher("/user/change-password.jsp").include(request, response);
        }
    }

    private void verifyProfile(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        User current = (User) session.getAttribute("user");
        String token = request.getParameter("token");

        TokenRepository tokenRepo = TokenRepository.getInstance();
        Token verificationToken = tokenRepo.findToken(token);

        User toUpdate = verificationToken.getUser();

        if (verificationToken != null && verificationToken.getExpiration().isAfter(LocalDateTime.now())) {
            userService.save(toUpdate, request);
            current.setAvatar(toUpdate.getAvatar());
            current.setFullName(toUpdate.getFullName());
            current.setEmail(toUpdate.getEmail());
            current.setPhoneNumber(toUpdate.getPhoneNumber());
            current.setDob(toUpdate.getDob());
            current.setLastModifiedById(toUpdate.getLastModifiedById());
            current.setLastModifiedAt(LocalDate.now());
            tokenRepo.deleteToken(token);
            response.sendRedirect("/user?updation=successful");
        } else {
            response.sendRedirect("/user?updation=failed");
        }
    }
}
