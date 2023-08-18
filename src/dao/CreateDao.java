package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CreateDao {
	public Connection getConnection() throws Exception {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";

		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url, dbId, dbPw);
		System.out.println("접속성공");
		return conn;
	}
	
	public void CreateBoard(String project_id,String title,String startdate, String deadline, String attendance,String lat,String lng,String placeName,String address,int value,String nowId) throws Exception{
		Connection conn = getConnection();
		String sql="INSERT INTO BOARD VALUES (?,board_id_sequence.nextval,3,?,'내용',?,sysdate,1,1,1)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, project_id);
	    pstmt.setString(2, title);
	    pstmt.setString(3, nowId);
	    pstmt.executeUpdate();
	    sql="INSERT INTO BOARD_SCHEDULE(board_id,start_date,deadline,board_place,board_address,alarm,lat,lng) VALUES (board_id_sequence.currval,?,?,?,?,?,?,?)";
	    pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, startdate);
	    pstmt.setString(2, deadline);
	    pstmt.setString(3, placeName);	
	    pstmt.setString(4, address);	
	    pstmt.setInt(5, value);			
	    pstmt.setString(6, lat);		
	    pstmt.setString(7, lng);		
	    pstmt.executeUpdate();
	    sql="INSERT INTO SCHEDULE_JOINER VALUES (board_id_sequence.currval,?,0)";
	    pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, attendance);
	    pstmt.executeUpdate();
	    pstmt.close();
        conn.close();
	}
}
