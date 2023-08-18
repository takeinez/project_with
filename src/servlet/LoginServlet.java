package servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import dao.SignDao;
import dto.SearchCompanyDto;
import dto.SignInDto;
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	void Login(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String id = request.getParameter("send_id");
	    String pw = request.getParameter("send_pw");
	    SignDao dao1 = new SignDao();
	    
	    int check = 3;
	    
	    try {
	        SignInDto dto = dao1.getSignInDto(id);
	        String hId = dto.getEmployee_id();
	        String hPw = dto.getEmployee_pw();
	        if(hId.equals(id)&&hPw.equals(pw)) {
	        	check = 1;
	        	if(!dao1.loginPermission(hId)) {
	        		check = 4;
	        	}
	        }else if(hId.equals(id)&&!hPw.equals(pw)) {
	        	check = 2;
	        }else if(hId.equals("x")){
	        	check = 0;
	        }
	        response.getWriter().write(Integer.toString(check));
	    } catch (Exception e) {
	        response.getWriter().write(Integer.toString(check));
	        e.printStackTrace();
	    }
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html;charset=UTF-8");
	}
	void CheckIdDual(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		String id = request.getParameter("send_id");
		SignDao dao = new SignDao();
		try {
			boolean check = dao.checkIdDual(id);
			response.getWriter().write(String.valueOf(check));
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
	}
	
	void LetsGo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String inputId = request.getParameter("id");
		HttpSession session = request.getSession();
		session.setAttribute("loginId",inputId);
		RequestDispatcher rd = request.getRequestDispatcher("환승하자.jsp");
		rd.forward(request, response);
	}
	void SendCode(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		String email = request.getParameter("send_email");
		SignDao dao = new SignDao();
		try {
			dao.sendEmail(email);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	void DeleteCode(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		String email = request.getParameter("send_email");
		SignDao dao = new SignDao();
		try {
			dao.deleteCode(email);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	void Certify(HttpServletRequest request, HttpServletResponse response) {
		try {
        	String email = request.getParameter("send_email");
        	String inputCode = request.getParameter("send_code");
            SignDao dao = new SignDao();
            boolean[] checkCode = dao.certify(email,inputCode);
            String json = new Gson().toJson(checkCode);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	void CheckCompanyUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String url = request.getParameter("send_url");
		SignDao dao = new SignDao();
		
	    
	    try {
	    	int check = dao.checkCompanyUrl(url);
	        response.getWriter().write(Integer.toString(check));
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    request.setCharacterEncoding("UTF-8");
	    response.setContentType("text/html;charset=UTF-8");
	}
	void CreateAccountCompany(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		String id = request.getParameter("send_id");
		String pw = request.getParameter("send_pw");
		String name = request.getParameter("send_name");
		String job = request.getParameter("send_job");
		String company_name = request.getParameter("send_company_name");
		String company_url = request.getParameter("send_url");
		SignDao dao = new SignDao();
		try {
			dao.createAccountCompany(id, pw, name, job, company_name, company_url);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	void SearchCompany(HttpServletRequest request, HttpServletResponse response) {
		try {
        	String url = request.getParameter("send_url");
            SignDao dao = new SignDao();
            SearchCompanyDto dto = dao.getSearchCompanyDto(url);
            String json = new Gson().toJson(dto);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	void JoinCompany(HttpServletRequest request, HttpServletResponse response) {
		try {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String name = request.getParameter("name");
			String job = request.getParameter("job");
			String company_url = request.getParameter("company_url");
			String company_name = request.getParameter("company_name");
			int company_id = Integer.parseInt(request.getParameter("company_id"));
			SignDao dao = new SignDao();
			dao.joinCompany(id, pw, name, job, company_id);
			request.setAttribute("company_name", company_name);
			request.setAttribute("company_url", company_url);
			RequestDispatcher rd = request.getRequestDispatcher("기존회사참여마지막.jsp");
			rd.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	void CreateKaKaoAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("send_id");
		String name = request.getParameter("send_name");
		SignDao dao = new SignDao();
		try {
			dao.createKakaoAccount(id, name);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	void FindPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		String email = request.getParameter("email");
		SignDao dao = new SignDao();
		boolean check = false;
		try {
			check = dao.sendPassword(email);
			response.getWriter().write(String.valueOf(check));
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write(String.valueOf(check));
		}
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int num = Integer.parseInt(request.getParameter("send_num"));
	    
	    switch(num) {
	    case 0:LetsGo(request, response);break;
	    case 1:Login(request, response);break;
	    case 2:CheckIdDual(request,response);break;
	    case 3:SendCode(request,response);break;
	    case 4:DeleteCode(request,response);break;
	    case 5:Certify(request,response);break;
	    case 6:CheckCompanyUrl(request,response);break;
	    case 7:CreateAccountCompany(request,response);break;
	    case 8:SearchCompany(request,response);break;
	    case 9:JoinCompany(request,response);break;
	    case 10:CreateKaKaoAccount(request,response);break;
	    case 11:FindPassword(request,response);break;
	    }
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

}
