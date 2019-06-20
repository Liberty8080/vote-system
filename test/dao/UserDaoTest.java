package dao;

import model.User;
import org.junit.Test;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

public class UserDaoTest {
    UserDao ud = new UserDao();

    @Test
    public void login() {
    }

    @Test
    public void addUser() {
        User u = new User();
        u.setName("张三");
        u.setPassword("123456");
    }

    @Test
    public void deleteUser() {
        ud.deleteUser(3);
    }

    @Test
    public void updateUser() {
        User u = new User();
        u.setId(3);
        u.setName("王五");
        u.setPassword("123456");
        ud.updateUser(u,6);
    }

    @Test
    public void findAllUser() throws SQLException {
        List<User> u = new ArrayList<>();

        u = ud.findAllUser();
        System.out.println();
    }
}