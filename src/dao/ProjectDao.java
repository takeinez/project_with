package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.ProjectDto;

public class ProjectDao {
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
	
	public ArrayList<ProjectDto> getProjectDto(String nowId) throws Exception {
	    Connection conn = getConnection();
	    System.out.println(1);
	    String sql = "SELECT p.*,pp.project_color ppp FROM project p JOIN personal_project_set pp ON p.project_id = pp.project_id"
	    		+ "  JOIN project_member pm ON  p.project_id = pm.project_id WHERE pm.employee_id=? "
	    		+ " ORDER BY p.recent_date DESC";
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, nowId);
	    ResultSet rs = pstmt.executeQuery();
	    ArrayList<ProjectDto> projectList = new ArrayList<ProjectDto>();
	    while (rs.next()) {
	        String title = rs.getString("project_name");
	        int id = rs.getInt("project_id");
	        int color = rs.getInt("ppp");
	        ProjectDto projectDto = new ProjectDto(title,color,id);
	        projectList.add(projectDto);
	    }
	    return projectList;
	}
	
}

