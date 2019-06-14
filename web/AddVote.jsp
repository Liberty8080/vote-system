<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.LinkedHashMap" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 6/8/19
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="voteAdd" class="dao.VoteDao" scope="session"/>
<jsp:useBean id="vote" class="model.VoteTheme" scope="session"/>
<%
   String theme =  request.getParameter("voteTheme");
   String info = request.getParameter("voteInfo");
    Map<String,Integer> options = new LinkedHashMap<>();
    options.put(request.getParameter("voteOption1"),0);
    options.put(request.getParameter("voteOption2"),0);
    options.put(request.getParameter("voteOption3"),0);
    options.put(request.getParameter("voteOption4"),0);
    vote.setTheme(theme);
    vote.setInfo(info);
    vote.setOptions(options);

    try {
        voteAdd.addVote(vote);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    Set<String> set=options.keySet();
    for (String key : set) {
        Integer value = options.get(key);
    }
    response.sendRedirect("VoteView.jsp");
%>

