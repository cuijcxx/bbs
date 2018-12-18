<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增帖子</title>
</head>
<body>
	<%
		String title = new String(request.getParameter("title").getBytes("iso-8859-1"), "utf-8");
		String content = new String(request.getParameter("content").getBytes("iso-8859-1"), "utf-8");
		String userno = new String(request.getParameter("UserNo"));
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
			String sql = "select username from users where userno=" + userno;
			rst = stmt.executeQuery(sql);
			rst.next();
			String postuser = rst.getString("username");
			sql = "insert into Posts(BlockNo,PostUserNo,PostUser,Title,Content,Clicks,ReplyNum,Time) values("
					+ blockNo + "," + userno + ",'" + postuser + "','" + title + "','" + content + "'," + 0 + "," + 0
					+ ",current_timestamp())";
			stmt.executeUpdate(sql);
			%>
			<script>
			window.location.href="post.jsp?UserNo=<%=userno%>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>";
			</script>
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