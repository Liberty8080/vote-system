<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 6/20/19
  Time: 7:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="ud" class="dao.UserDao" scope="session"/>



<%
ud.deleteUser(Integer.parseInt(request.getParameter("id")));
response.sendRedirect("manage.jsp");
%>
