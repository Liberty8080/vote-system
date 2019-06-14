<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="model.VoteTheme" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 6/8/19
  Time: 2:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="voteDao" class="dao.VoteDao" scope="session"/>
<jsp:useBean id="vote" class="model.VoteTheme" scope="session"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>投票总览</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <style>
        .card {
            width: auto;
            height: auto;
        }

        img {
            width: auto;
            height: auto;
            max-width: 100%;
            max-height: 100%;
        }

        .container {
            margin-top: 50px;
        }

        .votebtn {
            float: right;
        }

        .col-sm-4 {
            padding-top: 5px;
            padding-bottom: 5px;
        }
        .footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            /* Set the fixed height of the footer here */
            height: 50px;
            background-color: #f5f5f5;
        }

    </style>
</head>
<body>
<nav class="navbar  navbar-dark bg-dark" id="nav0">
    <a class="navbar-brand" href="Home.html"><h1 style="font-family: KacstArt,fantasy">vote.com</h1></a>
    <div class="navbar-nav">
        <button class="btn btn-success" data-toggle="modal" data-target="#addvote-modal">添加投票</button>
    </div>
</nav>

<div class="container">
    <div class="row">
        <%
            try {
                List<VoteTheme> votes = voteDao.findAllVote();
                for (VoteTheme v : votes) {
                    out.print("<div class='col-sm-4'>\n" +
                            "<div class='card'>\n" +
                            "<img class='card-img-top' src='image/cyberpunk.jpg' alt='Card image cap'>\n" +
                            "<div class='card-body'>");
                    out.print("<h5 class='card-title text-center'>"+v.getTheme()+"</h5>\n");
                    out.print("<p class='card-text'>"+v.getInfo()+"</p>\n");
                    out.print("<a href='makeVote.jsp?tid="+v.getId()+"' class='btn btn-primary votebtn'>点击投票</a>\n");
                    out.print("</div></div></div>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </div>
</div>
<!--主视图-->



<!--
添加投票模态框-->
<div class="modal fade m-auto " id="addvote-modal" data-backdrop="false" tabindex="-1" role="dialog"
     aria-labelledby="signin-modal"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header ">
                <h5 class="modal-title text-center" style="text-align: center">添加投票</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form method="post" action="AddVote.jsp" role="form" id="addvoteForm">
                    <div class="form-group">
                        <label for="addvoteTheme">投票主题</label>
                        <input type="text" class="form-control" name="voteTheme" id="addvoteTheme"/>
                    </div>
                    <div class="form-row">
                        <div class="col">
                            <label for="addvoteOption1">选项一</label>
                            <input type="text" class="form-control" name="voteOption1"
                                   id="addvoteOption1"/>
                        </div>
                        <div class="col">
                            <label for="addvoteOption2">选项二</label>
                            <input type="text" class="form-control" name="voteOption2"
                                   id="addvoteOption2"/>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="col">
                            <label for="addvoteOption3">选项三</label>
                            <input type="text" class="form-control" name="voteOption3"
                                   id="addvoteOption3"/>
                        </div>
                        <div class="col">
                            <label for="addvoteOption4">选项四</label>
                            <input type="text" class="form-control" name="voteOption4"
                                   id="addvoteOption4"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="voteInfo">投票内容</label>
                        <textarea id="voteInfo" class="form-control" name="voteInfo"></textarea>
                    </div>
                    <div class="form-group " style="float: right;">
                        <button type="button" class="btn btn-secondary mr-auto" data-dismiss="modal">取消</button>
                        <input type="submit" class="btn btn-primary mr-auto" id="votesubmit" data-dismiss="modal"
                               value="提交" onclick="addvote()"/>

                    </div>
                </form>

            </div>
        </div>
    </div>
</div>


<footer class="navbar navbar-dark  bg-dark navbar-fixed-bottom ">
    <div class="navbar-nav">
        @copyright 老赵
    </div>
</footer>
<script src="js/addvote.js"></script>
<script type="text/javascript">
    $(".votebtn").click(
        function () {
        }
    );
</script>

</body>
</html>