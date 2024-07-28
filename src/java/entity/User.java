package entity;

import constant.EUserStatus;
import java.time.LocalDate;
import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.mindrot.jbcrypt.BCrypt;
import repository.impl.RoleRepositoryImpl;

@Getter
@Setter
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class User {

    private Long id;
    private String fullName;
    private String email;
    private String phoneNumber;
    private LocalDate dob;
    private String password;
    private String note;
    private String avatar;
    private LocalDateTime createdAt;
    private LocalDateTime lastModifiedAt;
    private Long createdById;
    private Long lastModifiedById;
    private EUserStatus userStatus;
    private Role role;

    // Constructor for adding a student from Excel
    public User(String fullName, String email) {
        this.fullName = fullName;
        this.email = email;
        this.password = BCrypt.hashpw("default_password", BCrypt.gensalt(12));
        this.createdAt = LocalDateTime.now();
        this.lastModifiedAt = LocalDateTime.now();
        this.userStatus = EUserStatus.ACTIVE;
        this.role = RoleRepositoryImpl.getInstance().findById(4L); // Assume 4L is the role ID for students
    }

    // For Google login
    public User(String email) {
        // id is auto_increment
        // default full name
        this.fullName = "defaultuser";
        this.email = email;
        // default password
        this.password = BCrypt.hashpw("12345678", BCrypt.gensalt(12));
        // default note
        this.note = "None";
        // default avatar
        this.avatar = "default_avatar.png";
        // default created time
        this.createdAt = LocalDateTime.now();
        // default last modified time
        this.lastModifiedAt = LocalDateTime.now();
        // default status
        this.userStatus = EUserStatus.ACTIVE;
        // default role
        RoleRepositoryImpl rri = RoleRepositoryImpl.getInstance();
        Role r = rri.findById(4L);
        this.role = r;
    }

    // For add user function of administrator
    public User(String fullName, String email, String phoneNumber, LocalDate dob, String password, EUserStatus userStatus, Role role,
            Long createdById, Long lastModifiedById) {
        // id is auto_increment
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.dob = dob;
        this.password = password;
        // default note
        this.note = "None";
        // default avatar
        this.avatar = "default_avatar.png";
        // default created time
        this.createdAt = LocalDateTime.now();
        // default last modified time
        this.lastModifiedAt = LocalDateTime.now();
        this.createdById = createdById;
        this.lastModifiedById = lastModifiedById;
        this.userStatus = userStatus;
        this.role = role;
    }

    // For user register function
    public User(String fullName, String email, String password) {
        // id is auto_increment
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        // default note
        this.note = "None";
        // default avatar
        this.avatar = "default_avatar.png";
        // default created time
        this.createdAt = LocalDateTime.now();
        // default last modified time
        this.lastModifiedAt = LocalDateTime.now();
        this.createdById = -1L;
        this.lastModifiedById = -1L;
        // default status
        this.dob = LocalDate.now();
        this.phoneNumber = "0912345678";
        this.userStatus = EUserStatus.ACTIVE;

        RoleRepositoryImpl rri = RoleRepositoryImpl.getInstance();
        Role r = rri.findById(4L);
        this.role = r;
    }

    public User(Long id, String email, String note, EUserStatus userStatus, Role role) {
        this.id = id;
        this.email = email;
        this.note = note;
        // default avatar
        this.avatar = "default_avatar.png";
        this.userStatus = userStatus;
        this.role = role;
    }

}
