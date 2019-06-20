<%@ page import="model.User" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 6/20/19
  Time: 7:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="ud" class="dao.UserDao" scope="session"/>

<%
    User u = new User();
    u.setId(Integer.parseInt(request.getParameter("id")));
    u.setPassword(request.getParameter("password"));
    u.setName(request.getParameter("username"));
    int oldUserID = Integer.parseInt(request.getParameter("old-userid"));
    ud.updateUser(u,oldUserID);
    response.sendRedirect("manage.jsp");
%>
