package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import util.*;
import model.*;

/**
 * @author jacob
 */
public class UserDao {
    private dbUtil db = new dbUtil();

    /**
     * @return boolean
     * @Description 用户登录
     * @Param [username, password]
     **/
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

    /**
     * @return int
     * @Description 添加新用户
     * @Param [user]
     **/
    public int addUser(String name,String password) {
        String sql = "insert into user(name,password) values(?,?)";
        return db.executeSQL(sql, name, password);
    }


    /**
     * @return int 删除用户
     * @Description
     * @Param [userName]
     **/
    public int deleteUser(int id) {
        String sql = "delete from user where id = ? ";
        return db.executeSQL(sql, id);
    }


    /**
     * @return int
     * @Description 修改用户信息
     * @Param [user]
     **/
    public int updateUser(User user,int oldID) {
        String sql = "update user set id=?, name=? ,password=? where id = ?";
        return db.executeSQL(sql, user.getId(),user.getName(), user.getPassword(), oldID);
    }

    public List<User> findAllUser() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "select * from user";
        Connection conn = db.getConn();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            User u = new User();
            u.setId(rs.getInt("id"));
            u.setName(rs.getString("name"));
            u.setPassword(rs.getString("password"));
            users.add(u);
        }
        db.close(rs, ps, conn);
        return users;
    }


}
