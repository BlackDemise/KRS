package service.impl;

import entity.Material;
import java.util.List;
import repository.impl.MaterialRepositoryImpl;
import service.MaterialService;

public class MaterialServiceImpl implements MaterialService {

    private final MaterialRepositoryImpl materialRepository = MaterialRepositoryImpl.getInstance();
    
    private static final MaterialServiceImpl instance = new MaterialServiceImpl();
    
    private MaterialServiceImpl() {
        
    }
    
    public static MaterialServiceImpl getInstance() {
        return instance;
    }
    
    public List<Material> findByLesson(Long lessonId) {
        return materialRepository.findByLesson(lessonId);
    }
}
