<%@ page import="java.sql.SQLException" %>
<%@ page import="model.VoteTheme" %>
<%@ page import="javafx.scene.chart.Axis" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 6/8/19
  Time: 4:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="voteDao" class="dao.VoteDao" scope="session"/>
<html>
<head>
    <title>管理投票</title>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/4.2.1/echarts.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
        .card {
            width: 400px;
        }

        .container {
            margin-top: 50px;
        }

        .col-lg-4 {
            margin-right: 30px;
        }
    </style>
</head>
<body>
<nav class="navbar  navbar-dark bg-dark" id="nav0">
    <a class="navbar-brand" href="Home.html"><h1 style="font-family: KacstArt,fantasy">vote.com</h1></a>
</nav>
<div class="container">
    <div class="float-left">

        <%
            int id = Integer.parseInt(request.getParameter("tid"));
            VoteTheme v = new VoteTheme();
            Map<String, Integer> options;
            Set<String> set;
            try {
                v = voteDao.findVoteById(id);
                options = v.getOptions();
                set = options.keySet();
                out.print(
                        "<div class='card'>\n" +
                                "<img class='card-img-top' src='image/cyberpunk.jpg' alt='Card image cap'>\n" +
                                "<div class='card-body'>");
                out.print("<h5 class='card-title text-center'>" + v.getTheme() + "</h5>\n");
                out.print("<p class='card-text'>" + v.getInfo() + "</p>\n");
                out.print("<form action='#' method='post' id='makeVoteForm'>\n");
                for (String option : set) {
                    out.print("  <div class=\"form-check\">\n" +
                            "            <input class='form-check-input' type='radio' name='voteOptions' id='" + option + "'  value=" + options.get(option) + " >\n" +
                            "            <label class=\"form-check-label\" for='" + option + "'>\n" +
                            "                " + option +
                            "            </label>\n" +
                            "        </div>");
                }
                out.print("");
                out.print("</div></div>");
            } catch (SQLException e) {
                e.printStackTrace();
            }


        %>
    </div>


    <div class=" float-right">
        <form action="updateVote.jsp" method="post" role="form">


            <div class="form-group">
                <label for="vote-theme">投票主题</label>
                <input type="text" class="form-control" id="vote-theme" name="vote-theme" value="<%=v.getTheme()%>">
                <input type="hidden" id="vote-id" name="vote-id" value="<%=v.getId()%>">
            </div>

            <div class="form-group">
                <label for="voteInfo">投票内容</label>
                <textarea id="voteInfo" class="form-control" name="vote-info"><%=v.getInfo()%></textarea>
            </div>
            <div class="form-row">
                <div class="col">
                    <label for="addvoteOption1">选项一</label>
                    <input type="text" class="form-control" name="vote-option1"
                           id="addvoteOption1"/>
                </div>
                <div class="col">
                    <label for="vote-count1">票数</label>
                    <input type="text" class="form-control" name="vote-count1"
                           id="vote-count1"/>
                </div>
            </div>
            <div class="form-row">
                <div class="col">
                    <label for="addvoteOption2">选项二</label>
                    <input type="text" class="form-control" name="vote-option2"
                           id="addvoteOption2"/>
                </div>
                <div class="col">
                    <label for="vote-count2">票数</label>
                    <input type="text" class="form-control" name="vote-count2"
                           id="vote-count2"/>
                </div>
            </div>
            <div class="form-row">
                <div class="col">
                    <label for="addvoteOption3">选项三</label>
                    <input type="text" class="form-control" name="vote-option3"
                           id="addvoteOption3"/>
                </div>
                <div class="col">
                    <label for="vote-count3">票数</label>
                    <input type="text" class="form-control" name="vote-count3"
                           id="vote-count3"/>
                </div>
            </div>
            <div class="form-row">
                <div class="col">
                    <label for="addvoteOption4">选项四</label>
                    <input type="text" class="form-control" name="vote-option4"
                           id="addvoteOption4"/>
                </div>
                <div class="col">
                    <label for="vote-count4">票数</label>
                    <input type="text" class="form-control" name="vote-count4"
                           id="vote-count4"/>
                </div>
            </div>
            <br><p></p>
            <div class="custom-control custom-radio custom-control-inline">
                <input type="radio" id="customRadioInline1" name="vote-censor" class="custom-control-input" value="1">
                <label class="custom-control-label" for="customRadioInline1">通过</label>
            </div>
            <div class="custom-control custom-radio custom-control-inline">
                <input type="radio" id="customRadioInline2" name="vote-censor" class="custom-control-input" value="-1">
                <label class="custom-control-label" for="customRadioInline2">不通过</label>
            </div>

<%--            <input type="submit" class="btn btn-primary">--%>
        <button class="btn btn-primary" type="button" onclick="updateVote()">提交</button>
        </form>





    </div>
</div>

<script>
function updateVote() {

    $(window).attr('location', 'updateVote.jsp?vote-id='+$("#vote-id").val()+'&vote-theme='+$("#vote-theme").val()
        +'&vote-info='+$("#voteInfo").val()+'&vote-option1='+$("#addvoteOption1").val()+'&vote-option2='+$("#addvoteOption2").val()
        +'&vote-option3='+$("#addvoteOption3").val()+'&vote-option4='+$("#addvoteOption4").val()+'&vote-count1='+$("#vote-count1").val()
        +'&vote-count2='+$("#vote-count2").val()+'&vote-count3='+$("#vote-count3").val()+'&vote-count4='+$("#vote-count4").val()+
    '&vote-censor='+$("input[name='vote-censor']:checked").val());

}


</script>
</body>
</html>
