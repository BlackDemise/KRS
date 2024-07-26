package repository.impl;

import entity.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mysql.DatabaseConnection;
import repository.CategoryRepository;
import mapper.CategoryMapper;

public class CategoryRepositoryImpl implements CategoryRepository {

    private static final CategoryRepositoryImpl instance = new CategoryRepositoryImpl();

    private CategoryRepositoryImpl() {
    }

    public static CategoryRepositoryImpl getInstance() {
        return instance;
    }

    public Category findById(Long id) {
        try (Connection c = DatabaseConnection.getConnection(); 
             PreparedStatement ps = c.prepareStatement("SELECT * FROM category WHERE id = ?")) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return CategoryMapper.categoryMapper(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    public List<Category> findAll() {
        try (Connection c = DatabaseConnection.getConnection(); 
             PreparedStatement ps = c.prepareStatement("SELECT * FROM category"); 
             ResultSet rs = ps.executeQuery()) {
            List<Category> categories = new ArrayList<>();
            while (rs.next()) {
                categories.add(CategoryMapper.categoryMapper(rs));
            }
            return categories;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return new ArrayList<>();
    }
}
