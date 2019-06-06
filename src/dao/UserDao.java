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

    /**
     * @Description 向表中添加投票标题
     * @Param [vote]
     **/
    private void addTitle(VoteTheme vote) {
        String sql = "insert into voteTheme(theme,info) values(?,?)";
        db.executeSQL(sql, vote.getTheme(), vote.getInfo());
    }

    /**
     * @Description  查询投票标题
     * @Param [vote]
     * @return int
     **/
    private int findTitleId(VoteTheme vote) throws SQLException {
        String sql = "select id from voteTheme where theme = ?";
        int id = 0;
        Connection conn = db.getConn();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, vote.getTheme());
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            id = rs.getInt("id");
        }
        return id;
    }

    /**
     * @Description 查询投票标题后添加选项
     * @Param [vote, titleId]
     * @return void
     **/
    private void addOption(VoteTheme vote,int titleId) {
        List<String> options = vote.getOptions();
        String sql = "insert into voteOptions (voteItem,themeID) values(?,?)";
        for (String option : options) {
            db.executeSQL(sql, option, titleId);
        }
    }

    /**
     * @Description 添加投票,将各个步骤集中在一起
     * @Param [vote]
     * @return void
     **/
    public void addVote(VoteTheme vote) throws SQLException {
        addTitle(vote);
        int themeID = findTitleId(vote);
        addOption(vote,themeID);
    }

    public void updateVote(VoteTheme vote){
//        String sql =
    }

    public static void main(String[] args) throws SQLException {
        UserDao u = new UserDao();
        VoteTheme vote = new VoteTheme();
        vote.setInfo("这是info");
        vote.setTheme("这是主题2");
        List<String> options = new ArrayList<>();
        options.add("选项一");
        options.add("选项二");
        options.add("选项三");
        vote.setOptions(options);
    }


}
