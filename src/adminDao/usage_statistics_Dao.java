package adminDao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import adminDto.usage_statistics_Dto;


public class usage_statistics_Dao {
	
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public ArrayList<usage_statistics_Dto> getDtoList(int company_id, String search_name) throws Exception{
        Connection conn = getConnection();
        String sql = "SELECT c.company_name,e.employee_name,e.job_title,dd.department_name,e.employee_id,ppm.project_count,bb.board_count,rr.reply_count" + 
                " FROM employees e,company c,(SELECT pm.employee_id, COUNT(*) project_count FROM project_member pm GROUP BY pm.employee_id) ppm" + 
                " ,(SELECT b.board_writer, COUNT(*) board_count FROM board b  GROUP BY b.board_writer) bb" + 
                " ,(SELECT r.reply_writer, COUNT(*) reply_count FROM reply r  GROUP by r.reply_writer) rr" + 
                " ,(SELECT d.department_id,d.department_name FROM department d) dd" + 
                " WHERE c.company_id=? AND e.company_id=c.company_id AND e.employee_id=ppm.employee_id(+) AND e.employee_id=bb.board_writer(+)" + 
                " AND e.employee_id=rr.reply_writer(+)AND e.department_id=dd.department_id(+) AND e.employee_name LIKE ? AND status = 1";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, company_id);
        pstmt.setString(2, "%" + search_name + "%");
        ResultSet rs = pstmt.executeQuery();
        ArrayList<usage_statistics_Dto> list = new ArrayList<>();
        while(rs.next()) {
            String company_name = rs.getString("company_name");
            String employee_name = rs.getString("employee_name");
            String job_title = rs.getString("job_title");
            String department_name = rs.getString("department_name");
            String employee_id = rs.getString("employee_id");
            int project_count = rs.getInt("project_count");
            int board_count = rs.getInt("board_count");
            int reply_count = rs.getInt("reply_count");
            usage_statistics_Dto dto = new usage_statistics_Dto(company_name, employee_name, department_name, job_title, employee_id, project_count, board_count, reply_count, 0, 0);
            list.add(dto);
        }
        
        rs.close();
        pstmt.close();
        conn.close();
        return list;
        
    }

}