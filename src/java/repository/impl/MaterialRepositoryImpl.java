package repository.impl;

import constant.MaterialQueryConstant;
import entity.Material;
import java.util.List;
import mysql.DatabaseConnection;
import repository.MaterialRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;
import static mapper.MaterialMapper.materialMapper;

public class MaterialRepositoryImpl implements MaterialRepository {

    private static final MaterialRepositoryImpl instance = new MaterialRepositoryImpl();

    private MaterialRepositoryImpl() {

    }

    public static MaterialRepositoryImpl getInstance() {
        return instance;
    }

    public List<Material> findByLesson(Long lessonId) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(MaterialQueryConstant.FIND_BY_LESSON)) {
            ps.setLong(1, lessonId);

            try (ResultSet rs = ps.executeQuery()) {
                List<Material> materials = new ArrayList();

                while (rs.next()) {
                    materials.add(materialMapper(rs));
                }
                
                return materials;
            } 
        } catch (SQLException ex) {
            Logger.getLogger(MaterialRepositoryImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return Collections.emptyList();
    }
}