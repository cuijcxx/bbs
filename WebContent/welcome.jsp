<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>欢迎</title>
<style type="text/css">
/* .pos_right {position:relative; left:60px;} */
.center {text-align:center;}
</style>
</head>
<body>
	<form class="center" action="" method="post">
		<label>账号：</label>
		<input name="userno" type="text">
		<br/>
		<label>密码：</label>
		<input name="password" type="password">
		<br/>
		<input id="submitButton"  type="submit" value="登录" onclick="javascript:this.form.action='login.jsp'"/>
        <input id="registerButton" class="pos_right" type="submit" value="注册" onclick="javascript:this.form.action='register_page.jsp'"/>
  		<input id="manager_submitButton" type="submit" value="管理员登陆" onclick="javascript:this.form.action='manager_login.jsp'"/>
  	</form>
</body>
</html>