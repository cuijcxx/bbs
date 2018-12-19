<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>增加用户</title>
</head>
<body>
	<%
		String UserNo=new String(request.getParameter("UserNo"));
		String username = new String(request.getParameter("username").getBytes("iso-8859-1"), "utf-8");
		String gender = new String(request.getParameter("gender"));
		String birthday = new String(request.getParameter("birthday"));
		String password = new String(request.getParameter("password"));
		String email = new String(request.getParameter("email"));
	
		if (username.equals("") || username == null || gender.equals("") || gender == null || birthday.equals("") || birthday == null || password.equals("") || password == null
				|| email.equals("") || email == null) {
	%>
	<script>
		alert("输入不能为空！");
		window.location.href = "add_user.jsp?UserNo=<%=UserNo %>";
	</script>
	<%
		}
	
		java.sql.Connection conn;
		java.sql.PreparedStatement stmt;
		java.sql.ResultSet rst;
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC",
					"root", "485769");
			java.util.Calendar calendar = Calendar.getInstance();
			int year = calendar.get(Calendar.YEAR);
			int month = calendar.get(Calendar.MONTH) + 1;
			int day = calendar.get(Calendar.DAY_OF_MONTH);
			String localdate = year + "-" + (month < 10 ? "0" + month : month) + "-" + (day < 10 ? "0" + day : day);
			int dyear = year-Integer.parseInt(birthday.substring(0,4));
			int dmonth_day = (month-Integer.parseInt(birthday.substring(5,7))) * 100 + day-Integer.parseInt(birthday.substring(8,10));
			int age = dmonth_day < 0 ? (dyear - 1) : dyear;
			String sql2 = "insert into Users(UserName,Gender,Age,Level,Birthday,Password,Email,Regdate) values('"
					+ username + "','" + gender + "'," + age + "," + 1 + ",'" + birthday + "','" + password + "','"
					+ email + "','" + localdate + "')";
			stmt = conn.prepareStatement(sql2, PreparedStatement.RETURN_GENERATED_KEYS);
			stmt.executeUpdate(sql2, PreparedStatement.RETURN_GENERATED_KEYS);
			rst = stmt.getGeneratedKeys();
			rst.next();
			out.println("添加成功！用户账号是：" + rst.getObject(1));
			rst.close();
			stmt.close();
			conn.close();
			%>
			<br>
			<a href="database_manager.jsp?UserNo=<%=UserNo %>">返回</a>
			<%
		}
		catch(java.sql.SQLException e)
		{
			out.println(e.toString());
		}
	%>
</body>
</html>