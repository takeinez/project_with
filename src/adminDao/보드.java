package adminDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class 보드 {
	public static void m() { }
	// 게시글 쓰기 공통
	public static void board_create(Connection conn, int project_id, int board_type, String board_title, String board_content,
			String employee_id, int public_scope, int temporary_save) throws Exception {
		String sql = "INSERT INTO board(PROJECT_ID, BOARD_ID, BOARD_TYPE, BOARD_TITLE, "
				+ "BOARD_CONTENT, BOARD_WRITER, REGIST_DATE, PUBLIC_SCOPE, TEMPORARY_SAVE, HITS) "
				+ "VALUES(?, BOARD_ID_SEQUENCE.NEXTVAL, ?, ?, ?, ?, sysdate, ?, ?, 0)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, project_id);
		pstmt.setInt(2, board_type);
		pstmt.setString(3, board_title);
		pstmt.setString(4, board_content);
		pstmt.setString(5, employee_id);
		pstmt.setInt(6, public_scope);
		pstmt.setInt(7, temporary_save);
		pstmt.executeUpdate();

		pstmt.close();
	}
	
	// 게시글 쓰기(투표)
	static void board_vote_create(Connection conn, int board_id, String vote_deadline, int hour, int minute,
			int revenge_vote, int anonymous_vote, int anyone_add, int hidden_poll, int result_time) throws Exception {
		String sql = "INSERT INTO board_vote(BOARD_ID, VOTE_DEADLINE, REVENGE_VOTE, ANONYMOUS_VOTE, "
				+ "ANYONE_ADD, HIDDEN_POLL, RESULT_TIME) "
				+ "VALUES(?, to_date(?,'YYYY-MM-DD HH24:MI'), ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_id);
		String deadline = vote_deadline + " " + hour + ":" + minute;
		pstmt.setString(2, deadline);
		pstmt.setInt(3, revenge_vote);
		pstmt.setInt(4, anonymous_vote);
		pstmt.setInt(5, anyone_add);
		pstmt.setInt(6, hidden_poll);
		pstmt.setInt(7, result_time);

		pstmt.executeUpdate();

		pstmt.close();
	}
	
	// 투표 추가하기
	static void vote_create(Connection conn, int board_id, String vote_content, String image) throws Exception {
		String sql = "INSERT INTO vote(BOARD_ID, VOTE_CONTENT, IMAGE, VOTE_ID) "
				+ "VALUES(?, ?, ?, VOTE_ID_SEQUENCE.nextval)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_id);
		pstmt.setString(2, vote_content);
		pstmt.setString(3, image);

		pstmt.executeUpdate();

		pstmt.close();

	}
	
	// 투표하기(중복투표 고려)
	static void vote(Connection conn, int vote_id, String employee_id) throws Exception {
		String sql = "SELECT bv.* FROM board_vote bv,vote v" + " WHERE v.board_id=bv.board_id AND v.vote_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, vote_id);
		ResultSet rs = pstmt.executeQuery();
		int revenge_vote = 0;
		while (rs.next()) {
			revenge_vote = rs.getInt(3);
		}
		if (revenge_vote == 1) {
			sql = "INSERT INTO vote_user(VOTE_ID, EMPLOYEE_ID) " + "VALUES(?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vote_id);
			pstmt.setString(2, employee_id);

			pstmt.executeUpdate();
			System.out.println("투표하였습니다.");

		} else {
			if (!도우미.vote_duplicationCheck(conn, vote_id, employee_id)) {
				sql = "INSERT INTO vote_user(VOTE_ID, EMPLOYEE_ID) " + "VALUES(?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, vote_id);
				pstmt.setString(2, employee_id);

				pstmt.executeUpdate();

				pstmt.close();
				System.out.println("투표하였습니다.");
			} else
				System.out.println("중복투표가 불가합니다.");
		}
		pstmt.close();
		rs.close();
	}
	
	// 투표 현황 확인하기
	static void vote_resul(Connection conn, int board_id) throws Exception {
		String A = "";
		String sql = "SELECT * FROM board WHERE board_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_id);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			A += board_id + "/" + rs.getNString("board_title") + "/" + rs.getNString("board_content");
		}
		sql = "SELECT * FROM vote WHERE board_id = ? ORDER BY vote_id";
		PreparedStatement pstmt1 = conn.prepareStatement(sql);
		pstmt1.setInt(1, board_id);
		ResultSet rs1 = pstmt1.executeQuery();
		int j = 0;
		while (rs1.next()) {
			A += "\n";
			int vote_id = rs1.getInt("vote_id");
			String vote_content = rs1.getString("vote_content");
			A += vote_id + "." + vote_content;

			sql = "SELECT COUNT(*) FROM vote_user WHERE vote_id = ?";
			PreparedStatement pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, vote_id);
			ResultSet rs2 = pstmt2.executeQuery();
			if (rs2.next()) {
				j = rs2.getInt(1);
			}
			pstmt2.close();
			rs2.close();
			A += "/" + j;
		}
		pstmt1.close();
		rs1.close();
	}
	
	// 투표 현황 확인하기
	static void result(Connection conn, int board_id) throws Exception {
		String sql = "SELECT * FROM board WHERE board_id = ?";
		PreparedStatement pstmt2 = conn.prepareStatement(sql);
		pstmt2.setInt(1, board_id);
		ResultSet rs2 = pstmt2.executeQuery();
		String A = "";
		while (rs2.next()) {
			A += board_id + "/" + rs2.getString("board_title") + "/" + rs2.getString("board_content");
			sql = "SELECT * FROM vote WHERE board_id = " + board_id + " ORDER BY vote_id";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			int j;
			while (rs.next()) {
				A += "\n";
				int vote_id = rs.getInt(4);
				String vote_content = rs.getString(2);
				A += vote_id + "." + vote_content;
				sql = "SELECT * FROM vote_user WHERE vote_id = " + vote_id;
				PreparedStatement pstmt1 = conn.prepareStatement(sql);
				ResultSet rs1 = pstmt1.executeQuery();
				j = 0;
				while (rs1.next()) {
					j++;
				}
				A += "/" + j;
				rs1.close();
				pstmt1.close();
			}
			rs.close();
			pstmt.close();
		}
		rs2.close();
		pstmt2.close();
	}
	
	// 할 일 추가하기
	static void todo_create(Connection conn, int board_id, String content, String employee_id, int finish,
			String vote_deadline) throws Exception {
		String sql = "INSERT INTO todo VALUES(?, TODO_SEQUENCE.NEXTVAL, ?, ?, ?, to_date(?,'YYYY-MM-DD'))";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_id);
		pstmt.setNString(2, content);
		pstmt.setNString(3, employee_id);
		pstmt.setInt(4, finish);
		String deadline = vote_deadline;
		pstmt.setString(5, deadline);
		pstmt.executeUpdate();
		pstmt.close();
	}
	
	// 할 일 1,0 상태 변경하기
	static void todo_change(Connection conn, int finish, int todo_id) throws Exception {
		String sql = "UPDATE todo SET finish = ? WHERE todo_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, finish);
		pstmt.setInt(2, todo_id);
		pstmt.executeUpdate();

		pstmt.close();
		
	}
	
	// 할 일 삭제하기
	static void todo_delete(Connection conn, int todo_id) throws Exception {
		String sql = "DELETE FROM todo WHERE todo_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, todo_id);
		pstmt.executeUpdate();

		pstmt.close();
	}
	
	// 투표 삭제하기
	static void vote_delete(Connection conn, int vote_id) throws Exception {
		String sql = "DELETE FROM vote WHERE vote_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, vote_id);
		pstmt.executeUpdate();

		pstmt.close();
	}
	
	// 보드 삭제하기
	static void board_delete(Connection conn, int board_id) throws Exception {
		String sql = "DELETE FROM board WHERE board_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_id);
		pstmt.executeUpdate();

		pstmt.close();
	}

}
