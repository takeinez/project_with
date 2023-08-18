package adminDao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import adminDto.category_Dto;

public class category_Dao {
	
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public void category_correction(category_Dto category_Dto) throws Exception {
		String sql = "UPDATE project_category SET category = ?, status = ? WHERE category_id = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, category_Dto.getCategory());
		pstmt.setInt(2, category_Dto.getStatus());
		pstmt.setInt(3, category_Dto.getCategory_id());
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
	}
	
	
	public void category_delete(int category_id) throws Exception {
		String sql = "DELETE FROM project_category WHERE category_id = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, category_id);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
	public void category_add(int company_id, category_Dto category_Dto2) throws Exception {
		String sql = "INSERT INTO project_category VALUES (seq_category.nextval, ?, ?, ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		pstmt.setString(2, category_Dto2.getCategory());
		pstmt.setInt(3, category_Dto2.getStatus());
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
	public ArrayList<category_Dto> category_load(int company_id) throws Exception {
		String sql = "SELECT * FROM project_category WHERE company_id = ? AND status = 1 ORDER BY category_id";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<category_Dto> list = new ArrayList<>();
		while(rs.next()) {
			 int category_id = rs.getInt("category_id");
			 String category = rs.getString("category");
			 int status = rs.getInt("status");
			 category_Dto category_Dto = new category_Dto(category_id, category, status);
			 list.add(category_Dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return list;
	}
	
}
