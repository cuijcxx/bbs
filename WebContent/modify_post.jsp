<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改帖子</title>
</head>
<body>
	<%
		String userno=new String(request.getParameter("UserNo"));
		int blockNo = Integer.parseInt(request.getParameter("BlockNo"));
		String BlockName = new String(request.getParameter("BlockName").getBytes("iso-8859-1"), "utf-8");
		String postno = new String(request.getParameter("PostNo"));
	%>
	<form action="" method="post">
		<label>标题：</label>
		<input name="title" type="text">
		<br/>		
		<label>内容：</label>
		<input name="content" type="text">
		<br/>
		<input id="submitButton"  type="submit" value="提交" onclick="javascript:this.form.action='modify_post_check.jsp?UserNo=<%=userno%>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>&PostNo=<%=postno%>'"/>
		<input id="backButton"  type="submit" value="返回" onclick="javascript:this.form.action='database_manager.jsp?UserNo=<%=userno%>'"/>
  	</form>
</body>
</html>