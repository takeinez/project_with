package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CreateDao;

// CreateServlet.java
@WebServlet("/CreateServlet")
public class CreateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 받는 파라미터들
        String projectId = request.getParameter("projectId");
        String title = request.getParameter("title");
        String startdate = request.getParameter("startdate");
        String deadline = request.getParameter("deadline");
        String attendance = request.getParameter("attendance");
        String lat = request.getParameter("lat");
        String lng = request.getParameter("lng");
        String placeName = request.getParameter("placeName");
        String address = request.getParameter("address");
        String nowId = request.getParameter("nowId");
        int value = Integer.parseInt(request.getParameter("value"));
        // DAO 객체 생성
        CreateDao dao = new CreateDao();
        
        try {
            // DAO 메소드 호출
            dao.CreateBoard(projectId, title, startdate, deadline, attendance, lat, lng, placeName, address, value,nowId);
            // 성공 메시지 반환
        } catch (Exception e) {
            // 실패 메시지 반환
        }
    }
}