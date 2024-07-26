package constant;

public interface IConnection {
    String HOST = "localhost";
    String PORT = "3306";
    String DATABASE = "swp391_sum24_se1808net_g5";
    String USERNAME = "root";
    String PASSWORD = "root";
    String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE;
}
