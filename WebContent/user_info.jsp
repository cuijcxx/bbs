<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import='java.io.*' %>
<%
	//StringBuilder strXML=new StringBuilder("<%@ page language='java' contentType='text/xml; charset=UTF-8' pageEncoding='UTF-8'%");
	//strXML.append(">");
	StringBuilder strXML = new StringBuilder("<?xml version='1.0' encoding='UTF-8'?>\n");

	strXML.append("<xml><Users>");
	java.sql.Connection conn;
	java.sql.Statement stmt;
	java.sql.ResultSet rst;
	java.sql.Statement post_stmt;
	java.sql.ResultSet post_rst;
	java.sql.Statement reply_stmt;
	java.sql.ResultSet reply_rst;
	java.sql.Statement bl_stmt;
	java.sql.ResultSet bl_rst;
	String userno=new String(request.getParameter("UserNo"));//要加引号
	//String userno_="2";
	try{
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn=java.sql.DriverManager.getConnection("jdbc:Mysql://localhost:3306/mydb?serverTimezone=UTC", "root", "485769");
		stmt=conn.createStatement();
		String sql = "select * from Users where UserNo = "+userno;
		rst = stmt.executeQuery(sql);
	String content = "";
	while(rst.next())
	{
		
		strXML.append("<User>");
		
		strXML.append("<Username>");
		content = rst.getString("UserName");
		strXML.append(content);
		strXML.append("</Username>");
		//insert info
		strXML.append("<Info>");
		//insert basic info
		strXML.append("<BasicInfo>");
		
		strXML.append("<Gender>");		
		content = rst.getString("Gender");
		strXML.append(content);
		strXML.append("</Gender>");		
		
		strXML.append("<Age>");		
		content = rst.getString("Age");
		strXML.append(content);
		strXML.append("</Age>");	
		
		strXML.append("<Birthday>");		
		content = rst.getString("Birthday");
		strXML.append(content);
		strXML.append("</Birthday>");	
		
		strXML.append("<Level>");		
		content = rst.getString("Level");
		strXML.append(content);
		strXML.append("</Level>");
		strXML.append("</BasicInfo>");	
		//insert other info
		strXML.append("<OtherInfo>");
		
		//String userno = rst.getString("UserNo");
		post_stmt=conn.createStatement();
		sql = "select * from posts where PostUserNo = "+userno;
		post_rst = post_stmt.executeQuery(sql);
		strXML.append("<Posts>");
		while(post_rst.next())
		{
			strXML.append("<Post>");
			
			strXML.append("<No>");
			content = post_rst.getString("PostNo");
			strXML.append(content);
			strXML.append("</No>");
			
			String block_no = post_rst.getString("BlockNo");
			bl_stmt=conn.createStatement();
			String temp_str = "select * from blocks where BlocksNo = "+block_no;
			bl_rst =bl_stmt.executeQuery(temp_str);
			if(bl_rst.next())
			{
				strXML.append("<Block>");
				content = bl_rst.getString("BlockName");
				strXML.append(content);
				strXML.append("</Block>");
			}
			
			strXML.append("<PostUsr>");
			content = post_rst.getString("PostUser");
			strXML.append(content);
			strXML.append("</PostUsr>");
			
			strXML.append("<Title>");
			content = post_rst.getString("Title");
			strXML.append(content);
			strXML.append("</Title>");
			
			strXML.append("<Time>");
			content = post_rst.getString("Time");
			strXML.append(content);
			strXML.append("</Time>");
			
			strXML.append("<Clicks>");
			content = post_rst.getString("Clicks");
			strXML.append(content);
			strXML.append("</Clicks>");

			strXML.append("<ReplyNum>");
			content = post_rst.getString("ReplyNum");
			strXML.append(content);
			strXML.append("</ReplyNum>");	
			
			
			strXML.append("</Post>");			
		}
		//posts end		
		strXML.append("</Posts>");
		
		//insert reply
		reply_stmt=conn.createStatement();
		sql = "select * from replies where ReplyUserNo = "+userno;
		reply_rst = reply_stmt.executeQuery(sql);
		strXML.append("<Replies>");
		while(reply_rst.next())
		{
			strXML.append("<Reply>");
			
			strXML.append("<OriginalNo>");
			content = reply_rst.getString("OriginalNo");
			strXML.append(content);
			strXML.append("</OriginalNo>");
			
			strXML.append("<Floor>");
			content = reply_rst.getString("Floor");
			strXML.append(content);
			strXML.append("</Floor>");
			
			strXML.append("<ReplyUser>");
			content = reply_rst.getString("ReplyUser");
			strXML.append(content);
			strXML.append("</ReplyUser>");
			
			strXML.append("<ReplyContent>");
			content = reply_rst.getString("ReplyContent");
			strXML.append(content);
			strXML.append("</ReplyContent>");
			
			strXML.append("<ReplyTime>");
			content = reply_rst.getString("ReplyTime");
			strXML.append(content);
			strXML.append("</ReplyTime>");
			
			strXML.append("<PraiseNum>");
			content = reply_rst.getString("PraiseNum");
			strXML.append(content);
			strXML.append("</PraiseNum>");
			
			strXML.append("</Reply>");			
		}
		//reply end		
		strXML.append("</Replies>");
		
		
		//otherinfo end
		strXML.append("</OtherInfo>");
		strXML.append("</Info>");
		strXML.append("</User>");
	}
	strXML.append("</Users></xml>");
	}
	catch(java.sql.SQLException e)
	{
		out.println(e.toString());
	}
	try
	{
		String xml=new String(strXML); 
		String filename = "user_info_" + userno +".xml";
		FileWriter fw=new FileWriter(filename); 
		fw.write(xml,0,xml.length());  
		fw.close(); 
		response.setContentType("text/xml;charset=utf-8");
		response.setHeader("Cache-control", "no-cache");
		response.getWriter().write(xml);
		response.flushBuffer();  
		response.setContentType("application/octet-stream");  
		response.addHeader("Content-Disposition","inline;filename=1.xml"); 
	}
	catch(IOException e) 
	{ 
		out.print(e.toString()); 
	} 
%>
