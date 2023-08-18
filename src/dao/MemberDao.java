package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.MemberDto;

public class MemberDao {
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		System.out.println("접속성공");
		return conn;
	}
	
	public ArrayList<MemberDto> getMemberDto(String projectId) throws Exception {
	    Connection conn = getConnection();
	    String sql = "SELECT e.*,pm.*,c.* FROM employees e JOIN project_member pm ON e.employee_id = pm.employee_id JOIN company c ON e.company_id = c.company_id WHERE pm.project_id = ?";
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, projectId);
	    ResultSet rs = pstmt.executeQuery();
	    ArrayList<MemberDto> MemberList = new ArrayList<MemberDto>();
	    while (rs.next()) {
	        String name = rs.getString("employee_name");
	        String title = rs.getString("job_title");
	        String company = rs.getString("company_name");
	        MemberDto MemberDto = new MemberDto(name,title,company);
	        MemberList.add(MemberDto);
	    }
	    return MemberList;
	}
}
