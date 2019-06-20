<%@ page import="model.VoteTheme" %>
<%@ page import="model.VoteOption" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 6/21/19
  Time: 1:19 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="vd" class="dao.VoteDao" scope="session"/>
<%

    VoteTheme voteTheme = new VoteTheme();
    List<Integer> optionsid = new LinkedList<>();
    List<VoteOption> options = new LinkedList<>();

    try {
         optionsid = vd.findOptionID(Integer.parseInt(request.getParameter("vote-id")));
    } catch (SQLException e) {
        e.printStackTrace();
    }
    voteTheme.setTheme(request.getParameter("vote-theme"));
    voteTheme.setId(Integer.parseInt(request.getParameter("vote-id")));
    voteTheme.setInfo(request.getParameter("vote-info"));
    voteTheme.setCensor(Integer.parseInt(request.getParameter("vote-censor")));

    for(int i =0 ; i<4 ;i++){
       int j = i+1;
        VoteOption v1  = new VoteOption();
        v1.setOptionId(optionsid.get(i));
        v1.setThemeId(Integer.parseInt(request.getParameter("vote-id")));
        v1.setVoteItem(request.getParameter("vote-option"+j));
        v1.setCount(Integer.parseInt(request.getParameter("vote-count"+j)));
        options.add(v1);
    }

voteTheme.setAllOptions(options);
vd.updateVote(voteTheme);
response.sendRedirect("managevote.jsp?tid="+voteTheme.getId());
%>