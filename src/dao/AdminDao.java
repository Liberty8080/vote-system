package dao;

import model.Admin;
import model.User;
import util.dbUtil;

import java.sql.*;

/**
 * @author jacob
 */
public class AdminDao {
    private dbUtil db = new dbUtil();


    public boolean login2(Admin admin) throws SQLException {
        boolean succeed = false;
        Connection conn = db.getConn();
        String sql = "select * from user where id = '1'";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        rs.next();
        String adminName = rs.getString("name");
        String password = rs.getString("password");
        if (adminName.equals(admin.getName()) & password.equals(admin.getPassword())) {
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
