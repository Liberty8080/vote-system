<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 5/28/19
  Time: 6:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" type="dbBean.DBcon" scope="session"/>
<%
    String id = request.getParameter("id");
    ResultSet rs = db.executeQuery("select * from vote where id =" + id);
    int num = 0;
    try {
        if (rs.next()) num = rs.getInt("count");
    } catch (SQLException e) {
        e.printStackTrace();
    }
    num++;
    db.executeUpdate("update vote set count = " + num + " where id = " + id);
    try {
        rs.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<jsp:forward page="info.jsp"/>
