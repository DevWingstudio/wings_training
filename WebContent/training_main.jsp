<%@ page import = "java.sql.*, javax.sql.*, java.io.*, javax.naming.*, java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "org.json.simple.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%		
	// param_option - 1: insert 버튼, 2: select 버튼
	String param_option = request.getParameter("param_option");
	// param_insert - insert 버튼 눌렀을 때 받아올 parameter
	String param_insert = request.getParameter("param_insert");
	
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	Context initCtx = new InitialContext();
	Context envCtx = (Context)initCtx.lookup("java:comp/env");

	DataSource ds = (DataSource)envCtx.lookup("jdbc/testdb");
	con = ds.getConnection();
    
    // 클라이언트에서 넘어온 것이 있는지 체크
    if(param_option != null)
    {
    	// insert 버튼 눌렀을 때
    	if(param_option.equals("1"))
    	{
    		try {
    			String sql = "INSERT INTO testtable (`desc`) values ('"+param_insert+"')";
    			
    			ps = con.prepareStatement(sql);
    			ps.executeUpdate();
    			    			
    		} catch(SQLException e) {
    			System.out.println(e.getMessage());
    		}
    	}
    	
    	// select 버튼 눌렀을 때
    	else if(param_option.equals("2"))
    	{
    		try {
    			String sql = "SELECT * from testtable";
    			
    			ps = con.prepareStatement(sql);
				rs = ps.executeQuery();
				
				JSONArray arr = new JSONArray();
				
				 while(rs.next())
				{
					int id = rs.getInt("testtable_id");
					String desc = rs.getString("desc");
					
					JSONObject obj = new JSONObject();
					
					obj.put("id", id);
					obj.put("desc", desc);
					
					if(obj != null)
						arr.add(obj);
				}
				
				out.print(arr.toString());
			    arr.clear();
				
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
    	}
    }
    
	con.close();
	ps.close();
	rs.close();
	envCtx.close();
	initCtx.close();
	
%>
