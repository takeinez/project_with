package adminDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class 프로젝트 {
	
	public static void create(Connection conn, int project_case, String project_name, String project_explanation,
			String employee_id, int company_id, Integer category_id, String project_url, int join_permission) throws Exception {
		String sql = "INSERT INTO project(Project_id, PROJECT_CASE, PROJECT_NAME, PROJECT_EXPLANATION, REGISTER_ID, " + 
				"COMPANY_ID, RECENT_DATE, PROJECT_BIRTHDAY, CATEGORY_ID, PROJECT_URL, JOIN_PERMISSION) "+ 
				"VALUES(PROJECT_ID_SEQUENCE.NEXTVAL , ?, ?, ?, ?, ?, sysdate, sysdate, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_case);
		pstmt.setString(2, project_name);
		pstmt.setString(3, project_explanation);
		pstmt.setString(4, employee_id);
		pstmt.setInt(5, company_id);
		if(category_id!=null) {
			pstmt.setInt(6, category_id);
		}
		pstmt.setString(7, project_url);
		pstmt.setInt(8, join_permission);
		
		
		pstmt.executeUpdate();
		pstmt.close();
		
		
	}
	
	
	static void correction(Connection conn, String project_name, String project_explanation, int category_id
			, int join_permission, int project_id) throws Exception {
		Scanner sc = new Scanner(System.in);
		String sql = "UPDATE project SET PROJECT_NAME = ?, PROJECT_EXPLANATION = ?, RECENT_DATE = sysdate, " + 
				"CATEGORY_ID = ?, JOIN_PERMISSION = ? WHERE project_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setNString(1, project_name);
		pstmt.setNString(2, project_explanation);
		pstmt.setInt(3, category_id);
		pstmt.setInt(4, join_permission);
		pstmt.setInt(5, project_id);
	

		
		pstmt.executeUpdate();
		
		pstmt.close();
	}
	
	public static void delete(Connection conn, int project_id) throws Exception {
		String sql = "DELETE FROM project WHERE project_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
	}
	
	public static String load(Connection conn, int company_id) throws SQLException {
		String sql = "SELECT p.*," +
				" (SELECT COUNT(*) FROM board WHERE project_id = p.project_id) AS board_count," +
				" (SELECT COUNT(*) FROM reply r, board b WHERE b.project_id = p.project_id AND r.board_id = b.board_id) AS reply_count," +
				" (0) AS chat_count," +
 				" (SELECT COUNT(*) FROM board WHERE project_id = p.project_id AND board.board_type=3) AS schedule_count," +
				" (SELECT COUNT(*) FROM board WHERE project_id = p.project_id AND board.board_type=2) AS work_count " +
				" FROM project p WHERE company_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		ResultSet rs = pstmt.executeQuery();
		JSONArray array = new JSONArray();
		while(rs.next()) {
			JSONObject obj = new JSONObject();
			int project_id = rs.getInt("project_id");
			obj.put("project_id", rs.getInt("project_id"));
			obj.put("project_case", rs.getInt("project_case"));
			obj.put("project_name", rs.getString("project_name"));
			obj.put("project_explanation", rs.getString("project_explanation"));
			obj.put("register_id", rs.getString("register_id"));
//			int company_id = rs.getInt("5");
			obj.put("recent_date", rs.getString("recent_date"));
			obj.put("project_birthday", rs.getString("project_birthday"));
			obj.put("category_id", rs.getInt("category_id"));
			obj.put("project_url", rs.getString("project_url"));
			obj.put("join_permission", rs.getString("join_permission"));
			obj.put("board_count", rs.getInt("board_count"));
			obj.put("reply_count", rs.getInt("reply_count"));
			obj.put("chat_count", rs.getInt("chat_count"));
			obj.put("schedule_count", rs.getInt("schedule_count"));
			obj.put("work_count", rs.getInt("work_count"));
			
			
			
			sql = "SELECT * FROM project_member p, employees e WHERE e.employee_id = p.employee_id AND p.project_id = ? AND p.project_status = 1";
			PreparedStatement pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, project_id);
			ResultSet rs2 = pstmt2.executeQuery();
			int project_member_count = 0;
			int project_admin_count = 0;
			while(rs2.next()) {
				project_member_count++;
				if(rs2.getInt("project_admin")==1) {
					project_admin_count++;
					String project_admin_name = "project_admin_name_" + project_admin_count;
					obj.put(project_admin_name, rs2.getString("employee_name"));
					String project_admin_id = "project_admin_id_" + project_admin_count;
					obj.put(project_admin_id, rs2.getString("employee_id"));
				}
			}
			rs2.close();
			pstmt2.close();
			obj.put("project_member_count", project_member_count);
			obj.put("project_admin_count", project_admin_count);
			
			
			
			array.add(obj);
		}
		rs.close();
		pstmt.close();
		
		return array.toJSONString();
	}
	
	
	public static void company_name_correction(Connection conn, int company_id, String company_name) throws SQLException {
		String sql = "UPDATE company SET company_name = ? WHERE company_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, company_name);
		pstmt.setInt(2, company_id);
		pstmt.executeUpdate();
		pstmt.close();
	}
	
	
	public static String project_information_load(Connection conn, int project_id) throws SQLException {
		String sql = "SELECT * FROM project p, project_permission pp WHERE p.project_id = pp.project_id(+) AND p.project_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		ResultSet rs = pstmt.executeQuery();
		JSONArray array = new JSONArray();
		while(rs.next()) {
			JSONObject obj = new JSONObject();
			obj.put("project_id", rs.getInt("project_id"));
			obj.put("project_case", rs.getInt("project_case"));
			obj.put("project_name", rs.getString("project_name"));
			obj.put("project_explanation", rs.getString("project_explanation"));
			obj.put("register_id", rs.getString("register_id"));
//			int company_id = rs.getInt("5");
			obj.put("recent_date", rs.getString("recent_date"));
			obj.put("project_birthday", rs.getString("project_birthday"));
			obj.put("category_id", rs.getInt("category_id"));
			obj.put("project_url", rs.getString("project_url"));
			obj.put("join_permission", rs.getString("join_permission"));
			
			obj.put("permission_write", rs.getInt("permission_write"));
			obj.put("permission_view", rs.getInt("permission_view"));
			obj.put("permission_reply", rs.getInt("permission_reply"));
			obj.put("permission_file", rs.getInt("permission_file"));
			obj.put("permission_modify", rs.getInt("permission_modify"));
			
			
			
			sql = "SELECT * FROM project_member p, employees e, department d WHERE p.employee_id = e.employee_id AND d.department_id(+) = e.department_id AND p.project_id = ?";
			PreparedStatement pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, project_id);
			ResultSet rs2 = pstmt2.executeQuery();
			int project_member_count = 0;
			while(rs2.next()) {
				project_member_count++;
				obj.put("project_member_id_" + project_member_count, rs2.getString("employee_id"));
				obj.put("project_member_name_" + project_member_count, rs2.getString("employee_name"));
				obj.put("project_member_department_name_" + project_member_count, rs2.getString("department_name"));
				obj.put("project_member_job_title_" + project_member_count, rs2.getString("job_title"));
				obj.put("project_member_join_date_" + project_member_count, rs2.getString("join_date"));
				obj.put("project_member_phone_" + project_member_count, rs2.getString("phone"));
				obj.put("project_member_project_admin_" + project_member_count, rs2.getInt("project_admin"));
			}
			obj.put("project_member_count", project_member_count);
			
			rs2.close();
			pstmt2.close();
			
			array.add(obj);
		}
		rs.close();
		pstmt.close();
		
		return array.toJSONString();
	}
	
	
	public static String project_information_load_member(Connection conn, int project_id) throws SQLException {
		String sql = "SELECT * FROM project_member p, employees e, department d WHERE p.employee_id = e.employee_id AND d.department_id(+) = e.department_id AND p.project_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		ResultSet rs = pstmt.executeQuery();
		JSONArray array = new JSONArray();
		while(rs.next()) {
			JSONObject obj = new JSONObject();
			obj.put("employee_id", rs.getString("employee_id"));
			obj.put("employee_name", rs.getString("employee_name"));
			obj.put("department_name", rs.getString("department_name"));
			obj.put("job_title", rs.getString("job_title"));
			obj.put("join_date", rs.getString("join_date"));
			obj.put("phone", rs.getString("phone"));
			obj.put("project_admin", rs.getInt("project_admin"));
			array.add(obj);
		}
		
		rs.close();
		pstmt.close();
		
		return array.toJSONString();
	}
	
	
	public static void project_information_admin_correction(Connection conn, String employee_id, int num,int project_id) throws SQLException {
		String sql = "UPDATE project_member SET project_admin = ? WHERE employee_id = ? AND project_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);		
		pstmt.setString(2, employee_id);
		pstmt.setInt(1, num);
		pstmt.setInt(3, project_id);
		pstmt.executeUpdate();
		pstmt.close();
		
	}
	
	
	public static void project_information_correction(Connection conn, int project_id, int num1, int num2, int num3, int num4, int num5, String project_name) throws SQLException {
		String sql = "UPDATE project_permission SET permission_write = ?, permission_view = ?, permission_reply = ?, permission_file = ?, permission_modify = ? WHERE project_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);		
		pstmt.setInt(1, num1);
		pstmt.setInt(2, num3);
		pstmt.setInt(3, num2);
		pstmt.setInt(4, num4);
		pstmt.setInt(5, num5);
		pstmt.setInt(6, project_id);
		pstmt.executeUpdate();
		pstmt.close();
		
		sql = "UPDATE project SET project_name = ? WHERE project_id = ?";
		PreparedStatement pstmt2 = conn.prepareStatement(sql);
		pstmt2.setString(1, project_name);
		pstmt2.setInt(2, project_id);
		pstmt2.executeUpdate();
		pstmt2.close();
	}
	
	public static String project_category_load(Connection conn, int company_id) throws SQLException {
		String sql = "SELECT pc.*, (SELECT COUNT(*) FROM project p WHERE category_id = pc.category_id) AS project_count FROM project_category pc WHERE pc.company_id = ?";
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setInt(1, company_id);
	    ResultSet rs = pstmt.executeQuery();
	    JSONArray array = new JSONArray();
	    while (rs.next()) {
	        JSONObject obj = new JSONObject();
	        obj.put("category_id", rs.getInt("category_id"));
	        obj.put("company_id", rs.getInt("company_id"));
	        obj.put("category", rs.getString("category"));
	        obj.put("project_count", rs.getInt("project_count"));
	        array.add(obj);
	    }
	    
	    rs.close();
	    pstmt.close();
	    
	    return array.toJSONString();
	}
	
	
	public static String open_project_manage_load(Connection conn, int company_id) throws SQLException {
		String sql = "SELECT p.*, pc.category, (SELECT COUNT(*) FROM project_member pm WHERE p.project_id = pm.project_id) AS project_member_count,\r\n" + 
				"(SELECT COUNT(*) FROM board b WHERE p.project_id = b.project_id) AS board_count, \r\n" + 
				"(SELECT COUNT(*) FROM board b, reply r WHERE p.project_id = b.project_id AND b.board_id = r.board_id) AS reply_count \r\n" + 
				"FROM project p, project_permission pp, project_category pc\r\n" + 
				"WHERE p.project_id = pp.project_id(+) AND p.category_id = pc.category_id(+) AND p.company_id = ? AND p.project_case = 2";
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setInt(1, company_id);
	    ResultSet rs = pstmt.executeQuery();
	    JSONArray array = new JSONArray();
	    while (rs.next()) {
	        JSONObject obj = new JSONObject();
	        obj.put("project_id", rs.getInt("project_id"));
	        obj.put("project_name", rs.getString("project_name"));
	        obj.put("category", rs.getString("category"));
	        obj.put("project_member_count", rs.getInt("project_member_count"));
	        obj.put("board_count", rs.getInt("board_count"));
	        obj.put("reply_count", rs.getInt("reply_count"));
	        obj.put("recent_date", rs.getString("recent_date"));
	        obj.put("project_birthday", rs.getString("project_birthday"));
	        
	        
//	        let project_id = json[i].project_id;
//			let project_name = json[i].project_name;
//			let project_birthday = json[i].project_birthday;
//			let recent_date = json[i].recent_date;
//			let board_count = json[i].board_count;
//			let reply_count = json[i].reply_count;
//			let register_id = json[i].register_id;
			
	        array.add(obj);
	    }
	    
	    rs.close();
	    pstmt.close();
	    
	    return array.toJSONString();
	}
	
	

}