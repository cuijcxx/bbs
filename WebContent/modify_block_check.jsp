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
		String title = new String(request.getParameter("title").getBytes("iso-8859-1"), "utf-8");
	
		if (title.equals("") || title == null) {
	%>
	<script>
		alert("输入不能为空！");
		window.location.href = "modify_post.jsp";
	</script>
	<%
		}
	
		java.sql.Connection conn;
		java.sql.Statement stmt;
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC",
					"root", "485769");
			String sql = "update Blocks set BlockName='"+title+"'where BlocksNo="+blockNo;
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
			stmt.close();
			conn.close();
		%>
		<script>
			alert("修改成功！");
			window.location.href = "manage_block.jsp?UserNo=<%=userno%>";
		</script>
		<%
		}
		catch(java.sql.SQLException e)
		{
			out.println(e.toString());
		}
	%>
</body>
</html>