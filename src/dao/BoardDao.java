package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.BoardDto;

public class BoardDao {
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
	
	public ArrayList<BoardDto> getBoardlistDto(String searchInput, String nowId) throws Exception {
	    Connection conn = getConnection();
	    System.out.println(1);
	    String sql = " SELECT" + 
	            " 'board' AS table_type," + 
	            " board.board_id," + 
	            " board.board_title," + 
	            " board.board_content," + 
	            " employees.employee_name," + 
	            " board.regist_date" + 
	            " FROM board " + 
	            " JOIN employees ON board.board_writer = employees.employee_id" + 
	            " WHERE (board.board_title LIKE ? OR board.board_content LIKE ?) AND employees.employee_id = ?" + 
	            " UNION ALL" + 
	            " SELECT " + 
	            " 'reply' AS table_type," + 
	            " reply.board_id," + 
	            " NULL AS board_title," + // 'reply' 테이블에는 'board_title'이 없으므로 NULL로 대체
	            " reply.reply_content AS board_content," + // 'reply' 테이블의 'reply_content'를 'board_content'로 대체
	            " employees.employee_name," + 
	            " reply.regist_date" + 
	            " FROM reply" + 
	            " JOIN board ON board.board_id = reply.board_id" + 
	            " JOIN employees ON board.board_writer = employees.employee_name" + 
	            " WHERE reply.reply_content LIKE ? AND employees.employee_id = ?" + 
	            " ORDER BY regist_date ASC";
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1,"%" + searchInput+"%");
	    pstmt.setString(2,"%" + searchInput+"%");
	    pstmt.setString(3, nowId);
	    pstmt.setString(4,"%" + searchInput+"%");
	    pstmt.setString(5, nowId);
	    ResultSet rs = pstmt.executeQuery();
	    ArrayList<BoardDto> boardList = new ArrayList<BoardDto>();
	    while (rs.next()) {
	        String tabletype = rs.getString("table_type"); // 테이블 종류 가져오기
	        String title = rs.getString("board_title");
	        String content = rs.getString("board_content");
	        String writer = rs.getString("employee_name"); // employee_name으로 변경
	        String writedate = rs.getString("regist_date");
	        BoardDto boardDto = new BoardDto(title, content, writer, writedate, tabletype);
	        boardList.add(boardDto);
	    }

	    return boardList;
	}




}












