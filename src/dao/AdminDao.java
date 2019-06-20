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


    public boolean login(String username,String password) throws SQLException {
        Connection conn = db.getConn();
        String sql = "select * from admin where name=? and password=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,username);
        ps.setString(2,password);
        ResultSet rs = ps.executeQuery();
       return rs.next();
    }




}
