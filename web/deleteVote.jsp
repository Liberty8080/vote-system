<%@ page import="org.omg.CORBA.INTERNAL" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 6/20/19
  Time: 11:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="vd" class="dao.VoteDao" scope="session"/>

<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    vd.deleteVote(id);
    response.sendRedirect("manage.jsp");
%>

