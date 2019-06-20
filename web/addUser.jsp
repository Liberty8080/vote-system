<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 6/20/19
  Time: 7:07 PM
  To0 change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="ud" class="dao.UserDao" scope="session"/>

<%
    String name = request.getParameter("id");
    String password = request.getParameter("password");
    int i = ud.addUser(name,password);
    response.sendRedirect("manage.jsp");

%>
