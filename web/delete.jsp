<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 5/28/19
  Time: 6:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" class="dbBean.DBcon" scope="session"/>
<%
    String delid = request.getParameter("delid");
    if (delid != null) {
        db.executeUpdate("delete from vote where id =" + delid);
        db.close();
    }
%>
<jsp:forward page="manage.jsp"/>