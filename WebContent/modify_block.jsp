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
	%>
	<form action="" method="post">
		<label>版块名称：</label>
		<input name="title" type="text">
		<br/>	
		<input id="submitButton"  type="submit" value="提交" onclick="javascript:this.form.action='modify_block_check.jsp?UserNo=<%=userno%>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>'"/>
		<input id="backButton"  type="submit" value="返回" onclick="javascript:this.form.action='block_post.jsp?UserNo=<%=userno%>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>'"/>
  	</form>
</body>
</html>