package repository;

import entity.User;
import java.util.List;

public interface UserRepository {

    List<User> findAll(int page, int offset, String searchQuery);

    User findById(Long id);

    User findByEmail(String email, String password);

    User save(User u);

    boolean toggleById(Long id);
    
    User findByEmail2(String email);
}
