package adminDao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import adminDto.project_category_Dto;

public class project_category_Dao {
	
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public ArrayList<project_category_Dto> getDtoList(int company_id) throws Exception {
		String sql = "SELECT pc.*, (SELECT COUNT(*) FROM project p WHERE p.category_id = pc.category_id) AS project_count FROM project_category pc WHERE company_id = ? ORDER BY category_id";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<project_category_Dto> project_category_Dto_List = new ArrayList();
		while(rs.next()) {
			int category_id = rs.getInt("category_id");
			String category = rs.getString("category");
			int status = rs.getInt("status");
			int project_count = rs.getInt("project_count");
			project_category_Dto project_category_Dto = new project_category_Dto(category_id, company_id, category, status, project_count);
			project_category_Dto_List.add(project_category_Dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return project_category_Dto_List;
		
	}
	
	public void project_information_correction_category(int project_id, int category_id) throws Exception {
		String sql = "UPDATE project SET category_id = ? WHERE project_id = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, category_id);
		pstmt.setInt(2, project_id);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}

}
