<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 5/28/19
  Time: 6:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" class="dbBean.DBcon" scope="session"/>
<%
    String addItem = request.getParameter("add_item");
    if(addItem!=null)
    {
        String sql= "insert into vote(item,count) values('"+addItem+"',"+0+")";
        db.executeUpdate(sql);
        db.close();
    }
%>
<jsp:forward page="manage.jsp"/>


