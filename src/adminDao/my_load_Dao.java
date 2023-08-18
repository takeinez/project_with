package adminDao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import adminDto.my_load_Dto;

public class my_load_Dao {
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public my_load_Dto getDto(String employee_id) throws Exception {
		Connection conn = getConnection();
		String sql = "SELECT * FROM employees e, department d WHERE d.department_id(+) = e.department_id AND employee_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, employee_id);
		ResultSet rs = pstmt.executeQuery();
		my_load_Dto my_load_Dto = null;
		while(rs.next()) {
			String employee_pw = rs.getString("employee_pw");
			String employee_name = rs.getString("employee_name");
			int company_id = rs.getInt("company_id");
			int department_id = rs.getInt("department_id");
			String job_title = rs.getString("job_title");
			String phone = rs.getString("phone");
			String phone_company = rs.getString("phone_company");
			String status_message = rs.getString("status_message");
			String join_date = rs.getString("join_date");
			int status = rs.getInt("status");
			String profile_img = rs.getString("profile_img");
			int company_admin = rs.getInt("company_admin");
			String department_name = rs.getString("department_name");
			my_load_Dto = new my_load_Dto(employee_id, employee_pw, employee_name, company_id, department_id, job_title, phone, phone_company, status_message, join_date, status, profile_img, company_admin, department_name);
		}
		return my_load_Dto;
	}

}
