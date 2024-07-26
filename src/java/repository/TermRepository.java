package repository;

import entity.Term;
import java.util.List;

public interface TermRepository {
    List<Term> findAll();
    Term findById(Long id);
}
