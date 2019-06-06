function login() {

    var username = document.getElementById("user_text");
    var pass = document.getElementById("password-text");

    if (username.value === "" && pass.value === "") {
        alert("请输入用户名与密码");
    }
    if (username.value !== "" && pass.value == null) {
        alert("请输入密码");
    }
    if(username.value === "" && pass.value !== null){
        alert("请输入用户名");
    }

}
