package dao;

import model.VoteTheme;
import util.dbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class VoteDao {
    private dbUtil db  = new dbUtil();
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
}
