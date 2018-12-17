<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@page import="com.sun.jmx.snmp.Timestamp"%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>插入回复</title>
</head>
<body>
<%
	String content = new String(request.getParameter("content"));
	//out.print(content);
	//out.print(request.getParameter("UserNo"));
	//out.print(request.getParameter("aa"));
	String userno = new String(request.getParameter("UserNo"));
	int postno = Integer.parseInt(request.getParameter("PostNo"));
	int blockNo = Integer.parseInt(request.getParameter("BlockNo"));
	String BlockName = new String(request.getParameter("BlockName").getBytes("iso-8859-1"), "utf-8");
	
	java.sql.Connection conn;
	java.sql.Statement stmt1;
	java.sql.Statement stmt2;
	java.sql.ResultSet rst1;
	java.sql.ResultSet rst2;
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC",
				"root", "485769");

		int floor;
		String replyuser;
		//Date date = new Date();
		//Timestamp time = new Timestamp(date.getTime());
		//out.print(time);
		
		stmt1 = conn.createStatement();
		String sql1 = "select ifnull(max(Floor),0) as maxfloor from replies where OriginalNo=" + postno;
		rst1 = stmt1.executeQuery(sql1);
		rst1.next();
		floor = rst1.getInt("maxfloor") + 1;
		
		stmt2 = conn.createStatement();
		String sql2 = "select username from users where userno=" + userno;
		rst2 = stmt2.executeQuery(sql2);
		rst2.next();
		replyuser = rst2.getString("username");
		
		String sql = "insert into Replies(OriginalNo,Floor,ReplyUserNo,ReplyUser,ReplyContent,ReplyTime,PraiseNum) values("
				+ postno + "," + floor + "," + userno + ",'" + replyuser + "','" + content + "',current_timestamp()," + 0 + ")";
		stmt1.executeUpdate(sql);
		%>
		<script>
		window.location.href="reply.jsp?UserNo=<%=userno%>&PostNo=<%=postno%>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>";
		</script>
		<%
		rst1.close();
		rst2.close();
		stmt1.close();
		stmt2.close();
		conn.close();
		
	} catch (java.sql.SQLException e) {
		out.println(e.toString());
	}
%>
</body>
</html>