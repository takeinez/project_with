<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="org.json.simple.*"%>
<%@page import="adminDao.*"%>
<%
	// 데이터베이스에 연결
    String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
	String dbid = "alone";
	String dbpw = "1234";
    
    // 드라이버를 가져옴
    Class.forName(driver);
    Connection conn = DriverManager.getConnection(url, dbid, dbpw);
    int num = Integer.parseInt(request.getParameter("send_number"));
    
    switch (num) {
    	case 1:
    		String employeeId = request.getParameter("send_id"); // employee_id 파라미터 값을 가져옴
		    String sql = "SELECT c.* FROM employees e , company c WHERE e.employee_id = ? AND e.company_id = c.company_id";
		    PreparedStatement pstmt = conn.prepareStatement(sql);
		    pstmt.setString(1, employeeId);
		    ResultSet rs = pstmt.executeQuery();
		    
		//     Json 형태로 변환
		    JSONArray array = new JSONArray();	// [], JSON 배열 생성 
		    while(rs.next()) {
		    	JSONObject obj = new JSONObject();	// {}, JSON 객체 생성
		        obj.put("company_id", rs.getInt("company_id"));
		        obj.put("company_name", rs.getString("company_name"));
		        obj.put("company_URL", rs.getString("company_url"));
		        obj.put("company_img", rs.getString("company_img"));
		        obj.put("company_version", rs.getString("company_version"));
		        obj.put("permission_downroad", rs.getString("permission_downroad"));
		        obj.put("permission_duplication", rs.getString("permission_duplication"));
		        obj.put("company_join_option", rs.getString("company_join_option"));
		        obj.put("use_department", rs.getString("use_department"));
		        obj.put("abc", "glo");        
		        array.add(obj);
		        
		    }    
		    out.println(array.toJSONString());	// Ajax는 출력된 데이터를 전송하므로 데이터를 출력해줘야 한다
			rs.close();
			pstmt.close();
			break;
			
	    	case 2:
	    		int company_id = Integer.parseInt(request.getParameter("send_id"));
	    		out.println(프로젝트.load(conn, company_id));
	    		break;
	    		
	    	case 3:
	    		company_id = Integer.parseInt(request.getParameter("send_id"));
	    		String company_name = request.getParameter("send_company_name");
	    		프로젝트.company_name_correction(conn, company_id, company_name);
	    		break;
	    		
	    	case 4:
	    		company_id = Integer.parseInt(request.getParameter("send_id"));
	    		String company_img = request.getParameter("send_company_img");
	    		회사.company_img_correction(conn, company_id, company_img);
	    		break;
	    		
	    	case 5:
	    		company_id = Integer.parseInt(request.getParameter("send_id"));
	    		String company_url = request.getParameter("send_company_url");
	    		회사.company_url_correction(conn, company_id, company_url);
	    		break;
	    		
	    	case 6:
	    		company_id = Integer.parseInt(request.getParameter("send_id"));
	    		String company_join_option = request.getParameter("send_company_join_option");
	    		회사.company_join_option_correction(conn, company_id, company_join_option);
	    		break;
	    		
	    	case 7:
	    		company_id = Integer.parseInt(request.getParameter("send_id"));
	    		out.println(회사.employees_manage_load(conn, company_id));
	    		break;
	    		
	    	case 8:
	    		String employee_id = request.getParameter("send_employee_id");
	    		회사.employee_status_correction_2(conn, employee_id);
	    		break;
	    		
	    	case 9:
	    		employee_id = request.getParameter("send_employee_id");
	    		회사.employee_status_correction_1(conn, employee_id);
	    		break;
	    		
	    	case 10:
	    		employee_id = request.getParameter("send_employee_id");
	    		회사.employee_delete(conn, employee_id);
	    		break;
	    		
	    	case 11:
	    		employee_id = request.getParameter("send_employee_id");
	    		회사.employee_company_admin_0(conn, employee_id);
	    		break;
	    		
	    	case 12:
	    		employee_id = request.getParameter("send_employee_id");
	    		회사.employee_company_admin_1(conn, employee_id);
	    		break;
	    		
	    	case 13:
	    		int project_id = Integer.parseInt(request.getParameter("send_project_id"));
	    		out.println(프로젝트.project_information_load(conn, project_id));
	    		break;
	    		
	    	case 14:
	    		project_id = Integer.parseInt(request.getParameter("send_project_id"));
	    		out.println(프로젝트.project_information_load_member(conn, project_id));
	    		break;
	    		
	    	case 15:
	    		employee_id = request.getParameter("send_employee_id");
	    		project_id = Integer.parseInt(request.getParameter("send_project_id"));
	    		num = 1;
	    		프로젝트.project_information_admin_correction(conn, employee_id, num,project_id);
	    		break;
	    		
	    	case 16:
	    		employee_id = request.getParameter("send_employee_id");
	    		project_id = Integer.parseInt(request.getParameter("send_project_id"));
	    		num = 0;
	    		프로젝트.project_information_admin_correction(conn, employee_id, num,project_id);
	    		break;
	    		
	    	case 17:
	    		project_id = Integer.parseInt(request.getParameter("send_project_id"));
	    		int num1 = Integer.parseInt(request.getParameter("send_num1"));
	    		int num2 = Integer.parseInt(request.getParameter("send_num2"));
	    		int num3 = Integer.parseInt(request.getParameter("send_num3"));
	    		int num4 = Integer.parseInt(request.getParameter("send_num4"));
	    		int num5 = Integer.parseInt(request.getParameter("send_num5"));
	    		String project_name = request.getParameter("send_project_name");
// 	    		System.out.println(num1);
// 	    		System.out.println(num2);
// 	    		System.out.println(num3);
// 	    		System.out.println(num4);
// 	    		System.out.println(num5);
	    		num = 0;
	    		프로젝트.project_information_correction(conn, project_id, num1, num2, num3, num4, num5, project_name);
	    		break;
	    		
	    	case 18:
	    		project_id = Integer.parseInt(request.getParameter("send_project_id"));
	    		프로젝트.delete(conn, project_id);
	    		break;
	    		
	    	case 19:
	    	    company_id = Integer.parseInt(request.getParameter("send_id"));
	    	 	out.println(프로젝트.project_category_load(conn, company_id));
	    	    break;
	    	    
	    	case 20:
	    		company_id = Integer.parseInt(request.getParameter("send_id"));
	    		System.out.println(company_id);
	    		out.println(프로젝트.open_project_manage_load(conn, company_id));
	    		break;
	    	    

    }
	
	
    
	
	conn.close();
	
	
%>