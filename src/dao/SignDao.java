package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import dto.SearchCompanyDto;
import dto.SignInDto;

public class SignDao {
	public Connection getConnection()throws Exception{
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@211.45.162.105:1521:xe";
		String dbId = "alone";
		String dbPw = "1234";	
		
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbId,dbPw);
		return conn;
	}
	
	public SignInDto getSignInDto(String inputId)throws Exception{
		Connection conn = getConnection();
		String id = "x";
		String pw = "x";
		SignInDto dto = null;
		try {
			String sql="SELECT * FROM employees WHERE employee_id=?";
			PreparedStatement pstmt = getConnection().prepareStatement(sql);
			pstmt.setString(1,inputId);
			ResultSet rs = pstmt.executeQuery();
			
			
			if(rs.next()){
				id= rs.getString("employee_id");
				pw=rs.getString("employee_pw");
				dto = new SignInDto(id,pw);
			}else {
				dto = new SignInDto(id,pw);
			}
			rs.close();
			pstmt.close();
			conn.close();
			return dto;
		}catch(Exception e) {
			e.printStackTrace();
			dto = new SignInDto(id,pw);
			return dto;
		}
		
	}
	public boolean checkIdDual(String id) throws Exception {
		boolean check = true;
		
		Connection conn = getConnection();
		String sql = "SELECT * FROM employees WHERE employee_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			check=false;
		}
		rs.close();
		pstmt.close();
		conn.close();
		return check;
	}
	public void sendEmail(String email) throws Exception {
		int num = (int)(Math.random()*999999+100001);
		String secretCode= Integer.toString(num);
		Connection conn = getConnection();
		String sql ="INSERT INTO certified_code(email,certified_code,code_time)"+
				" VALUES(?,?,sysdate)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setString(2, secretCode);
		pstmt.executeUpdate();
		mailer(email,secretCode);
		pstmt.close();
		conn.close();
	}
	
	public void mailer(String email,String secretCode) throws Exception { //받을사람 이메일 파라미터값 받아와야함
		String host     = "smtp.naver.com";
		  final String user   = "taesamyung@naver.com"; //보내는사람 이메일
		  final String password  = "4QTFWKESDFQ2"; //이메일 비밀번호 (2차인증 설정돼있으면 네이버 smtp 2차인증 비밀번호 검색하면 될거야

		  String to     = email; //받는사람 이메일

		  // Get the session object
		  Properties props = new Properties();
		  props.put("mail.smtp.host", host);
		  props.put("mail.smtp.auth", "true");

		  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
		   protected PasswordAuthentication getPasswordAuthentication() {
		    return new PasswordAuthentication(user, password);
		   }
		  });

		  // Compose the message
		  
		  try {
		   MimeMessage message = new MimeMessage(session);
		   message.setFrom(new InternetAddress(user));
		   message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

		   // Subject
		   message.setSubject("[위드]인증코드fff"); //이메일 제목
		   
		   // Text
		   message.setText(secretCode);//메일 본문
		   // send the message
		   Transport.send(message);
		   System.out.println("message sent successfully...");

		  } catch (MessagingException e) {
		   e.printStackTrace();
		  }
	}
	
	public void deleteCode(String email) throws Exception {
		Connection conn = getConnection();
		String sql="DELETE FROM certified_code WHERE email=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.executeUpdate();
		pstmt.close();
		conn.close();
	}
	
	public boolean[] certify(String email,String inputCode)throws Exception{
		
		Connection conn = getConnection();
		
		boolean[] certification = new boolean[2];

		String sql ="SELECT * "+
					" FROM certified_code" +
					" WHERE email=?" +
					" ORDER BY code_time DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		ResultSet rs = pstmt.executeQuery();
		String date = null;
		String checkCode = null;
		while(rs.next()) {
			date = rs.getString("code_time");
			checkCode = rs.getString("certified_code");
			break;
		}
		if(inputCode.equals(checkCode)) {
			certification[0] = true; //코드가 맞는지 정보를 배열[0]에 저장
		}
		
		//저장한 date를 현재시간과 비교
		sql ="select round(((sysdate - to_date(?,'yyyy-mm-dd HH24:MI:SS') ) * 24 *60),1) as mm from dual";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, date);
		rs = pstmt.executeQuery();
		double timeDiff = 0;
		String timee = null;
		String timee2 = null;
		if(rs.next()) {
			timeDiff = rs.getDouble(1);
		}
		if(timeDiff>=3) { //시간내에 입력했는지를 배열[1]에 저장.
			System.out.println("시간 초과.");
			certification[1] = false;
		}else if(timeDiff<=3) {
			certification[1] = true;
		}
		
		if(certification[0]) {//만약 둘다 만족하면 해당 로우 삭제
			sql ="DELETE FROM certified_code" +
				" WHERE email=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.executeUpdate();
			
		}
		
		
		conn.close();
		pstmt.close();
		rs.close();
		return certification;
	}
	
	public int checkCompanyUrl(String url) throws Exception {
		Connection conn = getConnection();
		String sql = "SELECT * FROM company WHERE company_url=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, url);
		ResultSet rs = pstmt.executeQuery();
		int check = 0;
		if(rs.next()) {
			check = 1;
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return check;
	}
	
	public void createAccountCompany(String id,String pw,String name,String job,String company_name,String company_url) throws Exception {
		Connection conn = getConnection();
		String sql = null;
		PreparedStatement pstmt;
		System.out.println(company_url);
		sql = "INSERT INTO company(company_id,company_name,company_url,company_version,permission_downroad,permission_duplication)"
			+ " VALUES(seq_company.nextval,?,?,'free',0,0)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, company_name);
		pstmt.setString(2, company_url);
		pstmt.executeUpdate();
		sql = "INSERT INTO employees(employee_id,employee_pw,employee_name,company_id,job_title,join_date,status,company_admin)"
			+ " VALUES(?,?,?,seq_company.currval,?,sysdate,1,1)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, name);
		pstmt.setString(4, job);
		pstmt.executeUpdate();
		
		sql ="INSERT INTO personal_set(employee_id) VALUES(?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO project(project_id,project_case,project_name,register_id,company_id,project_birthday)"
			+ " VALUES(project_id_sequence.nextval,3,'위드 이용 가이드',?,seq_company.currval,sysdate)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO project_permission (project_id,permission_write,permission_view,permission_reply,permission_file,permission_modify)" 
				+	" VALUES(project_id_sequence.currval,0,0,0,0,0)";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO project_member (project_id,employee_id,project_admin,project_status) VALUES(project_id_sequence.currval,?,1,1)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO personal_project_set (employee_id,project_id,project_color) VALUES(?,project_id_sequence.currval,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		int randomColor = (int)(Math.random()*12);
		pstmt.setInt(2, randomColor);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO project_category(category_id,company_id,category,status) VALUES(seq_category.nextval,seq_company.currval,'미지정',1)";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO personal_folder(employee_id,folder_id,folder_name) VALUES(?,seq_folder.nextval,'마케팅')";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO personal_folder(employee_id,folder_id,folder_name) VALUES(?,seq_folder.nextval,'디자인')";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO personal_folder(employee_id,folder_id,folder_name) VALUES(?,seq_folder.nextval,'엔지니어링')";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();

		pstmt.close();
		conn.close();
	}
	
	public boolean loginPermission(String id) throws Exception{
		Connection conn = getConnection();
		String sql = "SELECT * FROM employees WHERE employee_id=?";
		PreparedStatement pstmt= conn.prepareStatement(sql);
		pstmt.setString(1,id);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			int status = rs.getInt("status");
			if(status!=1) {
				rs.close();
				pstmt.close();
				conn.close();
				return false;
			}
		}
		rs.close();
		pstmt.close();
		conn.close();
		return true;
	}
	
	public SearchCompanyDto getSearchCompanyDto(String url) throws Exception {
		Connection conn = getConnection();
		String sql = "SELECT * FROM company WHERE company_url=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,url);
		ResultSet rs = pstmt.executeQuery();
		SearchCompanyDto dto = null;
		while(rs.next()) {
			int company_id = rs.getInt("company_id");
			String company_name = rs.getString("company_name");
			String company_url = rs.getString("company_url");
			dto = new SearchCompanyDto(company_id,company_name,company_url);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
	
	public void joinCompany(String id,String pw,String name,String job,int company_id) throws Exception {
		Connection conn = getConnection();
		PreparedStatement pstmt;
		
		String sql ="INSERT INTO employees(employee_id,employee_pw,employee_name,company_id,job_title,join_date,status)"
				+ " VALUES(?,?,?,?,?,sysdate,0)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, name);
		pstmt.setInt(4, company_id);
		pstmt.setString(5, job);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
	public void createKakaoAccount (String id,String name) throws Exception {
		Connection conn = getConnection();
		String sql = null;
		PreparedStatement pstmt;
		sql = "INSERT INTO company(company_id,company_name,company_version,permission_downroad,permission_duplication,company_url)"
			+ " VALUES(seq_company.nextval,'kakao_ac','free',0,0,seq_company.nextval)";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		sql = "INSERT INTO employees(employee_id,employee_pw,employee_name,company_id,join_date,status,company_admin)"
			+ " VALUES(?,'kakao',?,seq_company.currval,sysdate,1,1)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, name);
		pstmt.executeUpdate();
		
		sql ="INSERT INTO personal_set(employee_id) VALUES(?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO project(project_id,project_case,project_name,register_id,company_id,project_birthday)"
			+ " VALUES(project_id_sequence.nextval,3,'위드 이용 가이드',?,seq_company.currval,sysdate)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO project_permission (project_id,permission_write,permission_view,permission_reply,permission_file,permission_modify)" 
				+	" VALUES(project_id_sequence.currval,0,0,0,0,0)";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO project_member (project_id,employee_id,project_admin,project_status) VALUES(project_id_sequence.currval,?,1,1)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO personal_project_set (employee_id,project_id,project_color) VALUES(?,project_id_sequence.currval,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		int randomColor = (int)(Math.random()*12);
		pstmt.setInt(2, randomColor);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO personal_project_set (employee_id,project_id,project_color) VALUES(?,project_id_sequence.currval,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO project_category(category_id,company_id,category) VALUES(seq_category.nextval,seq_company.currval,'미지정')";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO personal_folder(employee_id,folder_id,folder_name) VALUES(?,seq_folder.nextval,'마케팅')";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO personal_folder(employee_id,folder_id,folder_name) VALUES(?,seq_folder.nextval,'디자인')";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		sql = "INSERT INTO personal_folder(employee_id,folder_id,folder_name) VALUES(?,seq_folder.nextval,'엔지니어링')";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
	public void passwordMailer(String email,String secretCode) throws Exception { //받을사람 이메일 파라미터값 받아와야함
		String host     = "smtp.naver.com";
		  final String user   = "taesamyung@naver.com"; //보내는사람 이메일
		  final String password  = "4QTFWKESDFQ2"; //이메일 비밀번호 (2차인증 설정돼있으면 네이버 smtp 2차인증 비밀번호 검색하면 될거야

		  String to     = email; //받는사람 이메일

		  // Get the session object
		  Properties props = new Properties();
		  props.put("mail.smtp.host", host);
		  props.put("mail.smtp.auth", "true");

		  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
		   protected PasswordAuthentication getPasswordAuthentication() {
		    return new PasswordAuthentication(user, password);
		   }
		  });

		  // Compose the message
		  
		  try {
		   MimeMessage message = new MimeMessage(session);
		   message.setFrom(new InternetAddress(user));
		   message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

		   // Subject
		   message.setSubject("[위드]임시 비밀번호"); //이메일 제목
		   
		   // Text
		   message.setText(secretCode);//메일 본문
		   // send the message
		   Transport.send(message);
		   System.out.println("message sent successfully...");

		  } catch (MessagingException e) {
		   e.printStackTrace();
		  }
	}
	
	public boolean sendPassword(String email) throws Exception {
		Connection conn = getConnection();
		int num = (int)(Math.random()*999999+100001);
		String secret= Integer.toString(num);
		String secretCode = "temp" + num;
		try {
			String sql="UPDATE employees SET employee_pw=? WHERE employee_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, secretCode);
			pstmt.setString(2, email);
			pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			passwordMailer(email,secretCode);
			return true;
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
}












