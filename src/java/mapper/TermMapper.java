package mapper;

import entity.Term;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TermMapper {
    public static Term termMapper(ResultSet rs) throws SQLException {
        return new Term(rs.getLong("term_id"),
                          rs.getString("name"));
    }
}
