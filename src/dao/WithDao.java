package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.AllScheduleDto;
import dto.FolderDto;
import dto.OpenProjectDto;
import dto.ProjectCategoryDto;
import dto.WithDto;
import dto.WithMentionDto;

public class WithDao {
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public WithDto getMyBoardDto(String id) throws Exception {
		Connection conn = getConnection();
		String sql="SELECT * FROM board1 WHERE bno=?";
		PreparedStatement pstmt = getConnection().prepareStatement(sql);
		pstmt.setString(1,id);
		ResultSet rs = pstmt.executeQuery();
		
		WithDto wiDto = null;
		if(rs.next()){
			int project_id = rs.getInt("project_id");
			String project_name = rs.getString("project_name");
			int board_id = rs.getInt("board_id");
			int board_type = rs.getInt("board_type");
			String board_title = rs.getString("board_title");
			String board_writer = rs.getString("board_writer");
			String regist_date = rs.getString("regist_date");
			int reply_count = rs.getInt("reply_count");
			wiDto = new WithDto(project_id,project_name,board_id,board_type,board_title,board_writer,regist_date,reply_count);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return wiDto;
	}
	public ArrayList<WithDto> getMyBoardList(String id,int boardCase) throws Exception {
		Connection conn = getConnection();
		String chooseType = "";
		if(boardCase==1) {
			chooseType = " AND b.board_type=1";
		}else if(boardCase==2) {
			chooseType = " AND b.board_type=2";
		}else if(boardCase==3) {
			chooseType = " AND b.board_type=3";
		}else if(boardCase==4) {
			chooseType = " AND b.board_type=4";
		}else if(boardCase==5) {
			chooseType = " AND b.board_type=5";
		}
		String sql = "SELECT p.project_name,b.*,bb.replycount ,e.employee_name" + 
				" FROM project p,board b ,(SELECT r.board_id,count(*) replyCount FROM reply r group by board_id) bb ,employees e" + 
				" WHERE p.project_id=b.project_id AND b.board_writer=? AND bb.board_id=b.board_id AND e.employee_id=b.board_writer"+ chooseType+  
				" ORDER BY regist_date DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		ResultSet rs = pstmt.executeQuery();

		ArrayList<WithDto> myBoardList = new ArrayList<WithDto>();
		while(rs.next()){
			int project_id = rs.getInt("project_id");
			String project_name = rs.getString("project_name");
			int board_id = rs.getInt("board_id");
			int board_type = rs.getInt("board_type");
			String board_title = rs.getString("board_title");
			String board_writer = rs.getString("employee_name");
			String regist_date = rs.getString("regist_date");
			int reply_count = rs.getInt("replyCount");
			WithDto withDto = new WithDto(project_id,project_name,board_id,board_type,board_title,board_writer,regist_date,reply_count);
			myBoardList.add(withDto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return myBoardList;
	}
	public ArrayList<WithMentionDto> getMyMentionList(String id,int boardCase) throws Exception {
		Connection conn = getConnection();
		String chooseType = "";
		if(boardCase==1) {
			chooseType = " AND b.board_type=1 AND rr.board_id IS NULL";
		}else if(boardCase==2) {
			chooseType = " AND b.board_type=2 AND rr.board_id IS NULL";
		}else if(boardCase==3) {
			chooseType = " AND b.board_type=3 AND rr.board_id IS NULL";
		}else if(boardCase==4) {
			chooseType = " AND b.board_type=4 AND rr.board_id IS NULL";
		}else if(boardCase==5) {
			chooseType = " AND b.board_type=5 AND rr.board_id IS NULL";
		}else if(boardCase==-1) {
			chooseType = " AND rr.board_id IS NOT NULL";
		}
		String sql = "SELECT p.project_name,b.*,bb.replycount ,e.employee_name,rr.*,rr.regist_date reply_date" + 
				" FROM project p,board b ,(SELECT r.board_id,count(*) replyCount FROM reply r group by board_id) bb ,employees e, (SELECT r2.* FROM reply r2,employees e2 WHERE r2.reply_content LIKE '%' || e2.employee_name || '%' AND e2.employee_id=?) rr" + 
				" WHERE p.project_id=b.project_id AND bb.board_id=b.board_id AND e.employee_id=b.board_writer AND b.board_id=rr.board_id(+) AND (b.temporary_save IS NULL OR b.temporary_save = 0)" + chooseType+
				" ORDER BY " + 
				" CASE" + 
				" WHEN b.regist_date <= rr.regist_date THEN rr.regist_date" + 
				" ELSE b.regist_date" + 
				" END desc";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		ResultSet rs = pstmt.executeQuery();
		
		ArrayList<WithMentionDto> myBoardList = new ArrayList<WithMentionDto>();
		while(rs.next()){
			int project_id = rs.getInt("project_id");
			String project_name = rs.getString("project_name");
			int board_id = rs.getInt("board_id");
			int board_type = rs.getInt("board_type");
			String board_title = rs.getString("board_title");
			String board_writer = rs.getString("employee_name");
			String regist_date = rs.getString("regist_date");
			String reply_writer = rs.getString("reply_writer");
			String reply_content = rs.getString("reply_content");
			String reply_date = rs.getString("reply_date");
			int reply_count = rs.getInt("replycount");
			WithMentionDto withDto = new WithMentionDto (project_id,project_name,board_id,board_type,board_title,board_writer,regist_date,reply_writer,reply_content,reply_date,reply_count);
			myBoardList.add(withDto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return myBoardList;
	}
	public ArrayList<WithDto> getMyBookmarkList(String id,int boardCase) throws Exception {
		Connection conn = getConnection();
		String chooseType = "";
		if(boardCase==1) {
			chooseType = " AND b.board_type=1";
		}else if(boardCase==2) {
			chooseType = " AND b.board_type=2";
		}else if(boardCase==3) {
			chooseType = " AND b.board_type=3";
		}else if(boardCase==4) {
			chooseType = " AND b.board_type=4";
		}else if(boardCase==5) {
			chooseType = " AND b.board_type=5";
		}
		String sql = "SELECT b.*,rr.*,p.project_name,e.employee_name" + 
				" FROM board b,bookmark bm,(SELECT r.board_id,COUNT(*) reply_count FROM reply r GROUP BY r.board_id) rr,project p,employees e" + 
				" WHERE b.board_id=bm.board_id AND bm.bookmark_user = ? AND b.board_id = rr.board_id(+) AND p.project_id=b.project_id AND e.employee_id=b.board_writer AND (b.temporary_save IS NULL OR b.temporary_save = 0)"+chooseType+
				" ORDER BY b.regist_date DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<WithDto> myBoardList = new ArrayList<WithDto>();
		while(rs.next()){
			int project_id = rs.getInt("project_id");
			String project_name = rs.getString("project_name");
			int board_id = rs.getInt("board_id");
			int board_type = rs.getInt("board_type");
			String board_title = rs.getString("board_title");
			String board_writer = rs.getString("employee_name");
			String regist_date = rs.getString("regist_date");
			int reply_count = rs.getInt("reply_count");
			WithDto withDto = new WithDto(project_id,project_name,board_id,board_type,board_title,board_writer,regist_date,reply_count);
			myBoardList.add(withDto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return myBoardList;
	}
	public ArrayList<WithDto> getMyTempSaveList(String id,int boardCase) throws Exception {
		Connection conn = getConnection();
		String chooseType = "";
		if(boardCase==1) {
			chooseType = " AND b.board_type=1";
		}else if(boardCase==2) {
			chooseType = " AND b.board_type=2";
		}else if(boardCase==3) {
			chooseType = " AND b.board_type=3";
		}else if(boardCase==4) {
			chooseType = " AND b.board_type=4";
		}else if(boardCase==5) {
			chooseType = " AND b.board_type=5";
		}
		String sql = "SELECT b.*,p.project_name,e.employee_name" + 
				" FROM board b,project p,employees e" + 
				" WHERE b.project_id=p.project_id AND b.board_writer=? AND b.temporary_save=1 AND b.board_writer=e.employee_id" + chooseType+
				" ORDER BY regist_date DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<WithDto> myBoardList = new ArrayList<WithDto>();
		while(rs.next()){
			int project_id = rs.getInt("project_id");
			String project_name = rs.getString("project_name");
			int board_id = rs.getInt("board_id");
			int board_type = rs.getInt("board_type");
			String board_title = rs.getString("board_title");
			String board_writer = rs.getString("employee_name");
			String regist_date = rs.getString("regist_date");
			int reply_count = 0;
			WithDto withDto = new WithDto(project_id,project_name,board_id,board_type,board_title,board_writer,regist_date,reply_count);
			myBoardList.add(withDto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return myBoardList;
	}
	
	public ArrayList<ProjectCategoryDto> loadCompanyCategory(String id) throws Exception{
		Connection conn = getConnection();
		String sql = "SELECT * FROM project_category pc,company c, employees e" + 
					" WHERE pc.company_id=c.company_id AND c.company_id=e.company_id AND e.employee_id=? AND pc.status=1";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<ProjectCategoryDto> pcd = new ArrayList<ProjectCategoryDto>();
		while(rs.next()) {
			int category_id = rs.getInt("category_id");
			int company_id = rs.getInt("company_id");
			String category = rs.getString("category");
			ProjectCategoryDto pcdt = new ProjectCategoryDto(company_id,category_id,category);
			pcd.add(pcdt);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return pcd;
	}
	public void createProject(String nowId,String title,String content,int openProject,int category_id,int project_permission,int write,int modify,int view,int reply,int file) throws Exception {
		Connection conn = getConnection();
		String sql = "INSERT INTO project (project_id,project_case,project_name,project_explanation,register_id,company_id,project_birthday,category_id,join_permission)"
			+	" VALUES(project_id_sequence.nextval,?,?,?,?,(SELECT c.company_id FROM company c, employees e WHERE c.company_id=e.company_id AND e.employee_id=?),sysdate,?,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,openProject);
		pstmt.setString(2, title);
		pstmt.setString(3, content);
		pstmt.setString(4, nowId);
		pstmt.setString(5, nowId);
		pstmt.setInt(6, category_id);
		pstmt.setInt(7, project_permission);
		
		pstmt.executeUpdate();
		
		sql = "INSERT INTO project_permission (project_id,permission_write,permission_view,permission_reply,permission_file,permission_modify)" 
			+	" VALUES(project_id_sequence.currval,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, write);
		pstmt.setInt(2, view);
		pstmt.setInt(3, reply);
		pstmt.setInt(4, file);
		pstmt.setInt(5, modify);
		
		pstmt.executeUpdate();
		
		sql = "INSERT INTO project_member (project_id,employee_id,project_admin,project_status) VALUES(project_id_sequence.currval,?,1,1)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, nowId);
		
		pstmt.executeUpdate();
		sql = "INSERT INTO personal_project_set (employee_id,project_id,project_color) VALUES(?,project_id_sequence.currval,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,nowId);
		int randomColor = (int)(Math.random()*12);
		pstmt.setInt(2, randomColor);
		
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	public ArrayList<OpenProjectDto> loadOpenProject(String nowId,int category_id,String searchKeyword) throws Exception{
		Connection conn = getConnection();
		String addOption = "";
		if(category_id!=0) {
			addOption = " AND p.category_id="+category_id;
		}
		String addLike = " AND( p.project_name LIKE '%"+searchKeyword+"%' OR e2.employee_name LIKE '%"+searchKeyword+"%')";
		String sql = "SELECT p.* ,e2.employee_name register_name,pm.count_member" + 
				" FROM project p,employees e,(SELECT project_id, COUNT(*) count_member FROM project_member pm2 group by pm2.project_id) pm ,employees e2" + 
				" WHERE e.employee_id=? AND e.company_id=p.company_id AND p.project_case=2 AND p.project_id=pm.project_id AND e2.employee_id(+)=p.register_id"+addOption+addLike;
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ArrayList<OpenProjectDto> opd = new ArrayList<OpenProjectDto>();
		pstmt.setString(1, nowId);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int project_id = rs.getInt("project_id");
			String project_name = rs.getString("project_name");
			int count_member = rs.getInt("count_member");
			String register_name = rs.getString("register_name");
			int joined = 0;
			
			String sql2 = "SELECT * FROM project_member pm, project p, employees e " + 
					" WHERE e.employee_id=? AND p.company_id=e.company_id AND pm.project_id = p.project_id AND pm.employee_id=? AND p.project_case=2 AND pm.project_id=?";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, nowId);
			pstmt2.setString(2, nowId);
			pstmt2.setInt(3, project_id);
			ResultSet rs2 = pstmt2.executeQuery();
			
			if(rs2.next()) {
				joined = 1;
			}
			OpenProjectDto opdto = new OpenProjectDto(project_id,project_name,count_member,register_name,joined);
			opd.add(opdto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return opd;
	}
	public ArrayList<Integer> pickProject(String id,String pick) throws Exception{
		Connection conn = getConnection();
		String addPick = "";
		if(pick.equals("star")) {
			addPick = " AND pps.favorite = 1";
		}else if(pick.equals("hidden")) {
			addPick = " AND pps.hide = 1";
		}else if(pick.equals("nokeep")) {
			addPick =" AND (p.category_id=0 OR p.category_id IS NULL)";
		}
		String sql="SELECT *" + 
				" FROM project p, project_member pm ,personal_project_set pps" + 
				" WHERE pm.employee_id = ? AND pm.employee_id = pps.employee_id AND pps.project_id=pm.project_id AND p.project_id = pm.project_id " + addPick;
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs = pstmt.executeQuery();
		ArrayList<Integer> pp = new ArrayList<Integer>();
		while(rs.next()) {
			int project_id = rs.getInt("project_id");
			pp.add(project_id);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return pp;
	}
	public ArrayList<AllScheduleDto> loadAllSchedule(String nowId) throws Exception{
		Connection conn = getConnection();
		String sql = "SELECT *" + 
				" FROM board b, board_schedule bs" + 
				" WHERE b.board_writer=? AND b.board_type=3 AND b.board_id=bs.board_id";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, nowId);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<AllScheduleDto> asd = new ArrayList<AllScheduleDto>();
		while(rs.next()) {
			int board_id = rs.getInt("board_id");
			String board_title = rs.getString("board_title");
			String start_date = rs.getString("start_date");
			String deadline = rs.getString("deadline");
			AllScheduleDto adto = new AllScheduleDto(board_id,board_title,start_date,deadline);
			asd.add(adto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return asd;
	}
	
	public void updateLoveBookmark(String id,int board_id,int love, int bookmark,int loveOrBook) throws Exception {
		Connection conn = getConnection();
		PreparedStatement pstmt;
		String sql = null;
		switch(loveOrBook) {
		case 0:
			if(love==0) {
				sql = "DELETE FROM love WHERE board_id=? AND love_user=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, board_id);
				pstmt.setString(2, id);
				pstmt.executeUpdate();
			}else if(love==1) {
				sql = "INSERT INTO love(board_id,love_user) VALUES(?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, board_id);
				pstmt.setString(2, id);
				pstmt.executeUpdate();
			}
			break;
		case 1:
			if(bookmark==0) {
				sql = "DELETE FROM bookmark WHERE board_id=? AND bookmark_user=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, board_id);
				pstmt.setString(2, id);
				pstmt.executeUpdate();
				pstmt.close();
				conn.close();
			}else if(bookmark==1) {
				sql = "INSERT INTO bookmark(board_id,bookmark_user) VALUES(?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, board_id);
				pstmt.setString(2, id);
				pstmt.executeUpdate();
				pstmt.close();
				conn.close();
			}
			break;
		}
	}
	
	public ArrayList<FolderDto> loadMyFolder(String id) throws Exception{
		Connection conn = getConnection();
		String sql="SELECT * FROM personal_folder WHERE employee_id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<FolderDto> list = new ArrayList<>();
		while(rs.next()) {
			int folder_id = rs.getInt("folder_id");
			String folder_name = rs.getString("folder_name");
			FolderDto dto = new FolderDto(folder_id,folder_name);
			list.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return list;
	}
	
	public void createFolder(String nowId,String folder_name) throws Exception {
		Connection conn = getConnection();
		String sql="INSERT INTO personal_folder(employee_id,folder_id,folder_name) VALUES(?,seq_folder.nextval,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, nowId);
		pstmt.setString(2, folder_name);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	public boolean adminPermission(String nowId) throws Exception {
		Connection conn = getConnection();
		String sql="SELECT * FROM employees WHERE employee_id=? AND company_admin=1";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, nowId);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			rs.close();
			pstmt.close();
			conn.close();
			return true;
		}
		rs.close();
		pstmt.close();
		conn.close();
		return false;
	}
}












