package repository;

import entity.Subject;
import java.util.List;

public interface SubjectRepository {
    List<Subject> findAll();
    List<Subject> findByCode(String code);
    Subject findById(Long id);
    Subject save(Subject s);
    boolean deleteById(Long id);
    List<Subject> findAll(int itemsPerPage, int currentPage);
}
