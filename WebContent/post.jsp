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
			String sql = "select Title,Content,PostNo,Clicks,PostUser,Time,ReplyNum from Posts where BlockNo=" + blockNo;
			rst = stmt.executeQuery(sql);
			%>
			<div>
			<!-- <button onclick="window.location.href='add_post.jsp'">发帖</button> -->
			<button type="button" onclick="window.location.href='user.jsp?UserNo=<%=userno%>'">返回</button>
			</div>
			<div><p><%=BlockName%></p></div>
	<%
	while(rst.next()){
		String title = rst.getString("Title");
		String content = rst.getString("Content");
		int postno = rst.getInt("PostNo");
		int clicks = rst.getInt("Clicks");
		String postuser = rst.getNString("PostUser");
		String time = rst.getString("Time");
		int replynum = rst.getInt("ReplyNum");
		%>
		<div class="one_post">
		<hr>
		<a href="reply.jsp?UserNo=<%= userno %>&PostNo=<%= postno %>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>" style="text-decoration:none;color:#000000;">
		<p>#<%=postno %></p>
		<p>标题：<%=title %></p>
		<p><%=content %></p>
		</a>
		<p>发帖人：<%=postuser%>&nbsp&nbsp点击：<%=clicks %>&nbsp&nbsp回复数：<%=replynum %>&nbsp&nbsp发帖时间：<%=time %></p>
		</div>
		<%
	}%>
	<hr>
	<form action="" method="post">
	<textarea name="title" rows="1" cols="40" maxlength="20" placeholder="标题"></textarea>
	<br>
	<textarea name="content" rows="10" cols="40" maxlength="150" placeholder="请开始你的表演"></textarea>
	<br>
	<input type="submit" value="发帖" onclick="javascript:this.form.action='add_a_post.jsp?UserNo=<%=userno%>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>'">
	</form>
	<%
	
	rst.close();
	stmt.close();
	conn.close();
	
		} catch (java.sql.SQLException e) {
			out.println(e.toString());
		}
	%>
	
</body>
</html>