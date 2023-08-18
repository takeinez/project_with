package adminDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class 도우미 {
	
	// 컴퍼니 아이디 가져오기(회사원 아이디 입력)
	static int load_company_id(Connection conn, String employee_id) throws Exception {
		String sql = "SELECT company_id FROM employees WHERE employee_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, employee_id);
		ResultSet rs = pstmt.executeQuery();
		int a = 0;
		while (rs.next()) {
			a = rs.getInt("company_id");
		}
		pstmt.close();
		rs.close();
		return a;
	}
	
	// 프로젝트 아이디 중복 체크(중복일시 true)
	static boolean project_id_duplicationCheck(Connection conn, int project_id) throws Exception {
		String sql = "SELECT project_id FROM project WHERE project_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		ResultSet rs = pstmt.executeQuery();
		boolean a = rs.next();
		return a;
	}
	
	// 투표 중복 체크(투표 아이디와 사원 아이디를 입력하면 투표 아이디에 연결되 있는 보드 아이디의 모든 투표 항목 중 하나라도 투표했는지 확인)
	static boolean vote_duplicationCheck(Connection conn, int vote_id, String employee_id) throws Exception {
		String sql = "SELECT vr.employee_id\r\n" + "FROM vote v, vote_user vr\r\n"
				+ "WHERE v.board_id = (SELECT board_id FROM vote WHERE vote_id = ?) AND vr.employee_id = ? AND v.vote_id = vr.vote_id";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, vote_id);
		pstmt.setString(2, employee_id);
		ResultSet rs = pstmt.executeQuery();
		boolean a = rs.next();
		pstmt.close();
		rs.close();
		return a;
	}

	// 프로젝트에 들어갈때 허락 받아야 하는지 확인
	static boolean join_permission_check(Connection conn, int project_id) throws Exception {
		String sql = "SELECT join_permission FROM project WHERE project_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		boolean a = false;
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			if (rs.getInt(1) == 1)
				a = true;
			else
				a = false;
		}
		return a;
	}

	// 가장 최근에 추가한 프로젝트 아이디를 가져옴
	static int load_project_id(Connection conn) throws Exception {
		String sql = "select project_id_sequence.currval from dual";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int a = 0;
		while (rs.next()) {
			a = rs.getInt(1);
		}
		return a;
	}

	// 가장 최근에 추가한 보드 아이디를 가져옴
	static int load_board_id(Connection conn) throws Exception {
		String sql = "select board_id_sequence.currval from dual";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int a = 0;
		while (rs.next()) {
			a = rs.getInt(1);
		}
		return a;
	}

	// 입력 받은 사원이 가장 최근에 추가한 보드 아이디를 가져옴
	static int load_board_id(Connection conn, String employee_id) throws Exception {
		String sql = "SELECT * FROM board" + " WHERE board_writer=? " + " ORDER BY regist_date DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, employee_id);
		ResultSet rs = pstmt.executeQuery();
		int board_id = 0;
		while (rs.next()) {
			board_id = rs.getInt("board_id");
			break;
		}
		pstmt.close();
		rs.close();
		return board_id;
	}

	// 프로젝트에 입력받은 사원이 이미 추가되있는지 확인
	static boolean employee_id_duplicationCheck(Connection conn, int project_id, String employee_id) throws Exception {
		String sql = "SELECT * FROM project_member WHERE project_id = ? AND employee_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		pstmt.setString(2, employee_id);
		ResultSet rs = pstmt.executeQuery();
		boolean a = rs.next();
		pstmt.close();
		rs.close();
		return a;
	}

	// 프로젝트 아이디를 입력받아 그 프로젝트의 board type5(투표)를 모두 받아옴
	static void select_from_board_vote(Connection conn, int project_id) throws Exception {
		String sql = "SELECT * FROM board WHERE project_id = ? AND board_type = 5";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			int board_id = rs.getInt(2);
			String title = rs.getString(4);
			String content = rs.getString(5);
			String A = board_id + "/" + title + "/" + content;
			sql = "SELECT * FROM vote WHERE board_id = " + board_id + "ORDER BY vote_id";
			PreparedStatement pstmt1 = conn.prepareStatement(sql);
			ResultSet rs1 = pstmt1.executeQuery();
			int i = 1;
			while (rs1.next()) {
				A += "\n";
				int vote_id = rs1.getInt(4);
				String vote_content = rs1.getString(2);
				A += vote_id + "." + vote_content;
				i++;
			}
			if (i == 1)
				A+="\n" + "투표 항목이 없습니다.";
		}
		pstmt.close();
		rs.close();
	}
	
	// 사원 아이디와 보트 아이디를 입력 받아 투표가 소속되 있는 보드가 소속되 있는 프로젝트에 사원이 있는지 확인
	static boolean vote_project_member_check(Connection conn, int vote_id, String employee_id) throws Exception { // vote_id와 employee_id를 입력 받으면 그 프로젝트에 속해 있는지 판별
		String sql = "SELECT * FROM vote v, project_member pm, board b \r\n" + 
				"WHERE b.board_id = v.board_id AND b.project_id = pm.project_id AND vote_id = ? AND employee_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, vote_id);
		pstmt.setNString(2, employee_id);
		ResultSet rs = pstmt.executeQuery();
		boolean a = rs.next();
		
		rs.close();
		pstmt.close();
		
		return a;
	}
	
	// 프로젝트 아이디를 입력받아 그 프로젝트의 board type4(투표)를 모두 받아옴
	static void select_from_todo(Connection conn, int project_id) throws Exception {
		String sql = "SELECT * FROM board WHERE project_id = ? AND board_type = 4";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			int board_id = rs.getInt(2);
			String title = rs.getString(4);
			String content = rs.getString(5);
			String A = board_id + "/" + title + "/" + content;
			sql = "SELECT * FROM todo WHERE board_id = " + board_id + "ORDER BY todo_id";
			PreparedStatement pstmt1 = conn.prepareStatement(sql);
			ResultSet rs1 = pstmt1.executeQuery();
			int i = 1;
			while (rs1.next()) {
				A += "\n";
				int todo_id = rs1.getInt(2);
				String todo_content = rs1.getString(3);
				String employee_id = rs1.getNString(4);
				int finish = rs1.getInt(5);
				String finish2 = "";
				if(finish == 0)
					finish2 = "아직 안함. 언능혀";
				else if(finish == 1) 
					finish2 = "다했쪙";
				A += todo_id + "." + todo_content + "/" + employee_id + "/" + finish2;
				i++;
			}
			if (i == 1)
				A+="\n" + "할 일 항목이 없습니다.";
		}
		pstmt.close();
		rs.close();
	}
	
	// 프로젝트 아이디를 입력받아서 그 프로젝트의 모든 글을 보여줌
	static void select_from_board(Connection conn, int project_id) throws Exception {
		String sql = "SELECT * FROM board WHERE project_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			int board_id = rs.getInt(2);
			String title = rs.getString(4);
			String content = rs.getString(5);
			String A = board_id + "/" + title + "/" + content;
		}
		pstmt.close();
		rs.close();
	}
}
