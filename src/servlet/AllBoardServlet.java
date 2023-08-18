package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.AllBoardDao;
import dao.AllBoardDao.AllBoardData;

@WebServlet("/AllBoardServlet")
public class AllBoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String projectId = request.getParameter("send_projectId");
			AllBoardDao dao11 = new AllBoardDao();
			AllBoardData allBoardData = dao11.getAllBoardlistDto(projectId);
			String json1 = new Gson().toJson(allBoardData);
			 System.out.println("JSON 문자열 확인: " + json1);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(new Gson().toJson(allBoardData));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}