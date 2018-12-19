<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查询用户</title>
</head>
<body>
<%String userno=new String(request.getParameter("UserNo")); %>
<form action="" method="post">
请输入用户昵称：
<input name="UserName" type="text">
<input type="submit" value="查询" onclick="javascript:this.form.action='process_search.jsp?UserNo=<%=userno%>'"/>
</form>
<a href="user.jsp?UserNo=<%= userno %>"><button>返回</button></a>
</body>
</html>