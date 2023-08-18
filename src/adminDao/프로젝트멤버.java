package adminDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class 프로젝트멤버 {
	static void project_member_add(Connection conn, int project_id, String employee_id, int project_admin) throws Exception {
		String sql = "INSERT INTO project_member(PROJECT_ID, EMPLOYEE_ID, PROJECT_ADMIN, PROJECT_STATUS)" +
	    " VALUES(?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		pstmt.setString(2, employee_id);
		pstmt.setInt(3, project_admin);
		if(project_admin != 1) {
			if(!도우미.join_permission_check(conn, project_id)) 
				pstmt.setInt(4, 1);
			else
				pstmt.setInt(4, 0);
		}
		else {
			pstmt.setInt(4, 1);
		}
		
		pstmt.executeUpdate();
		pstmt.close();
	}
	
	static void project_member_invite(Connection conn, int project_id, String employee_id, int project_admin) throws Exception {
		String sql = "INSERT INTO project_member(PROJECT_ID, EMPLOYEE_ID, PROJECT_ADMIN, PROJECT_STATUS)" +
			    " VALUES(?, ?, ?, ?)";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, project_id);
				pstmt.setString(2, employee_id);
				pstmt.setInt(3, project_admin);
				pstmt.setInt(4, 4);
				
				pstmt.executeUpdate();
				pstmt.close();
	}
	
	static void project_member_delete(Connection conn, int project_id, String employee_id) throws Exception {
		String sql = "DELETE FROM project_member WHERE project_id = ? AND employee_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		pstmt.setString(2, employee_id);

		pstmt.executeUpdate();
		pstmt.close();
	}
	
	static int project_admin_check(Connection conn, int project_id) throws Exception {
		String sql = "SELECT * FROM project_member WHERE project_id = ? AND project_admin = 1";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		ResultSet rs = pstmt.executeQuery();
		int a = 0;
		while(rs.next() && a<=1) {
			a++;
		}
		rs.close();
		pstmt.close();
		return a;
	}
	
	static boolean admin_check(Connection conn, int project_id, String employee_id) throws Exception {
		String sql = "SELECT * FROM project_member WHERE project_id = ? AND employee_id = ? AND project_admin = 1";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		pstmt.setString(2, employee_id);
		ResultSet rs = pstmt.executeQuery();
		boolean a = rs.next();
		rs.close();
		return a;
	} 
	
	

}
