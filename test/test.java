import dao.VoteDao;
import model.VoteTheme;
import org.junit.Test;

import java.sql.SQLException;
import java.util.*;

public class test {

    @Test
    public void testAddvote() throws SQLException {
        VoteDao vd = new VoteDao();
        VoteTheme vote = new VoteTheme();
        vote.setTheme("测试三主题");
        vote.setInfo("描述漫画");
        Map<String,Integer> options = new HashMap<>();
        options.put("1",1);
        options.put("2",2);        options.put("3",3);

        options.put("4",4);
        vote.setOptions(options);
        //执行
        vd.addVote(vote);
        }


    @Test
    public void testFindVoteTheme() throws SQLException {
        VoteDao vd = new VoteDao();
        VoteTheme vote2 = new VoteTheme();
        vote2.setTheme("测试三主题");
        vote2 = vd.findVoteByTheme(vote2);
        Map<String,Integer> options = vote2.getOptions();
        System.out.println(vote2.getTheme()+vote2.getId()+vote2.getInfo());
        Set<String> set=options.keySet();
        for (String key : set) {
            Integer value = options.get(key);
            System.out.println(key + ":" + value);
        }
    }

    @Test
    public void testFindAllVote() throws SQLException {
        VoteDao vd = new VoteDao();
        vd.findAllVote();
    }
    }



