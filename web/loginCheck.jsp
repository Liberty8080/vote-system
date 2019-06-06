<%@ page import="java.sql.SQLException" %>
<%@ page import="dao.UserDao" %>
<%@ page import="model.Admin" %>
<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 5/29/19
  Time: 4:06 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="adminLoginCheck" class="dao.AdminDao" scope="session"/>
<jsp:useBean id="userLoginCheck" class="dao.UserDao" scope="session"/>
<%
    String username = request.getParameter("user");
    String password = request.getParameter("password");
    boolean isAdmin = username.equals("admin");
    //管理员用户登录
    if (isAdmin) {
        try {
            Admin admin = new Admin();
            admin.setName(username);
            admin.setPassword(password);
            boolean succeed = adminLoginCheck.login2(admin);
            if (succeed) {
                response.sendRedirect("manage.jsp");
                adminLoginCheck.closeDao();
            } else {
                response.sendRedirect("login.jsp");
                adminLoginCheck.closeDao();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    //普通用户登录
    else {
        try {
            boolean succeed = userLoginCheck.login(username, password);
            if (succeed) {
                System.out.println("登陆成功");
                response.sendRedirect("mainvotepage.jsp");
            } else{
                System.out.println("登录失败");
                response.sendRedirect("login.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>