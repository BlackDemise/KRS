// PLEASE MODIFY constant/IConnection.java TO CHANGE CONNECTION SETTINGS.

package mysql;

import java.sql.Connection;
import java.sql.DriverManager;
import constant.IConnection;
import java.sql.SQLException;

public class DatabaseConnection {
    public static Connection getConnection() {
        try {
           Class.forName("com.mysql.cj.jdbc.Driver");
           return DriverManager.getConnection(IConnection.URL,
                                             IConnection.USERNAME,
                                          IConnection.PASSWORD); 
        } catch (ClassNotFoundException | SQLException e) {
            return null;
        }
    }
}
