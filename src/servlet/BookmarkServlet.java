package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.WithDao;
import dto.WithDto;

@WebServlet("/book")
public class BookmarkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
        	String sended_id = request.getParameter("send_id");
        	int sended_boardCase = Integer.parseInt(request.getParameter("send_boardCase"));
            WithDao dao1 = new WithDao();
            ArrayList<WithDto> arr1 = dao1.getMyBookmarkList(sended_id, sended_boardCase);

            String json = new Gson().toJson(arr1);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("�־ȴ��");
        }
	}

}
