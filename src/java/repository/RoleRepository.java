package repository;

import entity.Role;
import java.util.List;

public interface RoleRepository {
    List<Role> findAll();
    Role findByTitle(String title);
    Role findById(Long id);
}
