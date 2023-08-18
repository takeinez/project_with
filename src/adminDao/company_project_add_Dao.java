package adminDao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class company_project_add_Dao {
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public void project(String project_name, String employee_id, int company_id) throws Exception {
		Connection conn = getConnection();
		String sql = "INSERT INTO project(Project_id, PROJECT_CASE, PROJECT_NAME, PROJECT_EXPLANATION, REGISTER_ID, \r\n" + 
				"COMPANY_ID, RECENT_DATE, PROJECT_BIRTHDAY, CATEGORY_ID, PROJECT_URL, JOIN_PERMISSION) \r\n" + 
				"VALUES(PROJECT_ID_SEQUENCE.NEXTVAL , 3, ?, null, ?, ?, sysdate, sysdate, null, null, 1)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, project_name);
		pstmt.setString(2, employee_id);
		pstmt.setInt(3, company_id);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	public void project_permission(String employee_id, int num1, int num2, int num3, int num4, int num5) throws Exception {
		Connection conn = getConnection();
		String sql = "INSERT INTO project_permission VALUES((SELECT *\r\n" + 
				"FROM (SELECT project_id FROM project WHERE register_id = ? ORDER BY project_birthday DESC)\r\n" + 
				"WHERE rownum=1), ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, employee_id);
		pstmt.setInt(2, num1);
		pstmt.setInt(3, num3);
		pstmt.setInt(4, num2);
		pstmt.setInt(5, num4);
		pstmt.setInt(6, num5);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	public void project_member(int company_id, String employee_id, int num1, int num2, int num3, int num4, int num5) throws Exception {
		Connection conn = getConnection();
		String sql = "SELECT employee_id FROM employees WHERE company_id = ? AND status = 1";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			sql = "INSERT INTO project_member VALUES((SELECT *\r\n" + 
					"FROM (SELECT project_id FROM project WHERE register_id = ? ORDER BY project_birthday DESC)WHERE rownum=1)\r\n" + 
					", ?, ?, 1)";
			PreparedStatement pstmt2 = conn.prepareStatement(sql);
			pstmt2.setString(1, employee_id);
			pstmt2.setString(2, rs.getString("employee_id"));
			if(employee_id.equals(rs.getString("employee_id"))) {
				pstmt2.setInt(3, 1);
				System.out.println(employee_id + " @");
				System.out.println(rs.getString("employee_id"));
				System.out.println(1);
			} else {
				pstmt2.setInt(3, 0);
				System.out.println(employee_id + " @");
				System.out.println(rs.getString("employee_id"));				
				System.out.println(0);
			}
			pstmt2.executeUpdate();
			pstmt2.close();
		}
		pstmt.close();
		conn.close();
	}
	
	public void personal_project_set(int company_id, String employee_id) throws Exception {
		Connection conn = getConnection();
		String sql = "SELECT employee_id FROM employees WHERE company_id = ? AND status = 1";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			sql = "INSERT INTO personal_project_set VALUES(?, (SELECT *\r\n" + 
					"FROM (SELECT project_id FROM project WHERE register_id = ? ORDER BY project_birthday DESC)WHERE rownum=1)\r\n" + 
					", null, null, null, null, null, null, null,1)";
			PreparedStatement pstmt2 = conn.prepareStatement(sql);
			pstmt2.setString(1, rs.getString("employee_id"));
			pstmt2.setString(2, employee_id);
			pstmt2.executeUpdate();
			pstmt2.close();
		}
		pstmt.close();
		conn.close();
	}
	
	public String project_id_load(String employee_id) throws Exception {
		Connection conn = getConnection();
		String sql = "SELECT * FROM project WHERE register_id = ? ORDER BY project_birthday DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, employee_id);
		ResultSet rs = pstmt.executeQuery();
		String project_id = "";
		while(rs.next()) {
			project_id = rs.getString("project_id");
			break;
		}
		return project_id;
	}
}
