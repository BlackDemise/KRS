package entity;

import constant.EUserStatus;
import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.mindrot.jbcrypt.BCrypt;
import repository.impl.RoleRepositoryImpl;

@Getter
@Setter
@AllArgsConstructor
@ToString
public class User {

    private Long id;
    private String fullName;
    private String email;
    private String phoneNumber;
    private LocalDate dob;
    private String password;
    private String note;
    private String avatar;
    private LocalDate createdAt;
    private LocalDate lastModifiedAt;
    private Long createdById;
    private Long lastModifiedById;
    private EUserStatus userStatus;
    private Role role;

    // Constructor for adding a student from Excel
    public User(String fullName, String email) {
        this.fullName = fullName;
        this.email = email;
        this.password = BCrypt.hashpw("default_password", BCrypt.gensalt(12));
        this.createdAt = LocalDate.now();
        this.lastModifiedAt = LocalDate.now();
        this.userStatus = EUserStatus.ACTIVE;
        this.role = RoleRepositoryImpl.getInstance().findById(5L); // Assume 5L is the role ID for students
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
        this.createdAt = LocalDate.now();
        // default last modified time
        this.lastModifiedAt = LocalDate.now();
        // default status
        this.userStatus = EUserStatus.ACTIVE;
        // default role
        RoleRepositoryImpl rri = RoleRepositoryImpl.getInstance();
        Role r = rri.findById(5L);
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
        this.createdAt = LocalDate.now();
        // default last modified time
        this.lastModifiedAt = LocalDate.now();
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
        this.createdAt = LocalDate.now();
        // default last modified time
        this.lastModifiedAt = LocalDate.now();
        this.createdById = -1L;
        this.lastModifiedById = -1L;
        // default status
        this.dob = LocalDate.now();
        this.phoneNumber = "1234567890";
        this.userStatus = EUserStatus.ACTIVE;

        RoleRepositoryImpl rri = RoleRepositoryImpl.getInstance();
        Role r = rri.findById(5L);
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
