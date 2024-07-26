package repository.impl;

import constant.EUserRole;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import entity.Role;
import mysql.DatabaseConnection;
import repository.RoleRepository;
import constant.IRoleQuery;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import static mapper.RoleMapper.roleMapper;

public class RoleRepositoryImpl implements RoleRepository {

    private static final RoleRepositoryImpl instance = new RoleRepositoryImpl();

    private RoleRepositoryImpl() {
    }

    public static RoleRepositoryImpl getInstance() {
        return instance;
    }

    @Override
    public Role findById(Long id) {
        try (Connection c = DatabaseConnection.getConnection();
                PreparedStatement ps = c.prepareStatement(IRoleQuery.FIND_BY_ID)) {
            ps.setLong(1, id);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return roleMapper(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

    @Override
    public List<Role> findAll() {
        try (Connection c = DatabaseConnection.getConnection();
                PreparedStatement ps = c.prepareStatement(IRoleQuery.FIND_ALL)) {
            ps.setString(1, EUserRole.ROLE_ADMINISTRATOR.name());
            
            ResultSet rs = ps.executeQuery();
            
            List<Role> roles = new ArrayList();
            while (rs.next()) {
                roles.add(roleMapper(rs));
            }
            return roles;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    @Override
    public Role findByTitle(String title) {
        try (Connection c = DatabaseConnection.getConnection();
                PreparedStatement ps = c.prepareStatement(IRoleQuery.FIND_BY_TITLE)) {
            ps.setString(1, title);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return roleMapper(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

}
