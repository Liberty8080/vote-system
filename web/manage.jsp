<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.VoteTheme" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 6/20/19
  Time: 3:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="user" class="model.User" scope="session"/>
<jsp:useBean id="ud" class="dao.UserDao" scope="session"/>
<jsp:useBean id="vd" class="dao.VoteDao" scope="session"/>

<%
    List<User> users = new ArrayList<>();
    try {
        users = ud.findAllUser();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>


<html>
<head>
    <title>后台管理</title>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
        li {
            float: left;
        }
    </style>
</head>
<body>
<%--导航栏--%>
<nav class="navbar navbar-dark bg-dark" id="nav0">

    <div class="navbar-header">
        <a class="navbar-brand" href="#"><h2 style="font-family: KacstArt,fantasy">vote.com</h2></a>
    </div>
</nav>
<div class="container">
    <nav>
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home"
                   aria-selected="true">用户管理</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab"
                   aria-controls="profile"
                   aria-selected="false">投票管理</a>
            </li>

        </ul>
        <div class="tab-content" id="myTabContent">

            <%--        用户管理标签栏--%>
            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                <br>
                <button class="btn btn-primary float-right btn-sm" data-toggle="modal" data-target="#add-user-modal">
                    添加用户
                </button>
                <br>
                <p></p>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>用户名</th>
                        <th>密码</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <%--                在这里生成用户列表--%>
                    <%
                        for (User u : users) {
                            out.println("<tr>");
                            out.println("<td>" + u.getId() + "</td>");
                            out.println("<td>" + u.getName() + "</td>");
                            out.println("<td>" + u.getPassword() + "</td>");
                            out.println("\n" +
                                    "          <td>      <div class= 'btn-group btn-group-sm' >\n" +
                                    "                    <button class=\"btn btn-outline-success float-right btn-sm\" data-toggle='modal' data-target='#edit-user-modal' onclick=\"values({id:'" + u.getId() + "',name:'" + u.getName() + "',password:'" + u.getPassword() + "'})\">编辑</button>\n" +
                                    "                    <button class=\"btn btn-outline-danger float-right btn-sm\" onclick='delUser(" + u.getId() + ")'>删除</button>\n" +

                                    "                </div></td>");

                            out.println("</tr>");
                        }
                    %>

                </table>
            </div>

            <%--    投票管理标签栏--%>
            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>id</th>
                        <th>主题</th>
                        <th>说明</th>
                        <th>审核状态</th>
                        <th>操作</th>
                    </tr>

                    </thead>
                    <tbody>
                    <%
                        List<VoteTheme> voteThemes;
                        int censor;
                        try {
                            voteThemes = vd.findAllVote();
                            for (VoteTheme v : voteThemes) {


                                out.println("<tr>");
                                out.println("<td>" + v.getId() + "</td>");
                                out.println("<td>" + v.getTheme() + "</td>");
                                out.println("<td>" + v.getInfo() + "</td>");
                                //判断是否审核
                                censor = v.getCensor();
                                switch (censor) {
                                    case -1:
                                        out.println("<td>未通过审核</td>");
                                        break;
                                    case 0:
                                        out.println("<td>未审核</td>");
                                        break;
                                    case 1:
                                        out.println("<td>已通过审核</td>");
                                        break;
                                }
                                out.println("<td>");
                                out.println("                    <div class=\"btn-group btn-group-sm\" role=\"group\" aria-label=\"Basic example\">\n" +
                                        "                        <button type=\"button\" class=\"btn btn-outline-success\" onclick='censor("+v.getId()+")'>审核</button>\n" +
                                        "                        <button type=\"button\" class=\"btn btn-outline-info\" onclick=\"manageVote(" + v.getId() + ")\">修改</button>\n" +
                                        "                        <button type=\"button\" class=\"btn btn-outline-danger\"onclick=\"delVote(" + v.getId() + ")\">删除</button>\n" +
                                        "                    </div>");
                                out.println("</td>");
                                out.println("</tr>");
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }

                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </nav>
</div>


<%--模态框--%>

<!-- 模态框 添加用户 -->
<div class="modal fade" id="add-user-modal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">添加用户</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- 模态框主体 -->
            <div class="modal-body">
                <form action="addUser.jsp">
                    <div class="form-group">
                        <label for="exampleInputEmail1">用户名</label>
                        <input type="text" name="username" class="form-control" id="exampleInputEmail1"
                               aria-describedby="emailHelp" placeholder="请输入用户名">
                        <small id="emailHelp" class="form-text text-muted">使用用户名作为登录账号</small>
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">密码</label>
                        <input type="password" name="password" class="form-control" id="exampleInputPassword1"
                               placeholder="请输入密码">
                    </div>
                    <button type="submit" class="btn btn-primary">确认</button>
                </form>
            </div>

            <!-- 模态框底部 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
            </div>

        </div>
    </div>
</div>


<%--修改用户信息模态框--%>
<%--参数：old-userid  id username password--%>
<div class="modal fade" id="edit-user-modal">
    <div class="modal-dialog">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">修改用户信息</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <!-- 模态框主体 -->
            <div class="modal-body">
                <form action="editUser.jsp">
                    <input type="hidden" id="old-userid" name="old-userid" value=""/>
                    <div class="form-group">
                        <label for="editid">id</label>
                        <input type="text" name="id" class="form-control" id="editid" aria-describedby="emailHelp"
                               placeholder="">
                    </div>
                    <div class="form-group">
                        <label for="editname">用户名</label>
                        <input type="text" name="username" class="form-control" id="editname"
                               aria-describedby="emailHelp"
                               placeholder="请输入用户名">
                        <small id="editHelp" class="form-text text-muted">使用用户名作为登录账号</small>
                    </div>
                    <div class="form-group">
                        <label for="editpassword">密码</label>
                        <input type="password" name="password" class="form-control" id="editpassword"
                               placeholder="请输入密码">
                    </div>
                    <button type="submit" class="btn btn-primary">确认</button>
                </form>
            </div>

            <!-- 模态框底部 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
            </div>

        </div>
    </div>
</div>

<%--审核模态框--%>


<script>
    function delUser(id) {
        window.location.href = "deleteUser.jsp?id=" + id;
    }

    function delVote(id) {
        $(window).attr('location', 'deleteVote.jsp?id=' + id);
    }

    function manageVote(id) {
        $(window).attr('location', 'managevote.jsp?tid=' + id);
    }

    // $("#edit-user-modal").modal('hide');
    function values(param) {
        $("#old-userid").val(param.id);
        $("#editid").attr('placeholder', param.id);
        $("#editname").attr('placeholder', param.name);
        $("#editpassword").attr('placeholder', param.password);
    }
    function censor(id) {
        $(window).attr('location', 'censor.jsp?tid=' + id);
    }
</script>

</body>
</html>
