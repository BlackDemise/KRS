package mapper;

import entity.Material;
import java.sql.ResultSet;
import java.sql.SQLException;
import service.impl.LessonServiceImpl;

public class MaterialMapper {
    public static Material materialMapper(ResultSet rs) throws SQLException {
        LessonServiceImpl lessonService = LessonServiceImpl.getInstance();
        
        return Material.builder()
                .materialId(rs.getLong("material_id"))
                .materialName(rs.getString("material_name"))
                .materialDescription(rs.getString("material_description"))
                .lesson(lessonService.findById(rs.getLong("lesson_id")))
                .build();
    }
}
