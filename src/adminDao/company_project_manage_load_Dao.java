package adminDao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import adminDto.company_project_manage_load_Dto;

public class company_project_manage_load_Dao {
	
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public ArrayList<company_project_manage_load_Dto> getDtoList(int company_id) throws Exception{
		Connection conn = getConnection();
		String sql = "SELECT p.*, (SELECT COUNT(*) FROM board WHERE project_id = p.project_id) AS board_count, \r\n" + 
				" (SELECT COUNT(*) FROM reply r, board b WHERE b.project_id = p.project_id AND r.board_id = b.board_id) AS reply_count\r\n" + 
				" FROM project p WHERE project_case = 3 AND company_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<company_project_manage_load_Dto> company_project_manage_load_Dto_List = new ArrayList<company_project_manage_load_Dto>();
		while(rs.next()) {
			company_project_manage_load_Dto company_project_manage_load_Dto = null;
			int project_id = rs.getInt("project_id");
			String project_name = rs.getString("project_name");
			String project_birthday = rs.getString("project_birthday");
			String recent_date = rs.getNString("recent_date");
			int board_count = rs.getInt("board_count");
			int reply_count = rs.getInt("reply_count");
			String register_id = rs.getString("register_id");
			company_project_manage_load_Dto = new company_project_manage_load_Dto(project_id, project_name, project_birthday, recent_date, board_count, reply_count, register_id);
			company_project_manage_load_Dto_List.add(company_project_manage_load_Dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return company_project_manage_load_Dto_List;
	}
	
	
	public ArrayList<company_project_manage_load_Dto> getDtoList(int company_id, String search_name) throws Exception{
		Connection conn = getConnection();
		String sql = "SELECT p.*, (SELECT COUNT(*) FROM board WHERE project_id = p.project_id) AS board_count, \r\n" + 
				" (SELECT COUNT(*) FROM reply r, board b WHERE b.project_id = p.project_id AND r.board_id = b.board_id) AS reply_count\r\n" + 
				" FROM project p WHERE project_case = 3 AND company_id = ? AND project_name LIKE ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		pstmt.setString(2, "%"+search_name+"%");
		ResultSet rs = pstmt.executeQuery();
		ArrayList<company_project_manage_load_Dto> company_project_manage_load_Dto_List = new ArrayList<company_project_manage_load_Dto>();
		while(rs.next()) {
			company_project_manage_load_Dto company_project_manage_load_Dto = null;
			int project_id = rs.getInt("project_id");
			String project_name = rs.getString("project_name");
			String project_birthday = rs.getString("project_birthday");
			String recent_date = rs.getNString("recent_date");
			int board_count = rs.getInt("board_count");
			int reply_count = rs.getInt("reply_count");
			String register_id = rs.getString("register_id");
			company_project_manage_load_Dto = new company_project_manage_load_Dto(project_id, project_name, project_birthday, recent_date, board_count, reply_count, register_id);
			company_project_manage_load_Dto_List.add(company_project_manage_load_Dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return company_project_manage_load_Dto_List;
	}

}
