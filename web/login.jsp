<%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 5/25/19
  Time: 3:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录页面</title>

    <link rel="stylesheet" type="text/css" href="css/login.css"/>
    <script language="JavaScript" type="text/javascript" src="js/login.js"></script>
</head>

<body>
<div id="login_frame">
    <p id="image_logo"><img src="image/vote.png" alt="logo"></p>
<%--    <script language="JavaScript" type="text/javascript">--%>
<%--        function login() {--%>
<%--    var username = document.getElementById("user_text");--%>
<%--    var pass = document.getElementById("password-text");--%>
<%--    alert("test");--%>
<%--    if (username.value === "") {--%>
<%--        alert("请输入用户名");--%>
<%--    } else if (pass.value === "" || pass.value == null) {--%>
<%--        alert("请输入密码");--%>
<%--    }--%>
<%--}--%>

<%--    </script>--%>
    <form method="post" action="loginCheck.jsp">
        <p><label for="user_text" class="label_input">用户名</label><input type="text" name="user" id="user_text"
                                                                        class="text_field"/></p>

        <p><label for="password-text" class="label_input">密码</label><input type="password" name="password"
                                                                           id="password-text"
                                                                           class="text_field"/>
        </p>
        <div id="login_control">
            <input type="submit" id="btn_login" value="登录" onclick="login()"/>
            <a id="forget_pwd" href="forget_pwd.html">忘记密码？</a>
        </div>
    </form>

</div>
</body>
</html>

