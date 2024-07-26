/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package mapper;

import entity.Category;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CategoryMapper {

    public static Category categoryMapper(ResultSet rs) throws SQLException {
        return Category.builder()
                .id(rs.getLong("id"))
                .name(rs.getString("name"))
                .description(rs.getString("description"))
                .note(rs.getString("note"))
                .status(rs.getString("status"))
                .createdAt(rs.getDate("created_at").toLocalDate())
                .lastModifiedAt(rs.getDate("last_modified_at").toLocalDate())
                .createdBy(rs.getLong("created_by"))
                .lastModifiedBy(rs.getLong("last_modified_by"))
                .build();
    }
}
