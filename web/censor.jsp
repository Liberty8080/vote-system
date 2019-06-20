<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 6/21/19
  Time: 4:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="vd" class="dao.VoteDao" scope="session"/>

<%
    vd.censor(Integer.parseInt(request.getParameter("tid")));
    response.sendRedirect("manage.jsp");
%>
