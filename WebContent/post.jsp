<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>看帖</title>
</head>
<body>
	<%
		String userno=new String(request.getParameter("UserNo"));
		int blockNo = Integer.parseInt(request.getParameter("BlockNo"));
		//request.setCharacterEncoding("UTF-8");
		String BlockName = new String(request.getParameter("BlockName").getBytes("iso-8859-1"), "utf-8");
		java.sql.Connection conn;
		java.sql.Statement stmt;
		java.sql.ResultSet rst;

		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC",
					"root", "485769");
			stmt = conn.createStatement();
			String sql = "select Content,PostNo,Clicks,PostUser,Time from Posts where BlockNo=" + blockNo;
			rst = stmt.executeQuery(sql);
			%>
			<div>
			<button onclick="window.location.href='add_post.jsp'">发帖</button>
			<button type="button" onclick="window.location.href='user.jsp?UserNo=<%=userno%>'">返回</button>
			</div>
			<div><p><%=BlockName%></p></div>
	<%
	while(rst.next()){
		String content = rst.getString("Content");
		int postno = rst.getInt("PostNo");
		int clicks = rst.getInt("Clicks");
		String postuser = rst.getNString("PostUser");
		String time = rst.getString("Time");
		%>
		<div class="one_post">
		<hr>
		<a href="reply.jsp?UserNo=<%= userno %>&PostNo=<%= postno %>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>" style="text-decoration:none;color:#000000;">
		<p>#<%=postno %></p>
		<p><%=content %></p>
		</a>
		<p>发帖人：<%=postuser%>&nbsp&nbsp点击：<%=clicks %>&nbsp&nbsp发帖时间：<%=time %></p>
		</div>
		<%
	}
	
	rst.close();
	stmt.close();
	conn.close();
	
		} catch (java.sql.SQLException e) {
			out.println(e.toString());
		}
	%>
	
</body>
</html>