<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 5/28/19
  Time: 6:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" scope="session" class="dbBean.DBcon"/>
<html>
<head>
    <title>投票</title>
</head>
<body>
<div id="content">
    <h2>为你喜欢的漫画投出一票吧</h2>
    <form method="post" action="updatecount.jsp">
        <table>
            <%
                ResultSet rs = db.executeQuery("select * from vote");

                try {
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td><input type='radio' name='id' value='" + rs.getString("id") + "'>");
                        out.println(rs.getString("item"));
                        out.println("</td></tr>");
                    }
                } catch (SQLException se) {
                    se.printStackTrace();
                }
                try {
                    rs.close();
                    db.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
                session.setMaxInactiveInterval(-1);
            %>
            <tr>
                <td>
                    <input type="submit" value="投票"/>
                </td>
            </tr>
            <tr>
                <td>
                    <a href="info.jsp">查看投票</a>
                </td>
            </tr>
            <tr>
                <td>
                    <a href="manage.jsp">投票系统维护</a>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
