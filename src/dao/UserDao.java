package dao;

import java.sql.*;
import util.*;
import model.*;

/**
 * @author jacob
 */
public class UserDao {
    private dbUtil db = new dbUtil();

    public boolean login(String username, String password) throws SQLException {
        boolean succeed = false;
        Connection conn = db.getConn();
        String sql = "select * from user where name =? and password = ?";
        //这里不改
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            succeed = true;
        }
        db.close(rs, ps, conn);
        return succeed;
    }

    public int addUser(User user) {
        String sql = "insert into user(name,password) values(?,?)";
        return db.executeSQL(sql, user.getName(), user.getPassword());
    }

    //删除用户

    public int deleteUser(User user) {
        String sql = "delete from user where name = ? and id = ?";
        return db.executeSQL(sql, user.getName(), user.getId());
    }

    //修改用户信息

    public int updateUser(User user) {
        String sql = "update user set name=? where id = ?";
        return db.executeSQL(sql, user.getName(), user.getId());
    }





}
