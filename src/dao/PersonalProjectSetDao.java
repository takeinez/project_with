package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.PersonalFolderDto;
import dto.PersonalPushDto;
import dto.WithDto;

public class PersonalProjectSetDao {
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	public void personalProjectColor(int project_id,int color_code) throws Exception {
		Connection conn = getConnection();
		String sql = "UPDATE personal_project_set SET project_color=? WHERE project_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, color_code);
		pstmt.setInt(2, project_id);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	public ArrayList<PersonalFolderDto> loadPersonalFolder(String id) throws Exception {
		
		Connection conn = getConnection();
		String sql = "SELECT * FROM personal_folder WHERE employee_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<PersonalFolderDto> pfd = new ArrayList<PersonalFolderDto>();
		while(rs.next()) {
			int folder_id = rs.getInt("folder_id");
			String employee_id = rs.getString("employee_id");
			String folder_name = rs.getString("folder_name");
			PersonalFolderDto pto = new PersonalFolderDto(folder_id,employee_id,folder_name);
			pfd.add(pto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		
		return pfd;
	}
	public void project_folder_set(int projectId,int folderId) throws Exception {
		Connection conn = getConnection();
		PreparedStatement pstmt;
		String sql = null;
		if(folderId==0) {
			sql = "UPDATE personal_project_set SET folder_id=null WHERE project_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, projectId);
			pstmt.executeUpdate();
		}else {
			sql = "UPDATE personal_project_set SET folder_id=? WHERE project_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, folderId);
			pstmt.setInt(2, projectId);
			pstmt.executeUpdate();
		}
		pstmt.close();
		conn.close();
	}
	public ArrayList<PersonalPushDto> project_push_switch(String employee_id,int projectId) throws Exception {
		Connection conn = getConnection();
		String sql = "SELECT * FROM personal_project_set WHERE employee_id=? AND project_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, employee_id);
		pstmt.setInt(2, projectId);
		ArrayList<PersonalPushDto> ppd= new ArrayList<PersonalPushDto>();
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			int push_switch = rs.getInt("push_switch");
			int push_post = rs.getInt("push_post");
			int push_reply = rs.getInt("push_reply");
			int push_notification_list_set = rs.getInt("notification_list_set");
			PersonalPushDto pto = new PersonalPushDto(push_switch,push_post,push_reply,push_notification_list_set);
			ppd.add(pto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ppd;
		
	}
	public void project_push_set(String id,int pro_id,int push_switch,int board_push,int reply_push,int notification_list) throws Exception {
		Connection conn = getConnection();
		String sql = "UPDATE personal_project_set SET push_switch=?, push_post=?, push_reply=?, notification_list_set=? WHERE employee_id = ? AND project_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, push_switch);
		pstmt.setInt(2, board_push);
		pstmt.setInt(3, reply_push);
		pstmt.setInt(4, notification_list);
		pstmt.setString(5, id);
		pstmt.setInt(6, pro_id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	public void project_hide(String id,int pro_id) throws Exception {
		Connection conn = getConnection();
		String sql = "UPDATE personal_project_set SET hide = 1 WHERE employee_id = ? AND project_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setInt(2, pro_id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	public void project_hide_cancel(String id,int pro_id) throws Exception {
		Connection conn = getConnection();
		String sql = "UPDATE personal_project_set SET hide = 0 WHERE employee_id = ? AND project_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setInt(2, pro_id);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
}






















