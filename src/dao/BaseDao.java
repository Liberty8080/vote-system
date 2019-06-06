package dao;

import java.sql.Connection;
import java.sql.SQLException;

import util.*;
/**
 * @author jacob
 */
public class BaseDao {

    public Connection conn = new dbUtil().getConn();

    public void closeDao()throws SQLException {
        conn.close();
    }
}
