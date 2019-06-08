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
        String sql = "select * from admin where id = '1'";
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




}
