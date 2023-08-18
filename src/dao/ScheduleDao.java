package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.BoardScheduleBottomDto;
import dto.BoardScheduleMidDto;
import dto.BoardScheduleTopDto;

public class ScheduleDao {
	
	public class ScheduleData{
		public BoardScheduleTopDto bsTop;
		public ArrayList<BoardScheduleMidDto> bsMid;
		public ArrayList<BoardScheduleBottomDto> bsBottom;
	}
	
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public ScheduleData getAllScheduleData(int board_id,String nowId) throws Exception{
		Connection conn = getConnection();
		ScheduleData data = new ScheduleData();
		BoardScheduleTopDto bTop;
		ArrayList<BoardScheduleMidDto> bMid = new ArrayList<>();
		ArrayList<BoardScheduleBottomDto> bBottom = new ArrayList<>();
		PreparedStatement pstmt;
		ResultSet rs;
		
		int project_id = 0;
		String proejct_name = null;
		String board_title = null;
		String regist_date = null;
		int public_scope = 0;
		String start_date = null;
		String deadline = null;
		int love = 0;
		int love_count = 0;
		int bookmark = 0;
		String lat = null;
		String lng = null;
		String writer_id = null;
		String writer_name = null;
		String profile_img = null;
		
		String sql = "SELECT p.project_name,b.*,bs.*,e.employee_id,e.employee_name,e.profile_img,TO_CHAR(b.regist_date, 'YY-MM-DD HH24:MI') AS regist_date1,TO_CHAR(bs.start_date, 'YY-MM-DD HH24:MI') AS start_date1,TO_CHAR(bs.deadline, 'YY-MM-DD HH24:MI') AS deadline1" + 
				" FROM board b,board_schedule bs,project p,employees e" + 
				" WHERE b.board_id=? AND b.board_id=bs.board_id AND b.project_id=p.project_id AND b.board_writer=e.employee_id ";
		
		pstmt = conn.prepareCall(sql);
		pstmt.setInt(1, board_id);
		rs = pstmt.executeQuery();
		while(rs.next()) { //��� part1
			project_id = rs.getInt("project_id");
			proejct_name = rs.getString("project_name");
			board_title = rs.getString("board_title");
			regist_date = rs.getString("regist_date1");
			public_scope = rs.getInt("public_scope");
			start_date = rs.getString("start_date1");
			deadline = rs.getString("deadline1");
			lat = rs.getString("lat");
			lng = rs.getNString("lng");
			writer_id = rs.getString("employee_id");
			writer_name = rs.getString("employee_name");
			profile_img = rs.getString("profile_img");
		}
		
		sql = "SELECT l.love_user,llo.love_count" + 
			" FROM love l,(SELECT lo.board_id,COUNT(*) love_count FROM love lo WHERE lo.board_id=? GROUP BY lo.board_id) llo" + 
			" WHERE l.board_id=llo.board_id";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_id);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			String checkId = rs.getString("love_user");
			if(checkId.equals(nowId)) {
				love = 1;
			}
			love_count = rs.getInt("love_count");
		}
		
		sql = "SELECT *" + //�ڽ��� �ϸ�ũ �ߴ��� ���part3
			" FROM bookmark" + 
			" WHERE board_id=? AND bookmark_user=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_id);
		pstmt.setString(2, nowId);
		rs = pstmt.executeQuery();
		if(rs.next()) {bookmark=1;}
		
		bTop = new BoardScheduleTopDto(project_id,proejct_name,board_title,regist_date,public_scope
				,start_date,deadline,love,love_count,bookmark,lat,lng,writer_id,writer_name,profile_img);
		String employee_id = null;
		int join_case = 0;
		String employee_name = null;
		profile_img = null;
		
		sql = "SELECT sj.*,e.employee_name,e.profile_img" + //�ߴ� ������ ����Ʈ
			" FROM schedule_joiner sj,employees e" + 
			" WHERE sj.board_id=? AND sj.employee_id=e.employee_id";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_id);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			employee_id = rs.getString("employee_id");
			join_case = rs.getInt("join_case");
			employee_name = rs.getString("employee_name");
			profile_img = rs.getString("profile_img");
			BoardScheduleMidDto bMidDto = new BoardScheduleMidDto(employee_id,join_case,employee_name,profile_img);
			bMid.add(bMidDto);
		}
		int reply_id = 0;
		String reply_writer = null;
		String reply_content = null;
		String reply_regist_date = null;
		int love_reply_count = 0;
		String reply_writer_name = null;
		String reply_profile_img = null;
		
		sql = "SELECT r.*,rr.love_reply_count,TO_CHAR(r.regist_date, 'YY-MM-DD HH24:MI') AS regist_date1,e.employee_name,e.profile_img" 
				+" FROM reply r,(SELECT lr.reply_id,COUNT(*) love_reply_count FROM love_reply lr GROUP BY lr.reply_id) rr,employees e" 
				+" WHERE r.board_id=? AND r.reply_writer=e.employee_id AND r.reply_id=rr.reply_id(+)"
				+" ORDER BY r.regist_date";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_id);
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			reply_id = rs.getInt("reply_id");
			reply_writer = rs.getString("reply_writer");
			reply_content = rs.getString("reply_content");
			reply_regist_date = rs.getString("regist_date1");
			love_reply_count = rs.getInt("love_reply_count");
			reply_writer_name = rs.getString("employee_name");
			reply_profile_img = rs.getString("profile_img");
			BoardScheduleBottomDto bBotDto = new BoardScheduleBottomDto(reply_id,reply_writer,reply_content,reply_regist_date,love_reply_count,reply_writer_name,reply_profile_img);
			bBottom.add(bBotDto);
		}
		
		data.bsTop = bTop;
		data.bsMid = bMid;
		data.bsBottom = bBottom;
		rs.clearWarnings();
		pstmt.close();
		conn.close();
		return data;
	}
	
	public ArrayList<BoardScheduleBottomDto> updateComment(String id,String comment,int board_id,int insert,int this_reply) throws Exception {
		Connection conn = getConnection();
		String sql = null;
		PreparedStatement pstmt;
		if(insert==1) {
			sql = "INSERT INTO reply(board_id,reply_id,reply_writer,reply_content)"
					+ " VALUES(?,seq_reply_id.nextval,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_id);
			pstmt.setString(2, id);
			pstmt.setString(3, comment);
			pstmt.executeUpdate();
		}else if(insert==2) {
			sql="INSERT INTO love_reply(love_user,reply_id)"
				+ " VALUES(?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, this_reply);
			pstmt.executeUpdate();
		}
		
		sql = "SELECT r.*,rr.love_reply_count,TO_CHAR(r.regist_date, 'YY-MM-DD HH24:MI') AS regist_date1,e.employee_name,e.profile_img" 
			+" FROM reply r,(SELECT lr.reply_id,COUNT(*) love_reply_count FROM love_reply lr GROUP BY lr.reply_id) rr,employees e" 
			+" WHERE r.board_id=? AND r.reply_writer=e.employee_id AND r.reply_id=rr.reply_id(+) "
			+ " ORDER BY r.regist_date";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, board_id);
		
		ResultSet rs = pstmt.executeQuery();
		ArrayList<BoardScheduleBottomDto> list = new ArrayList<>();
		while(rs.next()) {
			int reply_id = rs.getInt("reply_id");
			String reply_writer = rs.getString("reply_writer");
			String reply_content = rs.getString("reply_content");
			String reply_regist_date = rs.getString("regist_date1");
			int love_reply_count = rs.getInt("love_reply_count");
			String reply_writer_name = rs.getString("employee_name");
			String reply_profile_img = rs.getString("profile_img");
			BoardScheduleBottomDto dto = new BoardScheduleBottomDto(reply_id,reply_writer,reply_content,reply_regist_date,love_reply_count,reply_writer_name,reply_profile_img);
			list.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return list;
	}
	
	public void choiceJoin(String id,int board_id,int join) throws Exception {
		Connection conn = getConnection();
		String sql = "UPDATE schedule_joiner SET join_case=? WHERE board_id=? AND employee_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, join);
		pstmt.setInt(2, board_id);
		pstmt.setString(3, id);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
}

















