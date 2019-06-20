package dao;

import model.VoteOption;
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
     * @return int
     * @Description 查询投票标题
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
     * @return java.util.Map<java.lang.String, java.lang.Integer>
     * @Description 查找投票主题对应的选项
     * @Param [id]
     **/
    private Map<String, Integer> findOptions(int id) throws SQLException {
        Map<String, Integer> options = new LinkedHashMap<>(4);
        String sql = "select * from voteOptions where themeID = ?";
        Connection conn = db.getConn();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String item = rs.getString("voteItem");
            int count = rs.getInt("count");
            options.put(item, count);
        }
        return options;
    }

    /**
     * @return void
     * @Description 查询投票标题后添加选项
     * @Param [vote, titleId]
     **/
    private void addOption(VoteTheme vote, int titleId) {
        Map<String, Integer> options = vote.getOptions();
        String sql = "insert into voteOptions (voteItem,themeID,count) values(?,?,?)";
        Set<String> set = options.keySet();
        for (String key : set) {
            Integer value = options.get(key);
            db.executeSQL(sql, key, titleId, value);
        }
    }

    /**
     * @return void
     * @Description 添加投票, 将各个步骤集中在一起
     * @Param [vote]
     **/
    public void addVote(VoteTheme vote) throws SQLException {
        addTitle(vote);
        addOption(vote, findTitleId(vote));
    }

    /**
     * @return void
     * @Description 通过主题查询投票
     * @Param []
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


    public List<Integer> findOptionID(int themeID) throws SQLException {
        List<Integer> id = new LinkedList<>();
        String sql="select * from voteOptions where themeID = ?";
        Connection conn = db.getConn();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, themeID);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            id.add(rs.getInt("optionID"));
        }
        return id;
    }


    /**
     * @return model.VoteTheme
     * @Description 通过id查询投票
     * @Param [id]
     **/
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
            votetheme.setCensor(rs.getInt("censor"));
        }
        rs.close();
        ps.close();
        conn.close();
        return votetheme;
    }


    /**
     * @return java.util.List<model.VoteTheme>
     * @Description 查询现有所有投票
     * @Param []
     **/
    public List<VoteTheme> findAllVote() throws SQLException {
        List<VoteTheme> voteThemes = new ArrayList<>();
        String sql = "select * from voteTheme";
        Connection conn = db.getConn();
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            VoteTheme votetheme = new VoteTheme();
            votetheme.setId(rs.getInt("id"));
            votetheme.setInfo(rs.getString("info"));
            votetheme.setTheme(rs.getString("theme"));
            votetheme.setOptions(findOptions(votetheme.getId()));
            votetheme.setCensor(rs.getInt("censor"));
            votetheme.setAllOptions(findOptionBythemeID(rs.getInt("id")));
            voteThemes.add(votetheme);
        }
        rs.close();
        ps.close();
        conn.close();
        return voteThemes;
    }

    public List<VoteOption> findOptionBythemeID(int themeID) throws SQLException {
        List<VoteOption> opList = new LinkedList<>();
        String sql="select * from voteOptions where themeID = ?";
        Connection conn = db.getConn();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, themeID);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            VoteOption option = new VoteOption();
            option.setOptionId(rs.getInt("optionID"));
            option.setCount(rs.getInt("count"));
            option.setVoteItem(rs.getString("voteItem"));
            option.setThemeId(rs.getInt("themeID"));
            opList.add(option);
        }
        db.close(rs,ps,conn);
        return opList;
    }

    /**
     * @Description 修改vote
     * @Param
     **/
    public void updateVote(VoteTheme v) {
        List<VoteOption> options = v.getAllOptions();
        String sql = "update voteTheme set theme=?, info =?, censor= ?  where id = ?";
        String sql2 = "update voteOptions set voteItem=?, count=? where OptionID = ?";
        db.executeSQL(sql, v.getTheme(), v.getInfo(), v.getCensor(), v.getId());
        for(VoteOption o:options){
            db.executeSQL(sql2,o.getVoteItem(),o.getCount(),o.getOptionId());
        }

    }


    /**
     * @return void
     * @Description 增加投票数
     * @Param [themeid, option, count]
     **/
    public void addCount(int themeid, String option, int count) {
        String sql = "update voteOptions set count = ? where voteItem = ? and themeID = ?";
        db.executeSQL(sql, count, option, themeid);
    }


    /**
     * @return void
     * @Description 删除投票
     * @Param [id]
     **/
    public void deleteVote(int id) {
        String sql = "delete from voteTheme where id = ?";
        db.executeSQL(sql, id);
    }

    public void censor(int themeID){
        String sql = "update voteTheme set  censor= 1  where id = ?";
        db.executeSQL(sql,themeID);
    }


}
