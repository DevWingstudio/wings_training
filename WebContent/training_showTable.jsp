<%@ page import = "java.sql.*, javax.sql.*, java.io.*, javax.naming.*, java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "org.json.simple.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align = "center">
	<table border="1">
<%		
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	Context initCtx = new InitialContext();
	Context envCtx = (Context)initCtx.lookup("java:comp/env");

	DataSource ds = (DataSource)envCtx.lookup("jdbc/testdb");
	con = ds.getConnection();
    
	try {		
		String sql = "SELECT * from testtable";
		ps = con.prepareStatement(sql);
		rs = ps.executeQuery();
					
		while(rs.next())
		{
%>
			<tr>
				<td><%=rs.getString(1)%></td>
				<td><%=rs.getString(2)%></td>
			</tr>
<%
	
		}
		con.close();
		ps.close();
		rs.close();
		envCtx.close();
		initCtx.close();
	}
	catch(SQLException e) {
		System.out.println(e.getMessage());
	}
%>
</table></div>
</body>
</html>
