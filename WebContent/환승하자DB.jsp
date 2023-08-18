<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("send_num"));
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
	String dbId = "alone";
	String dbPw = "1234";	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url,dbId,dbPw);
%>
<%
	switch(num) {
		case 0:
			String employee_id = request.getParameter("send_employee_id");
			int project_id = Integer.parseInt(request.getParameter("send_projectId"));
			int now_favorite = Integer.parseInt(request.getParameter("send_now_favorite"));
			String sql = "UPDATE personal_project_set SET favorite=? WHERE employee_id=? AND project_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			if(now_favorite==1){
			pstmt.setInt(1,0);
			}else{
			pstmt.setInt(1,1);
			}
			pstmt.setString(2,employee_id);
			pstmt.setInt(3,project_id);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			break;
		case 1:
			employee_id = request.getParameter("send_employee_id");
			int company_id = 0;
			int order = 0;
			int filter = 0;
			try{
			order = Integer.parseInt(request.getParameter("send_order"));
			filter = Integer.parseInt(request.getParameter("send_filter"));
			}catch(Exception e){
				order = 0;
				filter = 0;
			}
			sql = "SELECT * FROM employees WHERE employee_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, employee_id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				company_id = rs.getInt("company_id");
			}
			String filterWhere = "";
			String filterFrom = "";
			if(filter==1){
				filterFrom = " ,(SELECT * FROM project_member pmo WHERE pmo.project_admin=1 AND pmo.employee_id='"+employee_id+"') haha";
				filterWhere = " AND cp.project_id=haha.project_id";
			}
			String myWriteUpdate ="board";
			if(order==1){
				myWriteUpdate = " (SELECT * FROM board WHERE board_writer='"+employee_id+"') my ";
			}
			
			String orderString = " ORDER BY CASE WHEN recentupdate IS NULL THEN 1 ELSE 0 END, recentupdate DESC ";
			if(order==2){
				orderString = " ORDER BY project_name ASC ";
			}else if(order==3){
				orderString = " ORDER BY project_name DESC ";
			}
			
			sql = " SELECT cp.*, (SELECT COUNT(*) FROM project_member pm WHERE cp.project_id = pm.project_id) AS projectMemberCount,psps.* , recent.recentupdate"
				+ "	FROM (SELECT p.* FROM company c, project p WHERE c.company_id = p.company_id) cp "
				+ "	,(SELECT * FROM personal_project_set pps WHERE pps.employee_id=?) psps "
				+ "	,(SELECT project_id , max(regist_date) AS recentupdate FROM "+ myWriteUpdate +" group by project_id) recent "  +filterFrom                    
				+ "	WHERE cp.company_id=? AND psps.project_id=cp.project_id AND cp.project_id=recent.project_id(+) " +filterWhere
				+ orderString;
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, employee_id);
			pstmt.setInt(2, company_id);
			rs = pstmt.executeQuery();
			JSONArray array = new JSONArray();
			while(rs.next()){
				JSONObject obj = new JSONObject();
				obj.put("project_name", rs.getString("project_name"));
				obj.put("projectMemberCount",rs.getString("projectMemberCount"));
				obj.put("projectColor",rs.getInt("project_color"));
				obj.put("favorite",rs.getInt("favorite"));
				obj.put("project_case",rs.getInt("project_case"));
				obj.put("join_permission",rs.getInt("join_permission"));
				obj.put("project_id",rs.getInt("project_id"));
				obj.put("push_switch",rs.getInt("push_switch"));
				array.add(obj);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
			
			out.print(array);
			break;	
	}
%>