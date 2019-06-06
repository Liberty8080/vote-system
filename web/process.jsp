<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 5/25/19
  Time: 3:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" class="dbBean.DBcon" scope="session"/>
<%
    String user = request.getParameter("user");
    String password = request.getParameter("password");
    String sql = "select * from user where name='" + user + "' and password = '" + password + "'";
    ResultSet result = db.executeQuery(sql);

    try {
        if (result.next()) {
            result.close();
            db.close();
            session.setAttribute("admin", "ok");
%>

<%--跳转到主页--%>
<jsp:forward page="manage.jsp"/>

<%
} else {
    result.close();
    db.close();
%>

<jsp:forward page="login.jsp">
    <jsp:param name="warning" value="对不起您的用户名密码不正确"/>
</jsp:forward>

<%
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>