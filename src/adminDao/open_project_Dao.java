package adminDao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import adminDto.company_project_manage_load_Dto;
import adminDto.open_project_Dto;

public class open_project_Dao {
	
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public ArrayList<open_project_Dto> getDtoList(int company_id, String search_name) throws Exception{
		Connection conn = getConnection();
		String sql = "SELECT p.*, c.*, (SELECT COUNT(*) FROM board WHERE project_id = p.project_id) AS board_count,\r\n" + 
				"(SELECT COUNT(*) FROM reply r, board b WHERE b.project_id = p.project_id AND r.board_id = b.board_id) AS reply_count,\r\n" + 
				"(SELECT COUNT(*) FROM project_member pm WHERE p.project_id = pm.project_id) AS member_count\r\n" + 
				"FROM project p, project_category c WHERE p.category_id = c.category_id AND p.project_case = 2 AND p.company_id = ? AND p.project_name LIKE ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		pstmt.setString(2, "%"+search_name+"%");
		ResultSet rs = pstmt.executeQuery();
		ArrayList<open_project_Dto> open_project_Dto_List = new ArrayList<open_project_Dto>();
		while(rs.next()) {
			company_project_manage_load_Dto company_project_manage_load_Dto = null;
			int project_id = rs.getInt("project_id");
			String project_name = rs.getString("project_name");
			String project_birthday = rs.getString("project_birthday");
			String recent_date = rs.getString("recent_date");
			int member_count = rs.getInt("member_count");
			int board_count = rs.getInt("board_count");
			int reply_count = rs.getInt("reply_count");
			String register_id = rs.getString("register_id");
			int category_id = rs.getInt("category_id");
			String category = rs.getString("category");
			open_project_Dto open_project_Dto = new open_project_Dto(project_id, project_name, project_birthday, recent_date, member_count, board_count, reply_count, register_id, category_id, category);
			open_project_Dto_List.add(open_project_Dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return open_project_Dto_List;
	}

}
