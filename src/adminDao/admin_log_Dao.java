package adminDao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import adminDto.admin_log_Dto;

public class admin_log_Dao {
	
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public ArrayList<admin_log_Dto> load(int company_id, String search_name, String start_date, String end_date, int search_gubun) throws Exception {
		String sql = "";
		switch(search_gubun) {
			case 1:
				sql = "SELECT al.*, e.employee_name FROM admin_log al, employees e WHERE al.admin = e.employee_id AND al.company_id = ? AND\r\n" + 
						"change_date BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') AND employee_name LIKE ? ORDER BY change_date DESC";
				break;
			case 2:
				sql = "SELECT al.*, e.employee_name FROM admin_log al, employees e WHERE al.admin = e.employee_id AND al.company_id = ? AND\r\n" + 
						"change_date BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') AND employee_id LIKE ? ORDER BY change_date DESC";
				break;
			case 3:
				sql = "SELECT al.*, e.employee_name FROM admin_log al, employees e WHERE al.admin = e.employee_id AND al.company_id = ? AND\r\n" + 
						"change_date BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') AND change_menu LIKE ? ORDER BY change_date DESC";
				break;
			case 4:
				sql = "SELECT al.*, e.employee_name FROM admin_log al, employees e WHERE al.admin = e.employee_id AND al.company_id = ? AND\r\n" + 
						"change_date BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') AND function LIKE ? ORDER BY change_date DESC";
				break;
		}
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		pstmt.setString(2, start_date);
		pstmt.setString(3, end_date);
		pstmt.setString(4, "%" + search_name + "%");
		ResultSet rs = pstmt.executeQuery();
		ArrayList<admin_log_Dto> list = new ArrayList<admin_log_Dto>();
		
		while(rs.next()) {
			String admin = rs.getString("admin");
			String change_menu = rs.getString("change_menu");
			String function = rs.getString("function");
			String object = rs.getString("object");
			String changes = rs.getString("changes");
			String changes_date = rs.getString("change_date");
			String employee_name = rs.getString("employee_name");
			
			admin_log_Dto admin_log_Dto = new admin_log_Dto(admin, employee_name, change_menu, function, object, changes, changes_date, company_id);
			list.add(admin_log_Dto);
		}
		
		
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return list;
		
	}
	
	public void add(admin_log_Dto Dto) throws Exception {
		String sql = "INSERT INTO admin_log VALUES (?, ?, ?, ?, ?, sysdate, ?)";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, Dto.getEmployee_id());
		pstmt.setString(2, Dto.getChange_menu());
		pstmt.setString(3, Dto.getFunction());
		pstmt.setString(4, Dto.getObject());
		pstmt.setString(5, Dto.getChanges());
		pstmt.setInt(6, Dto.getCompany_id());
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
	}
	
	public String employee_name_load(String employee_id) throws Exception {
		String sql = "SELECT employee_name FROM employees WHERE employee_id = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, employee_id);
		ResultSet rs = pstmt.executeQuery();
		String employee_name = "";
		if(rs.next()) {
			employee_name = rs.getString("employee_name");
		}
		rs.close();
		pstmt.close();
		return employee_name;
		
	}

}
