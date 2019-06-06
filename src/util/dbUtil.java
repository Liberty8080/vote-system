package util;

import java.sql.*;

public class dbUtil {
    // 数据库的用户名与密码，需要根据自己的设置

    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/votesystem?useUnicode=true&characterEncoding=utf-8&useSSL=false";
    private static final String USER = "root";
    private static final String PASS = "jacob@123";

    //获取数据库连接

    public Connection getConn() {
        Connection conn = null;
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    public void close(ResultSet rs, PreparedStatement ps, Connection conn) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    public void close(PreparedStatement ps, Connection conn) {
        this.close(null, ps, conn);
    }

    //增删改

    public int executeSQL(String sql, Object... args) {
        Connection conn = getConn();
        PreparedStatement ps = null;
        int rows = 0;
        try {
            ps = conn.prepareStatement(sql);
            //★注意下面的循环语句★
            for (int i = 0; i < args.length; i++) {
                ps.setObject(i + 1, args[i]);
            }
            rows = ps.executeUpdate();
            if (rows > 0) {
                System.out.println("operate successfully !");
            } else {
                System.out.println("fail!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.close(ps, conn);
        }
        return rows;
    }

}
