<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 5/28/19
  Time: 7:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" class="dbBean.DBcon" scope="session"/>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    <h2>投票结果</h2>
    <table>
        <tr>
            <th>
                选项
            </th>
            <th>
                得票数
            </th>
            <th>
                比例
            </th>
        </tr>
        <% int totalNum = 0;
            ResultSet rs = db.executeQuery("select sum(count) from vote");
            try {
                if (rs.next()) totalNum = rs.getInt(1);
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            rs = db.executeQuery("select * from vote ");
            try {
                while (rs.next()) {
                    out.println("<tr>");
                    int num = rs.getInt("count");
                    out.println("<td>" + rs.getString("item") + "</td>");
                    out.println("<td>得" + num + "票   共" + totalNum + "票");
                    out.println("<td>得票率");
                    out.println(num * 100 / totalNum + "%</td></tr>");
                }
            } catch (SQLException se) {
                se.printStackTrace();
            }
            try {
                rs.close();
            } catch (SQLException se) {
                se.printStackTrace();
                db.close();
            }
        %>
    </table>
    <p><a href="vote.jsp">返回投票页面</a></p>
</div>
</body>
</html>
