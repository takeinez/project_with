
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import dto.AllBoardDto;
import dto.AllBoardDto2;
import dto.AllBoardDto3;
import dto.AllBoardDto4;
import dto.AllBoardDto5;

public class AllBoardDao {
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
	
	public class AllBoardData {
	    public ArrayList<AllBoardDto> b;
	    public ArrayList<AllBoardDto2> b1;
	    public ArrayList<AllBoardDto3> b2;
	    public ArrayList<AllBoardDto4> b3;
	    public ArrayList<AllBoardDto5> b4;
	    public Map<Integer, ArrayList<String>> voteContentMap;
	}
	
	public AllBoardData getAllBoardlistDto(String projectId) throws Exception{
		Connection conn = getConnection();
		String sql = "SELECT" + 
				"  b.*,e.job_title,p.*,e.*," + 
				"  w.*,s.*,t.*,bv.*,v.*,r.*,r.regist_date rr,s.start_date ss,s.deadline sd,t.deadline td,t.manager tm, j.employee_id je" + 
				" FROM board b" + 
				" INNER JOIN project p ON b.project_id = p.project_id" + 
				" INNER JOIN employees e ON b.board_writer = e.employee_id " + 
				" LEFT JOIN board_work w ON b.board_id = w.board_id " + 
				" LEFT JOIN board_schedule s ON b.board_id = s.board_id " + 
				" LEFT JOIN todo t ON b.board_id = t.board_id" + 
				" LEFT JOIN board_vote bv ON b.board_id = bv.board_id" + 
				" LEFT JOIN vote v ON b.board_id = v.board_id" +
				" LEFT JOIN reply r ON b.board_id = r.board_id" +
				" LEFT JOIN schedule_joiner j ON b.board_id = j.board_id" +
				" WHERE p.project_id = ?" +
				" ORDER BY b.regist_date DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, projectId);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<AllBoardDto> b = new ArrayList<AllBoardDto>();
		ArrayList<AllBoardDto2> b1 = new ArrayList<AllBoardDto2>();
		ArrayList<AllBoardDto3> b2 = new ArrayList<AllBoardDto3>();
		ArrayList<AllBoardDto4> b3 = new ArrayList<AllBoardDto4>();
		ArrayList<AllBoardDto5> b4 = new ArrayList<AllBoardDto5>();
		Map<Integer, ArrayList<String>> voteContentMap = new HashMap<>();
		
		while(rs.next()) {
			int board_id = rs.getInt("board_id");
			String title = rs.getString("board_title");
			int board_type = rs.getInt("board_type");
			String content = rs.getString("board_content");
			String registdate = rs.getString("regist_date");
			String boardwriter = rs.getString("board_writer");
			String jobtitle = rs.getString("job_title");
			String process = rs.getString("process");
			String startdate = rs.getString("start_date");
			String deadline = rs.getString("deadline");
			String priority = rs.getString("priority");
			int progress = rs.getInt("progress");
			String manager = rs.getString("manager");
			String startdate2 = rs.getString("ss");
			String deadline2 = rs.getString("sd");
			String lat = rs.getString("lat");
			String lng = rs.getString("lng");
			int alarm = rs.getInt("alarm");
			String join = rs.getString("je");
			String place = rs.getString("board_place");
			String address = rs.getString("board_address");
			int todoid = rs.getInt("todo_id");
			String content1 = rs.getString("content");
			String manager1 = rs.getString("tm");
			String deadline3 = rs.getString("td");
			String deadline4 = rs.getString("vote_deadline");
			int revenge = rs.getInt("revenge_vote");
			int anonymous = rs.getInt("anonymous_vote");
			int anyone = rs.getInt("anyone_add");
			int hidden = rs.getInt("hidden_poll");
			int result = rs.getInt("result_time");
			String content2 = rs.getString("vote_content");
			String replywriter = rs.getString("reply_writer");
			String replycontent =rs.getString("reply_content");
			String replydate = rs.getString("rr");
			switch(board_type) {
			case 1:
				AllBoardDto bba = new AllBoardDto(board_id,title,board_type,content,registdate,boardwriter,jobtitle,replywriter,replycontent,replydate);
				b.add(bba);
				break;
			case 2:
				AllBoardDto bbb = new AllBoardDto(board_id,title,board_type,content,registdate,boardwriter,jobtitle,replywriter,replycontent,replydate);
				AllBoardDto2 bb1 = new AllBoardDto2(process,startdate,deadline,priority,progress,manager);
				b.add(bbb);
				b1.add(bb1);
				break;
			case 3:
				AllBoardDto bbc = new AllBoardDto(board_id,title,board_type,content,registdate,boardwriter,jobtitle,replywriter,replycontent,replydate);
				AllBoardDto3 bb2 = new AllBoardDto3(startdate2,deadline2,lat,lng,alarm,join,place,address);
				b.add(bbc);
				b2.add(bb2);
				break;
			case 4:
				AllBoardDto bbd = new AllBoardDto(board_id,title,board_type,content,registdate,boardwriter,jobtitle,replywriter,replycontent,replydate);
				AllBoardDto4 bb3 = new AllBoardDto4(todoid,content1,manager1,deadline3);
				b.add(bbd);
				b3.add(bb3);
				break;
			case 5:
				 ArrayList<String> contents = voteContentMap.computeIfAbsent(board_id, k -> new ArrayList<>());
				  contents.add(content2);
				AllBoardDto bbe = new AllBoardDto(board_id,title,board_type,content,registdate,boardwriter,jobtitle,replywriter,replycontent,replydate);
				AllBoardDto5 bb4 = new AllBoardDto5(deadline4,revenge,anonymous,anyone,hidden,result,contents);
				b.add(bbe);
				b4.add(bb4);
				break;
			}
		}
		   // 반환 값을 저장할 새로운 객체를 생성합니다
	    AllBoardData resultData = new AllBoardData();
	    resultData.b = b;
	    resultData.b1 = b1;
	    resultData.b2 = b2;
	    resultData.b3 = b3;
	    resultData.b4 = b4;

	    // 새로운 반환 값 객체를 반환합니다
	    return resultData;
	}
	
	
}	
