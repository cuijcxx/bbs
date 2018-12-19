<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>删除用户</title>
</head>
<body>
	<%
	String UserNo=new String(request.getParameter("UserNo"));
	%>
	<form action="" method="post">
		<label>账号：</label>
		<input name="userno" type="text">
		<br/>
		<input id="submitButton"  type="submit" value="提交" onclick="javascript:this.form.action='delete_user_check.jsp?UserNo=<%=UserNo %>'"/>
		<input id="backButton"  type="submit" value="返回" onclick="javascript:this.form.action='database_manager.jsp?UserNo=<%=UserNo %>'"/>
  	</form>
</body>
</html>