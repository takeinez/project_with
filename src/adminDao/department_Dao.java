package adminDao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import adminDto.department_Dto;

public class department_Dao {
	
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public ArrayList<department_Dto> getList(int company_id) throws Exception {
		String sql = "SELECT * FROM department WHERE company_id = ? ORDER BY exposure_procedure, department_id";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<department_Dto> list = new ArrayList<department_Dto>(); 
		while(rs.next()) {
			String department_name = rs.getString("department_name");
			int up_department_id = rs.getInt("up_department_id");
			int exposure_procedure = rs.getInt("exposure_procedure");
			int department_id = rs.getInt("department_id");
			department_Dto department_Dto = new department_Dto(company_id, department_name, up_department_id, exposure_procedure, department_id);
			list.add(department_Dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		return list;
		
	}
	
	public void add(department_Dto Dto) throws Exception {
		String sql = "INSERT INTO department VALUES(?, ?, ?, ?, department_sequence.NEXTVAL)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, Dto.getCompany_id());
		pstmt.setString(2, Dto.getDepartment_name());
		pstmt.setInt(3, Dto.getUp_department_id());
		pstmt.setInt(4, Dto.getExposure_procedure());
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
	}
	
	
	public void delete(int department_id) throws Exception {
		String sql = "DELETE FROM department WHERE department_id = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, department_id);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
	}
	
	public void department_correction(int department_id, String department_name) throws Exception {
		String sql = "UPDATE department SET department_name = ? WHERE department_id = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, department_name);
		pstmt.setInt(2, department_id);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
	}

}
