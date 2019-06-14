package dao;

import model.VoteTheme;
import util.dbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

/**
 * @author jacob
 */
public class VoteDao {
    private dbUtil db = new dbUtil();

    /**
     * @Description 向表中添加投票标题
     * @Param [vote]
     **/
    private void addTitle(VoteTheme vote) {
        String sql = "insert into voteTheme(theme,info) values(?,?)";
        db.executeSQL(sql, vote.getTheme(), vote.getInfo());
    }

    /**
     * @Description 查询投票标题
     * @return int
     * @Param [vote]
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
        conn.close();
        ps.close();
        rs.close();
        return id;
    }

    /**
     * @Description 查找投票主题对应的选项
     * @Param [id]
     * @return java.util.Map<java.lang.String,java.lang.Integer>
     **/
    private Map<String,Integer> findOptions(int id) throws SQLException{
        Map<String,Integer> options = new LinkedHashMap<>(4);
        String sql = "select * from voteOptions where themeID = ?";
        Connection conn = db.getConn();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1,id);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            String item = rs.getString("voteItem");
            int count = rs.getInt("count");
            options.put(item,count);
        }
        return options;
    }

    /**
     * @Description 查询投票标题后添加选项
     * @return void
     * @Param [vote, titleId]
     **/
    private void addOption(VoteTheme vote, int titleId) {
        Map<String,Integer> options = vote.getOptions();
        String sql = "insert into voteOptions (voteItem,themeID,count) values(?,?,?)";
        Set<String> set = options.keySet();
        for (String key : set) {
            Integer value = options.get(key);
            db.executeSQL(sql, key, titleId, value);
        }
    }

    /**
     * @Description 添加投票, 将各个步骤集中在一起
     * @return void
     * @Param [vote]
     **/
    public void addVote(VoteTheme vote) throws SQLException {
        addTitle(vote);
        addOption(vote, findTitleId(vote));
    }

    /**
     * @Description  查询vote
     * @Param []
     * @return void
     **/
    public VoteTheme findVoteByTheme(VoteTheme vote) throws SQLException {
        String sql = "select * from voteTheme where theme = ?";
        VoteTheme votetheme = new VoteTheme();
        Connection conn = db.getConn();

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, vote.getTheme());
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            votetheme.setId(rs.getInt("id"));
            votetheme.setTheme(rs.getString("theme"));
            votetheme.setInfo(rs.getString("info"));
            System.out.println(votetheme.getId());
            votetheme.setOptions(findOptions(votetheme.getId()));
        }
        rs.close();
        ps.close();
        conn.close();
        return votetheme;
    }

    public VoteTheme findVoteById(int id) throws SQLException {
        String sql = "select * from voteTheme where id = ?";
        VoteTheme votetheme = new VoteTheme();
        Connection conn = db.getConn();

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            votetheme.setId(rs.getInt("id"));
            votetheme.setTheme(rs.getString("theme"));
            votetheme.setInfo(rs.getString("info"));
            votetheme.setOptions(findOptions(votetheme.getId()));
        }
        rs.close();
        ps.close();
        conn.close();
        return votetheme;
    }

    public List<VoteTheme> findAllVote() throws SQLException {
        List<VoteTheme> voteThemes = new ArrayList<>();
        String sql = "select * from voteTheme";
        Connection conn = db.getConn();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            VoteTheme votetheme = new VoteTheme();
            votetheme.setId(rs.getInt("id"));
            votetheme.setInfo(rs.getString("info"));
            votetheme.setTheme(rs.getString("theme"));
            votetheme.setOptions(findOptions(votetheme.getId()));
            voteThemes.add(votetheme);
        }
        rs.close();
        ps.close();
        conn.close();
        return voteThemes;
    }

    /**
     * @Description 修改vote
     * @Param
     **/
    public void updateVote(){

    }

    public void addCount(int themeid,String option,int count){
        String sql = "update voteOptions set count = ? where voteItem = ? and themeID = ?";
        db.executeSQL(sql,count,option,themeid);
    }
}
