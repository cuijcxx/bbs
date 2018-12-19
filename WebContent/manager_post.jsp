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
			<button type="button" onclick="window.location.href='database_manager.jsp?UserNo=<%=userno%>'">返回</button>
			</div>
			<div><p style="font-weight:bold;"><%=BlockName%></p></div>
			<%if(!rst.next()){
				out.print("暂无帖子！");
			}
			rst.previous();%>
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
		<a href="manager_reply.jsp?UserNo=<%= userno %>&PostNo=<%= postno %>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>" style="text-decoration:none;color:#000000;">
		<p>#<%=postno %></p>
		<p>标题：<%=title %></p>
		<p><%=content %></p>
		</a>
		<p>发帖人：<%=postuser%>&nbsp&nbsp点击：<%=clicks %>&nbsp&nbsp回复数：<%=replynum %>&nbsp&nbsp发帖时间：<%=time %></p>
		<button type="button" onclick="window.location.href='modify_post.jsp?UserNo=<%=userno%>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>&PostNo=<%=postno%>'">修改帖子</button>
		<button type="button" onclick="window.location.href='delete_post_check.jsp?UserNo=<%=userno%>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>&PostNo=<%=postno%>'">删除帖子</button>
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