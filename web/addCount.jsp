<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 6/8/19
  Time: 7:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="voteDao" class="dao.VoteDao" scope="session"/>

<%
   String str = request.getParameter("string").trim();
   int id = Integer.parseInt(request.getParameter("id"));
   int num = Integer.parseInt(request.getParameter("num"));
   num++;
   voteDao.addCount(id,str,num);
    response.sendRedirect("http://localhost:8080/vote/makeVote.jsp?tid="+id);

%>


