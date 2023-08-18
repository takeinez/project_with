package adminDao;

import java.sql.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class 회사 {
	
	public static void company_img_correction(Connection conn, int company_id, String company_img) throws SQLException {
		String sql = "UPDATE company SET company_img = ? WHERE company_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, company_img);
		pstmt.setInt(2, company_id);
		pstmt.executeUpdate();
		pstmt.close();
	}
	
	public static void company_url_correction(Connection conn, int company_id, String company_url) throws SQLException {
		String sql = "UPDATE company SET company_url = ? WHERE company_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, company_url);
		pstmt.setInt(2, company_id);
		pstmt.executeUpdate();
		pstmt.close();
	}
	
	public static void company_join_option_correction(Connection conn, int company_id, String company_join_option) throws SQLException {
		String sql = "UPDATE company SET company_join_option = ? WHERE company_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, company_join_option);
		pstmt.setInt(2, company_id);
		pstmt.executeUpdate();
		pstmt.close();
	}
	
	public static String employees_manage_load(Connection conn, int company_id) throws SQLException {
		String sql = "SELECT e.*, c.company_name, d.department_name\r\n" + 
				"FROM employees e, company c, department d\r\n" + 
				"WHERE e.company_id = c.company_id AND e.department_id = d.department_id(+) AND c.company_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		ResultSet rs = pstmt.executeQuery();
		JSONArray array = new JSONArray();
		while(rs.next()) {
			JSONObject obj = new JSONObject();
			obj.put("employee_id", rs.getString("employee_id"));
			obj.put("employee_pw", rs.getString("employee_pw"));
			obj.put("employee_name", rs.getString("employee_name"));
			obj.put("company_id", rs.getInt("company_id"));
			obj.put("department_id", rs.getInt("department_id"));
			obj.put("job_title", rs.getString("job_title"));
			obj.put("phone", rs.getString("phone"));
			obj.put("phone_company", rs.getString("phone_company"));
			obj.put("status_message", rs.getString("status_message"));
			obj.put("join_date", rs.getString("join_date"));
			obj.put("status", rs.getString("status"));
			obj.put("profile_img", rs.getString("profile_img"));
			obj.put("company_admin", rs.getInt("company_admin"));
			obj.put("company_name", rs.getString("company_name"));
			obj.put("department_name", rs.getString("department_name"));
			array.add(obj);
		}
		
		rs.close();
		pstmt.close();
		
		return array.toJSONString();
	}
	
	public static void employee_status_correction_2(Connection conn, String employee_id) throws SQLException {
		String sql = "UPDATE employees SET status = 2 WHERE employee_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, employee_id);
		pstmt.executeUpdate();
		pstmt.close();
	}
	
	public static void employee_status_correction_1(Connection conn, String employee_id) throws SQLException {
	      String sql = "SELECT status FROM employees WHERE employee_id = ?";
	      PreparedStatement pstmt9 = conn.prepareStatement(sql);
	      pstmt9.setString(1, employee_id);
	      ResultSet rs3 = pstmt9.executeQuery();
	      int status = -1;
	      if(rs3.next()) {
	         status = rs3.getInt("status");
	      }
	      if(status == 2) {
	         
	      } else {
	         
	         sql = "INSERT INTO personal_folder VALUES(?, seq_folder.nextval, '마케팅')";
	         PreparedStatement pstmt6 = conn.prepareStatement(sql);
	         pstmt6.setString(1, employee_id);
	         pstmt6.executeUpdate();
	         pstmt6.close();
	         
	         sql = "INSERT INTO personal_folder VALUES(?, seq_folder.nextval, '디자인')";
	         PreparedStatement pstmt7 = conn.prepareStatement(sql);
	         pstmt7.setString(1, employee_id);
	         pstmt7.executeUpdate();
	         pstmt7.close();
	         
	         sql = "INSERT INTO personal_folder VALUES(?, seq_folder.nextval, '엔지니어링')";
	         PreparedStatement pstmt8 = conn.prepareStatement(sql);
	         pstmt8.setString(1, employee_id);
	         pstmt8.executeUpdate();
	         pstmt8.close();
	         
	         sql = "INSERT INTO personal_set(employee_id) VALUES(?)";
	         PreparedStatement pstmt10 = conn.prepareStatement(sql);
	         pstmt10.setString(1, employee_id);
	         pstmt10.executeUpdate();
	         pstmt10.close();
	         
	      }
	      
	      sql = "UPDATE employees SET status = 1 WHERE employee_id = ?";
	      PreparedStatement pstmt = conn.prepareStatement(sql);
	      pstmt.setString(1, employee_id);
	      pstmt.executeUpdate();
	      pstmt.close();
	      
	      sql = "SELECT p.project_id FROM project p WHERE p.company_id = (SELECT company_id FROM employees e WHERE e.employee_id = ?) AND p.project_case = 3 ORDER BY p.project_id";
	      PreparedStatement pstmt2 = conn.prepareStatement(sql);
	      pstmt2.setString(1, employee_id);
	      ResultSet rs = pstmt2.executeQuery();
	      while(rs.next()) {
	         int project_id = rs.getInt("project_id");
	         sql = "SELECT employee_id FROM project_member pm WHERE pm.project_id = ? AND pm.employee_id = ?";
	         PreparedStatement pstmt3 = conn.prepareStatement(sql);
	         pstmt3.setInt(1, project_id);
	         pstmt3.setString(2, employee_id);
	         ResultSet rs2 = pstmt3.executeQuery();
	         if(rs2.next()) {
	         } else {
	            sql = "INSERT INTO project_member VALUES(?, ?, 0, 1)";
	            PreparedStatement pstmt4 = conn.prepareStatement(sql);
	            pstmt4.setInt(1, project_id);
	            pstmt4.setString(2, employee_id);
	            pstmt4.executeUpdate();
	            pstmt4.close();
	            
	            sql = "INSERT INTO personal_project_set (employee_id, project_id) VALUES(?, ?)";
	            PreparedStatement pstmt5 = conn.prepareStatement(sql);
	            pstmt5.setString(1, employee_id);
	            pstmt5.setInt(2, project_id);
	            pstmt5.executeUpdate();
	            pstmt5.close();
	         }
	         rs2.close();
	         pstmt3.close();
	      }
	      rs.close();
	      pstmt2.close();
	   }
	
	public static void employee_delete(Connection conn, String employee_id) throws SQLException {
		String sql = "DELETE FROM employees WHERE employee_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);		
		pstmt.setString(1, employee_id);
		pstmt.executeUpdate();
		pstmt.close();
	}
	
	public static void employee_company_admin_0(Connection conn, String employee_id) throws SQLException {
		String sql = "UPDATE employees SET company_admin = 0 WHERE employee_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);		
		pstmt.setString(1, employee_id);
		pstmt.executeUpdate();
		pstmt.close();
	}
	
	public static void employee_company_admin_1(Connection conn, String employee_id) throws SQLException {
		String sql = "UPDATE employees SET company_admin = 1 WHERE employee_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);		
		pstmt.setString(1, employee_id);
		pstmt.executeUpdate();
		pstmt.close();
	}
	
	

}
