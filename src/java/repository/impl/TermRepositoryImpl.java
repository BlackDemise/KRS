package repository.impl;

import constant.ITermQuery;
import entity.Term;
import entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import static mapper.TermMapper.termMapper;
import static mapper.UserMapper.userMapper;
import mysql.DatabaseConnection;
import repository.TermRepository;
import constant.UserQueryConstant;

public class TermRepositoryImpl implements TermRepository {

    private static final TermRepositoryImpl instance = new TermRepositoryImpl();

    private TermRepositoryImpl() {
    }

    public static TermRepositoryImpl getInstance() {
        return instance;
    }

    @Override
    public List<Term> findAll() {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ITermQuery.FIND_ALL); ResultSet rs = ps.executeQuery()) {

            List<Term> terms = new ArrayList<>();

            while (rs.next()) {
                terms.add(termMapper(rs));
            }

            return terms;
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return Collections.emptyList();
    }

    @Override
    public Term findById(Long id) {
        try (Connection c = DatabaseConnection.getConnection(); PreparedStatement ps = c.prepareStatement(ITermQuery.FIND_BY_ID)) {

            ps.setLong(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return termMapper(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace(System.err);
        }
        return null;
    }

}
