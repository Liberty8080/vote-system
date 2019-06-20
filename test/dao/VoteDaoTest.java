package dao;

import model.VoteOption;
import model.VoteTheme;
import org.junit.Test;
import util.dbUtil;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.*;

public class VoteDaoTest {
    VoteDao vd = new VoteDao();

    @Test
    public void deleteVote() {
        vd.deleteVote(21);
    }

    @Test
    public void updateVote() {
        VoteTheme v = new VoteTheme();

        v.setTheme("222");
        v.setInfo("info");
        v.setId(19);
        v.setCensor(1);
        vd.updateVote(v);


    }

    @Test
    public void updateOptions() {
        dbUtil db = new dbUtil();
        String sql2 = "update voteOptions set voteItem=?, count=? where OptionID = ?";
        VoteOption o = new VoteOption();
        o.setCount(2);
        o.setOptionId(44);
        o.setVoteItem("update测试");

        db.executeSQL(sql2,o.getVoteItem(),o.getCount(),o.getOptionId());

    }

    @Test
    public void findOptionID() throws SQLException {
        List<Integer> list = vd.findOptionID(15);
        System.out.println();
    }

    @Test
    public void findOptionBythemeID() throws SQLException {
       List<VoteOption> list= vd.findOptionBythemeID(15);
        System.out.println();
    }

    @Test
    public void findallVote() throws SQLException {
        List<VoteTheme> v = vd.findAllVote();
        System.out.println();
    }
}