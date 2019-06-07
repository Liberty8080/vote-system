package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.sun.org.glassfish.gmbal.Description;
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



    public void updateVote(VoteTheme vote){
//        String sql =
    }



}
