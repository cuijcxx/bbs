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
	String userno=new String(request.getParameter("userno"));
	java.sql.Connection conn;
	java.sql.Statement stmt1;
	java.sql.Statement stmt2;
	java.sql.ResultSet rst1;
	java.sql.ResultSet rst2;
	try{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn=java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "485769");
		stmt1=conn.createStatement();
		String sql1="select UserNo from Users where UserNo="+userno;
		rst1=stmt1.executeQuery(sql1);
		if(!rst1.next())
		{
			out.println("该账号不存在！");
			%>
			<br> <a href="delete_user.jsp?UserNo=<%=UserNo %>">返回</a>
			<%
		}
		else
		{
			stmt2=conn.createStatement();
			String sql2="delete from Users where UserNo="+userno;
			stmt2.execute(sql2);
			stmt2.close();
			rst1.close();
			stmt1.close();
			conn.close();
			%>
			<script>
				alert("删除成功！");
				window.location.href = "database_manager.jsp?UserNo=<%=UserNo %>";
			</script>
			<%
		}
		rst1.close();
		stmt1.close();
		conn.close();
	}
	catch(java.sql.SQLException e)
	{
		out.println(e.toString());
	}
%>
</body>
</html>