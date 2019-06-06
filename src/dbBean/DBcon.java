package dbBean;

import java.sql.*;

import static java.lang.Class.forName;

/**
 * @author jacob
 */
public class DBcon {
    public static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    public static final String DB_URL = "jdbc:mysql://localhost:3306/votesystem?useUnicode=true&characterEncoding=utf-8&useSSL=false";

    // 数据库的用户名与密码，需要根据自己的设置

    public static final String USER = "root";
    public static final String PASS = "jacob@123";


    public Connection conn = null;
    public Statement stmt = null;

    public DBcon() {
        try {
            Class.forName(JDBC_DRIVER);
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }



    //执行查询

    public ResultSet executeQuery(String sql) {
        ResultSet rs = null;
        try {
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            System.out.println(DB_URL+USER+PASS);
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
        } catch (SQLException se) {
            se.printStackTrace();
        }
        return rs;
    }

    public int executeUpdate(String sql) {
        int result = 0;
        try {
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();
            result = stmt.executeUpdate(sql);
        } catch (SQLException se) {
            se.printStackTrace();
        }
        return result;
    }

    public void close() {
        try {
            stmt.close();
            conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }

    public static void main(String[] args) {
        DBcon test = new DBcon();
        int id;
        int count;
        String item;
        String sql = "SELECT * FROM vote";
        try {
            ResultSet result = test.executeQuery(sql);
            while (result.next()) {
                id = result.getInt("id");
                item = result.getString("item");
                count = result.getInt("count");

                System.out.println("id为" + id);
                System.out.println("内容为:" + item);
                System.out.println("目前已投票人数为" + count);
            }
        } catch (SQLException se) {
            se.printStackTrace();
        }
    }

}
