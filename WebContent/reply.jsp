<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>回复</title>
</head>
<body>
	<%
		String userno = new String(request.getParameter("UserNo"));
		int postno = Integer.parseInt(request.getParameter("PostNo"));
		int blockNo = Integer.parseInt(request.getParameter("BlockNo"));
		String BlockName = new String(request.getParameter("BlockName").getBytes("iso-8859-1"), "utf-8");

		java.sql.Connection conn;
		java.sql.Statement stmt;
		java.sql.ResultSet rst;
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC",
					"root", "485769");
			stmt = conn.createStatement();
			String sql = "select Content,Clicks,PostUser,Time from Posts where PostNo=" + postno;
			rst = stmt.executeQuery(sql);
			if (rst.next()) {
	%>
	<button type="button"
		onclick="window.location.href='post.jsp?UserNo=<%=userno%>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>'">返回</button>
	<p>原帖：</p>
	<p>#<%=postno%></p>
	<p><%=rst.getString("Content")%></p>
	<p>发帖人：<%=rst.getNString("PostUser")%>&nbsp&nbsp点击：<%=rst.getInt("Clicks")%>&nbsp&nbsp发帖时间：<%=rst.getString("Time")%></p>
	<hr>
	<%
		sql = "select Floor,ReplyUser,replycontent,replytime,praisenum from replies where originalno="
						+ postno;
	rst = stmt.executeQuery(sql);
	%>
	<p>回帖：</p>
	<%
	if(!rst.next()){%>
		暂无回帖
	<%}
	else{
	rst.previous();%>
	<%
	while(rst.next()){
		%>
		<p>#<%=rst.getInt("floor")%></p>
		<p><%=rst.getString("replyContent")%></p>
		<p>回复人：<%=rst.getNString("replyUser")%>&nbsp&nbsp点赞：<%=rst.getInt("praisenum")%>&nbsp&nbsp回复时间：<%=rst.getString("replyTime")%></p>
		<hr>
		<%
	}
	}%>
	<form action="" method="post">
	<textarea name="content" rows="10" cols="40" maxlength="100" placeholder="请开始你的表演"></textarea>
	<br>
	<input type="submit" value="回复" onclick="javascript:this.form.action='add_a_reply.jsp?UserNo=<%=userno%>&PostNo=<%=postno%>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>'">
	</form>
			<%
			} else {
				out.print("帖子不存在！");
	%>
	<button type="button"
		onclick="window.location.href='post.jsp?UserNo=<%=userno%>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>'">返回</button>
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