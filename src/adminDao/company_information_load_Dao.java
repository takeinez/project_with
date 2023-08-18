package adminDao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import adminDto.company_information_load_Dto;

public class company_information_load_Dao {
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public company_information_load_Dto getDto(String employee_id)throws Exception{
		Connection conn = getConnection();
		String sql="SELECT c.* FROM employees e , company c WHERE e.employee_id = ? AND e.company_id = c.company_id";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, employee_id);
		ResultSet rs = pstmt.executeQuery();
		
		company_information_load_Dto company_information_load_Dto = null;
		if(rs.next()){			
			int company_id = rs.getInt("company_id");
			String company_name = rs.getString("company_name");
			String company_URL = rs.getString("company_URL");
			String company_img = rs.getString("company_img");
			String company_version = rs.getString("company_version");
			int permission_downroad = rs.getInt("permission_downroad");
			int permission_duplication = rs.getInt("permission_duplication");
			String company_join_option = rs.getString("company_join_option");
			int use_department = rs.getInt("use_department");
			company_information_load_Dto = new company_information_load_Dto(company_id,company_name,company_URL,company_img,company_version,permission_downroad,
					permission_duplication,company_join_option,use_department);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return company_information_load_Dto;
	}
	
	
	
	public ArrayList<company_information_load_Dto> getDtoList(String employee_id) throws Exception{
		Connection conn = getConnection();
		String sql="SELECT c.* FROM employees e , company c WHERE e.employee_id = ? AND e.company_id = c.company_id";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, employee_id);
		ResultSet rs = pstmt.executeQuery();
		
		ArrayList<company_information_load_Dto> company_information_load_Dto_List = new ArrayList<company_information_load_Dto>();
		while(rs.next()) {
			company_information_load_Dto company_information_load_Dto = null;
			int company_id = rs.getInt("company_id");
			String company_name = rs.getString("company_name");
			String company_URL = rs.getString("company_URL");
			String company_img = rs.getString("company_img");
			String company_version = rs.getString("company_version");
			int permission_downroad = rs.getInt("permission_downroad");
			int permission_duplication = rs.getInt("permission_duplication");
			String company_join_option = rs.getString("company_join_option");
			int use_department = rs.getInt("use_department");
			company_information_load_Dto = new company_information_load_Dto(company_id,company_name,company_URL,company_img,company_version,permission_downroad,
					permission_duplication,company_join_option,use_department);
			company_information_load_Dto_List.add(company_information_load_Dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return company_information_load_Dto_List;
	}
	
}
