package adminDao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import adminDto.project_manage_load_Dto;

public class project_manage_load_Dao {
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public ArrayList<project_manage_load_Dto> getDtoList(int company_id) throws Exception{
		Connection conn = getConnection();
		String sql = "SELECT p.*," +
				" (SELECT COUNT(*) FROM board WHERE project_id = p.project_id) AS board_count," +
				" (SELECT COUNT(*) FROM reply r, board b WHERE b.project_id = p.project_id AND r.board_id = b.board_id) AS reply_count," +
				" (0) AS chat_count," +
 				" (SELECT COUNT(*) FROM board WHERE project_id = p.project_id AND board.board_type=3) AS schedule_count," +
				" (SELECT COUNT(*) FROM board WHERE project_id = p.project_id AND board.board_type=2) AS work_count " +
				" FROM project p WHERE company_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<project_manage_load_Dto> project_manage_load_Dto_List = new ArrayList<project_manage_load_Dto>();
		while(rs.next()) {
			project_manage_load_Dto project_manage_load_Dto = null;
			int project_id = rs.getInt("project_id");
			int project_case = rs.getInt("project_case");
			String project_name =  rs.getString("project_name");
			String project_explanation = rs.getString("project_explanation");
			String register_id = rs.getString("register_id");
//			int company_id = rs.getInt("5");
			String recent_date = rs.getString("recent_date");
			String project_birthday = rs.getString("project_birthday");
			int category_id = rs.getInt("category_id");
			String project_url = rs.getString("project_url");
			String join_permission = rs.getString("join_permission");
			int board_count = rs.getInt("board_count");
			int reply_count = rs.getInt("reply_count");
			int chat_count = rs.getInt("chat_count");
			int schedule_count = rs.getInt("schedule_count");
			int work_count = rs.getInt("work_count");
//			project_manage_load_Dto = new project_manage_load_Dto(project_id, project_case, project_name, project_explanation,
//					register_id, recent_date, project_birthday, category_id, project_url, join_permission, board_count, reply_count,
//					chat_count, schedule_count, work_count);
			
			
			sql = "SELECT * FROM project_member p, employees e WHERE e.employee_id = p.employee_id AND p.project_id = ? AND p.project_status = 1";
			PreparedStatement pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, project_id);
			ResultSet rs2 = pstmt2.executeQuery();
			int project_member_count = 0;
			int project_admin_count = 0;
			String project_admin_id = null;
			String project_admin_name = null;
			while(rs2.next()) {
				project_member_count++;
				if(rs2.getInt("project_admin")==1) {
					project_admin_count++;
					if(project_admin_count<=1) {
						project_admin_id = "project_admin_id_" + project_admin_count;
						project_admin_name = "project_admin_name_" + project_admin_count;
					}
				}
			}
			rs2.close();
			pstmt2.close();
			
			
			project_manage_load_Dto = new project_manage_load_Dto(project_id, project_case, project_name, project_explanation, 
					register_id, recent_date, project_birthday, category_id, project_url, join_permission, board_count, 
					reply_count, chat_count, schedule_count, work_count, project_member_count, project_admin_count, 
					project_admin_id, project_admin_name);
			
			
			project_manage_load_Dto_List.add(project_manage_load_Dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return project_manage_load_Dto_List;
	}
	
	public ArrayList<project_manage_load_Dto> getDtoList(int company_id, String search_name, String start_date, String end_date) throws Exception{
		Connection conn = getConnection();
		String sql = "SELECT p.*," +
				" (SELECT COUNT(*) FROM board WHERE project_id = p.project_id) AS board_count," +
				" (SELECT COUNT(*) FROM reply r, board b WHERE b.project_id = p.project_id AND r.board_id = b.board_id) AS reply_count," +
				" (0) AS chat_count," +
 				" (SELECT COUNT(*) FROM board WHERE project_id = p.project_id AND board.board_type=3) AS schedule_count," +
				" (SELECT COUNT(*) FROM board WHERE project_id = p.project_id AND board.board_type=2) AS work_count " +
				" FROM project p WHERE company_id = ? AND recent_date BETWEEN TO_DATE(?, 'YYYY-MM-DD') AND TO_DATE(?, 'YYYY-MM-DD') AND p.project_name LIKE ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, company_id);
		pstmt.setString(2, start_date);
		pstmt.setString(3, end_date);
		pstmt.setString(4, "%" + search_name + "%");
		ResultSet rs = pstmt.executeQuery();
		ArrayList<project_manage_load_Dto> project_manage_load_Dto_List = new ArrayList<project_manage_load_Dto>();
		while(rs.next()) {
			project_manage_load_Dto project_manage_load_Dto = null;
			int project_id = rs.getInt("project_id");
			int project_case = rs.getInt("project_case");
			String project_name =  rs.getString("project_name");
			String project_explanation = rs.getString("project_explanation");
			String register_id = rs.getString("register_id");
//			int company_id = rs.getInt("5");
			String recent_date = rs.getString("recent_date");
			String project_birthday = rs.getString("project_birthday");
			int category_id = rs.getInt("category_id");
			String project_url = rs.getString("project_url");
			String join_permission = rs.getString("join_permission");
			int board_count = rs.getInt("board_count");
			int reply_count = rs.getInt("reply_count");
			int chat_count = rs.getInt("chat_count");
			int schedule_count = rs.getInt("schedule_count");
			int work_count = rs.getInt("work_count");
//			project_manage_load_Dto = new project_manage_load_Dto(project_id, project_case, project_name, project_explanation,
//					register_id, recent_date, project_birthday, category_id, project_url, join_permission, board_count, reply_count,
//					chat_count, schedule_count, work_count);
			
			
			sql = "SELECT * FROM project_member p, employees e WHERE e.employee_id = p.employee_id AND p.project_id = ? AND p.project_status = 1";
			PreparedStatement pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, project_id);
			ResultSet rs2 = pstmt2.executeQuery();
			int project_member_count = 0;
			int project_admin_count = 0;
			String project_admin_id = null;
			String project_admin_name = null;
			while(rs2.next()) {
				project_member_count++;
				if(rs2.getInt("project_admin")==1) {
					project_admin_count++;
					if(project_admin_count<=1) {
						project_admin_id = "project_admin_id_" + project_admin_count;
						project_admin_name = rs2.getString("employee_name");
					}
				}
			}
			rs2.close();
			pstmt2.close();
			
			
			project_manage_load_Dto = new project_manage_load_Dto(project_id, project_case, project_name, project_explanation, 
					register_id, recent_date, project_birthday, category_id, project_url, join_permission, board_count, 
					reply_count, chat_count, schedule_count, work_count, project_member_count, project_admin_count, 
					project_admin_id, project_admin_name);
			
			
			project_manage_load_Dto_List.add(project_manage_load_Dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return project_manage_load_Dto_List;
	}
	

}
