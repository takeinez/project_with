package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.PersonalProjectSetDao;
import dao.WithDao;
import dto.PersonalFolderDto;
import dto.PersonalPushDto;
import dto.WithDto;
@WebServlet("/pps")
public class PersonalProjectSetServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
	
	void colorSet(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PersonalProjectSetDao ppsDao = new PersonalProjectSetDao();
		int pro_id = Integer.parseInt(request.getParameter("send_pro_id"));
		int color = Integer.parseInt(request.getParameter("send_color"));
		ppsDao.personalProjectColor(pro_id, color);
	}
	void loadFolder(HttpServletRequest request, HttpServletResponse response) {
		try {
        	String sended_id = request.getParameter("send_id");
        	
        	PersonalProjectSetDao dao1 = new PersonalProjectSetDao();
            ArrayList<PersonalFolderDto> arr1 = dao1.loadPersonalFolder(sended_id);

            String json = new Gson().toJson(arr1);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	void projectFolderSet(HttpServletRequest request, HttpServletResponse response) {//��������
		PersonalProjectSetDao ppsDao = new PersonalProjectSetDao();
		try {
			int pro_id = Integer.parseInt(request.getParameter("send_projectId"));
			int folder_id = Integer.parseInt(request.getParameter("send_folderId"));
        	
        	PersonalProjectSetDao dao1 = new PersonalProjectSetDao();
        	dao1.project_folder_set(pro_id,folder_id);
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	void projectPushSwitch(HttpServletRequest request, HttpServletResponse response) {//�˸����� ���� �޾ƿ�
		try {
        	String sended_id = request.getParameter("send_id");
        	int sended_pro_id = Integer.parseInt(request.getParameter("send_pro_id"));
        	PersonalProjectSetDao dao1 = new PersonalProjectSetDao();
            ArrayList<PersonalPushDto> arr1 = dao1.project_push_switch(sended_id,sended_pro_id);
            String json = new Gson().toJson(arr1);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("�־ȴ��4");
        }
	}
	void projectPushSet(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			String id = request.getParameter("send_id");
			int pro_id = Integer.parseInt(request.getParameter("send_pro_id"));
			int push_switch = Integer.parseInt(request.getParameter("send_push_switch"));
			int board_push = Integer.parseInt(request.getParameter("send_board_push"));
			int reply_push = Integer.parseInt(request.getParameter("send_reply_push"));
			int notification_list = Integer.parseInt(request.getParameter("send_notification_list"));
			PersonalProjectSetDao dao1 = new PersonalProjectSetDao();
			dao1.project_push_set(id, pro_id, push_switch, board_push, reply_push, notification_list);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	void projectHideSet(HttpServletRequest request, HttpServletResponse response) {
		try {
			String id = request.getParameter("send_id");
			int pro_id = Integer.parseInt(request.getParameter("send_pro_id"));
			PersonalProjectSetDao dao1 = new PersonalProjectSetDao();
			dao1.project_hide(id, pro_id);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	void projectHideCancel(HttpServletRequest request, HttpServletResponse response) {
		try {
			String id = request.getParameter("send_id");
			int pro_id = Integer.parseInt(request.getParameter("send_pro_id"));
			PersonalProjectSetDao dao1 = new PersonalProjectSetDao();
			dao1.project_hide_cancel(id, pro_id);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
        	int num = Integer.parseInt(request.getParameter("send_num"));
			switch(num) {
				case 0:
					colorSet(request,response);
					break;
				case 1:
					loadFolder(request,response);
					break;
				case 2:
					projectFolderSet(request,response);
					break;
				case 3:
					projectPushSwitch(request,response);
					break;
				case 4:
					projectPushSet(request,response);
					break;
				case 5:
					projectHideSet(request,response);
					break;
				case 6:
					projectHideCancel(request,response);
					break;
			}
        	



        } catch (Exception e) {
            e.printStackTrace();
        }
	}

}
