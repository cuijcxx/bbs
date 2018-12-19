<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>系统管理员页面</title>
<style type="text/css">
.title
{
	font-size:300%;
	font-weight:bold;
	text-align:center;
	padding:0;
}
.main
{
	position:fixed;
	top:0%;
	left:0%;
	bottom:0%;
	right:0%;
	float:left;
	width:70%;
}
ul
{
	list-style-type:none;
	margin:0;
	padding:0;
	width:100%;
	height:100%;
}
.sidebar{
	width:20%;
	float:right;
}
div.sidebar a:link,div.sidebar a:visited
{
	display:block;
	font-weight:bold;
	color:#FFFFFF;
	background-color:#bebebe;
	text-align:center;
	padding:15px;
	text-decoration:none;
}
div.sidebar a:hover,div.sidebar a:active
{
	background-color:#cc0000;
}
li {padding:10px; width:90%;}
.one_block 
{
	height:25%;
	width:40%;
	margin:5%;
	float:left;	
}
div.one_block a:link,div.one_block a:visited
{
	height:100%;
	display:block;
	font-weight:bold;
	font-size:200%;
	color:#FFFFFF;
	background-color:#000000;
	text-align:center;
	padding:15px;
	text-decoration:none;
	word-wrap:break-word;
}
div.one_block a:hover,div.one_block a:active
{
	color:#000000;
	background-color:#FFFFFF;
}
</style>
</head>
<script lang="javascript">        
    var XMLHttpReq;   
    function createXMLHttpRequest() 
    {  
        if(window.XMLHttpRequest) 
        { 
            XMLHttpReq = new XMLHttpRequest();  
        }  
        else if (window.ActiveXObject)
        { 
            try 
            {  
                XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");  
            } 
            catch (e) 
            {  
                try 
                {  
                    XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");  
                } 
                catch (e) 
                {}  
            }  
        }  
    }   
    function sendRequest() 
    {  
        createXMLHttpRequest();  
        var url = "ajax.jsp";  
        XMLHttpReq.open("GET", url, true);  
        XMLHttpReq.onreadystatechange = processResponse; 
        XMLHttpReq.send(null); 
    }   
    function processResponse() 
    {  
        if (XMLHttpReq.readyState == 4) 
        { 
            if (XMLHttpReq.status == 200) 
            { 
                DisplayHot();  
                setTimeout("sendRequest()", 1000);  
            } 
            else 
            {  
                window.alert("您所请求的页面有异常。");  
            }  
        }  
    }  
    function DisplayHot() 
    {  
        var no = XMLHttpReq.responseXML.getElementsByTagName("WaterUserNo");  
        var name = XMLHttpReq.responseXML.getElementsByTagName("WaterUserName");  
        for (var i = 0; i < no.length; i++) {
        	window.alert(name[i].firstChild.nodeValue+"(账号："+no[i].firstChild.nodeValue+")可能为水贴用户！");
        }   
    }  
</script> 
<body onload=sendRequest() >
<%
	String UserNo=new String(request.getParameter("UserNo"));
	java.sql.Connection conn;
	java.sql.Statement stmt;
	java.sql.ResultSet rst;
	
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb?serverTimezone=UTC",
				"root", "485769");
		stmt = conn.createStatement();
		String sql = "select BlockName,BlocksNo from Blocks";
		rst = stmt.executeQuery(sql);
		%>
		<div class="main">
		<div class="title"><p>板块</p></div>
		<%
		while(rst.next()){
			String content = rst.getString("BlockName");
			int BlockNo = rst.getInt("BlocksNo");
			%>
			<div class="one_block"><a href="manager_post.jsp?UserNo=<%= UserNo %>&BlockNo=<%=BlockNo%>&BlockName=<%=content%>"><%=content%></a></div>
			<%
		}
		rst.close();
		stmt.close();
		conn.close();
		
		} 
	catch (java.sql.SQLException e) {
			out.println(e.toString());
		}
%>
</div>
<div class="sidebar">
<ul>
	<!-- <li><a href="block.jsp">板块</a></li> -->
	<!-- <li><a href="user_info.jsp">个人信息</a></li>
	<li><a href="query_user.jsp">查询用户</a></li>
	<li><a href="manage_block.jsp">管理板块</a></li> -->
	<li><a href="add_user.jsp?UserNo=<%=UserNo %>">增加用户</a></li>
	<li><a href="delete_user.jsp?UserNo=<%=UserNo %>">删除用户</a></li>
	<li><a href="welcome.jsp">登出</a></li>
</ul>
</div>
</body>
</html>