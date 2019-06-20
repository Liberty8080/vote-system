package dao;

import model.User;
import org.junit.Test;

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
        ud.addUser(u);
    }

    @Test
    public void deleteUser() {
        ud.deleteUser("王五");
    }

    @Test
    public void updateUser() {
        User u = new User();
        u.setId("4");
        u.setName("王五");
        u.setPassword("123456");
        ud.updateUser(u);
    }
}