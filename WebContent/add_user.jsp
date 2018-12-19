<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>增加用户</title>
</head>
<body>
	<%
	String UserNo=new String(request.getParameter("UserNo"));
	%>
	<form action="" method="post">
		<label>用户昵称：</label>
		<input name="username" type="text">
		<br/>
		<label>性别：</label>
		<select name="gender">
		<option value="male">男</option>
		<option value="female">女</option>
		</select>
		<br/>		
		<label>生日：</label>
		<input name="birthday" type="date">
		<br/>
		<label>密码：</label>
		<input name="password" type="password">
		<br/>
		<label>邮箱：</label>
		<input name="email" type="email">
		<br/>
		<input id="submitButton"  type="submit" value="提交" onclick="javascript:this.form.action='add_user_check.jsp?UserNo=<%=UserNo %>'"/>
		<input id="backButton"  type="submit" value="返回" onclick="javascript:this.form.action='database_manager.jsp?UserNo=<%=UserNo %>'"/>
  	</form>
</body>
</html>