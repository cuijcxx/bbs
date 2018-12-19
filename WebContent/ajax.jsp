<%@ page contentType="text/html; charset=GB2312" %>  

<%
	java.sql.Connection conn;
	java.sql.Statement stmt;
	java.sql.Statement stmt2;
	java.sql.ResultSet rst;
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn=java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC",
				"root", "485769");
		stmt=conn.createStatement();
		String sql="select WaterUserNo,UserName from WaterUser,Users where WaterUser.WaterUserNo=Users.UserNo";
		rst=stmt.executeQuery(sql);
		if (rst.next()) {
			response.setContentType("text/xml; charset=UTF-8");
			response.setHeader("Cache-Control", "no-cache");
			stmt2=conn.createStatement();
			out.println("<response>");
			out.println("<WaterUserNo>"+rst.getInt("WaterUserNo")+"</WaterUserNo>");
			out.println("<WaterUserName>"+rst.getString("UserName")+"</WaterUserName>");
			String sql2="delete from WaterUser where WaterUserNo="+rst.getInt("WaterUserNo");
			stmt2.executeUpdate(sql2);
			while(rst.next()){
				out.println("<WaterUserNo>"+rst.getInt("WaterUserNo")+"</WaterUserNo>");
				out.println("<WaterUserName>"+rst.getString("UserName")+"</WaterUserName>");
				sql2="delete from WaterUser where WaterUserNo="+rst.getInt("WaterUserNo");
				stmt2.executeUpdate(sql2);
			}
			out.println("</response>");  
			rst.close();
			stmt.close();
			conn.close();
			out.close();  
		}
	} catch (java.sql.SQLException e) {
		out.println(e.toString());
	}

%>
