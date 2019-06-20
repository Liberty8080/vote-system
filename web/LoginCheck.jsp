<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 6/7/19
  Time: 2:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="userCheck" class="dao.UserDao" scope="session"/>
<jsp:useBean id="AdminCheck" class="dao.AdminDao" scope="session"/>
<%
    String username = request.getParameter("username");
    String userPassword = request.getParameter("userPassword");
    String ad = request.getParameter("admin");
    try {
        //若是管理员
        if(ad!=null){
           if(AdminCheck.login(username,userPassword)){
               response.sendRedirect("VoteView.jsp");
               session.setAttribute("type","admin");
           }else {
               response.sendRedirect("login.jsp");
           }
           //若是普通用户
        }else {
            if (userCheck.login(username,userPassword)){
                response.sendRedirect("VoteView.jsp");
                session.setAttribute("type","user");
            }else {
                response.sendRedirect("login.jsp");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }


%>
