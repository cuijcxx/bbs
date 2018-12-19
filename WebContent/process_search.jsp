<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>处理名字</title>
</head>
<body>
<%
	String userno=new String(request.getParameter("UserNo")); 
	String username=new String(request.getParameter("UserName").getBytes("iso-8859-1"), "utf-8");
if (username.equals("") || username == null) {
%>
<script>
alert("输入不能为空！");
window.location.href = "search_page.jsp?UserNo=<%=userno%>";
</script>
<%}
java.sql.Connection conn;
java.sql.Statement stmt;
java.sql.ResultSet rst;

try {
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC",
			"root", "485769");
	stmt = conn.createStatement();
	String sql = "select * from users where username='" + username +"'";
	rst = stmt.executeQuery(sql);
	
	if(!rst.next()){
		%>
		<script>
		alert("用户不存在！");
		window.location.href = "search_page.jsp?UserNo=<%=userno%>";
		</script>
		<%
	}else{
		%>
		<script>
		window.open("user_search.jsp?UserName=<%=username%>");
		window.location.href = "search_page.jsp?UserNo=<%=userno%>";
		</script>
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