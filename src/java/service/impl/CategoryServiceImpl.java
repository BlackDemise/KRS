
package service.impl;

import entity.Category;
import java.util.List;
import repository.impl.CategoryRepositoryImpl;
import service.CategoryService;

public class CategoryServiceImpl implements CategoryService {

    private static final CategoryServiceImpl instance = new CategoryServiceImpl();

    public CategoryServiceImpl() {
    }

    public static CategoryServiceImpl getInstance() {
        return instance;
    }

    private final CategoryRepositoryImpl categoryRepository = CategoryRepositoryImpl.getInstance();

    public List<Category> findAll() {
        return categoryRepository.findAll();
    }
   
    public Category findById(Long id){
        return categoryRepository.findById(id);
    }
}
