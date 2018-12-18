<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>点赞</title>
</head>
<body>
<%
	String userno = new String(request.getParameter("UserNo"));
	int postno = Integer.parseInt(request.getParameter("PostNo"));
	int blockNo = Integer.parseInt(request.getParameter("BlockNo"));
	String BlockName = new String(request.getParameter("BlockName").getBytes("iso-8859-1"), "utf-8");
	int replyno = Integer.parseInt(request.getParameter("ReplyNo"));
	//out.print(replyno);
	
	java.sql.Connection conn;
	java.sql.Statement stmt;
	//java.sql.ResultSet rst;

	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC",
				"root", "485769");
		stmt = conn.createStatement();
		String sql ="update Replies set praisenum=praisenum+1 where replyno=" + replyno;
		stmt.executeUpdate(sql);
		
		//rst.close();
		stmt.close();
		conn.close();

	} catch (java.sql.SQLException e) {
		out.println(e.toString());
	}
%>
<script type="text/javascript">
window.location.href="reply.jsp?UserNo=<%=userno%>&PostNo=<%=postno%>&BlockNo=<%=blockNo%>&BlockName=<%=BlockName%>&Flag=1";
</script>
</body>
</html>