<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 5/25/19
  Time: 4:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" class="dbBean.DBcon" scope="session"/>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/manage.css"/>
</head>
<body>
<div>
    <h2>系统维护</h2>
    <table>
        <tr>
            <th colspan="3">
                删除投票项
            </th>
            <% ResultSet rs = db.executeQuery("select * from vote");
                int i = 1;
                try {
                    while (rs.next()) {
                        // 注意,在rs.next()之后,结果集才会被初始化,在这之前查询会返回空值
                        out.println("<tr>");
                        out.println("<td>" + i + "</td>");
                        out.println("<td>" + rs.getString("item") + "</td>");
                        out.println("<td><a href='delete.jsp?delid=" + rs.getString("id") + "'>删除</a></td>");
                        i++;
                    }
                } catch (SQLException se) {
                    se.printStackTrace();
                }
                try {
                    rs.close();
                    db.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </tr>
        <th colspan="3">添加投票项</th>
        <%--        表单内容 text:additem  --%>
        <tr>
            <td id="add_form" colspan="3">
                <form method="post" action="add.jsp">
                    <label>
                        内容:
                        <input type="text" name="add_item" size="30"/>
                    </label>
                    <input type="submit" value="提交"/>
                    <input type="reset" value="重置"/>
                </form>
            </td>
        </tr>
        <tr>
            <td colspan="3"><a href="vote.jsp">返回投票页面</a></td>
        </tr>
    </table>
</div>
</body>
</html>
