package servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.ScheduleDao;
import dao.SignDao;
import dao.ScheduleDao.ScheduleData;
import dao.WithDao;
import dto.AllScheduleDto;
import dto.BoardScheduleBottomDto;
import dto.FolderDto;
import dto.OpenProjectDto;
import dto.ProjectCategoryDto;
@WebServlet("/ps")
public class ProjectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	void load_project_category(HttpServletRequest request, HttpServletResponse response) {
		try {
        	String sended_id = request.getParameter("send_id");
        	WithDao dao1 = new WithDao();
        	ArrayList<ProjectCategoryDto> arr1= dao1.loadCompanyCategory(sended_id);
            String json = new Gson().toJson(arr1);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
        }
	}//
	void create_project(HttpServletRequest request, HttpServletResponse response) {
		try {
			String id = request.getParameter("send_id");
			String title = request.getParameter("send_title");
			String content = request.getParameter("send_content");
			int openProject = Integer.parseInt(request.getParameter("send_openProject"));
			int category_id = Integer.parseInt(request.getParameter("send_category_id"));
			int project_permission = Integer.parseInt(request.getParameter("send_project_permission"));
			int write = Integer.parseInt(request.getParameter("send_write"));
			int modify = Integer.parseInt(request.getParameter("send_modify"));
			int view = Integer.parseInt(request.getParameter("send_view"));
			int reply = Integer.parseInt(request.getParameter("send_reply"));
			int file = Integer.parseInt(request.getParameter("send_file"));
			WithDao dao1 = new WithDao();
			dao1.createProject(id, title, content, openProject, category_id, project_permission, write, modify, view, reply, file);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	void load_open_project(HttpServletRequest request, HttpServletResponse response) {//�˸����� ���� �޾ƿ�
		try {
        	String sended_id = request.getParameter("send_id");
        	int category_id = Integer.parseInt(request.getParameter("send_category_id"));
        	String searchKeyword = request.getParameter("send_searchKeyword");
        	if(searchKeyword==null) {
        		searchKeyword="";
        	}
        	WithDao dao1 = new WithDao();
        	ArrayList<OpenProjectDto> arr1= dao1.loadOpenProject(sended_id,category_id,searchKeyword);
            String json = new Gson().toJson(arr1);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	void pick_project(HttpServletRequest request, HttpServletResponse response) {
		try {
        	String sended_id = request.getParameter("send_id");
        	String showSelect = request.getParameter("send_showSelect");

        	WithDao dao1 = new WithDao();
        	ArrayList<Integer> arr1= dao1.pickProject(sended_id,showSelect);
            // ArrayList ���� JSON �������� ��ȯ
            String json = new Gson().toJson(arr1);
            // JSON ���� ����
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	void load_all_schedule(HttpServletRequest request, HttpServletResponse response) {
		try {
			String sended_id = request.getParameter("send_id");
			
			WithDao dao1 = new WithDao();
			ArrayList<AllScheduleDto> arr1= dao1.loadAllSchedule(sended_id);
			// ArrayList ���� JSON �������� ��ȯ
			String json = new Gson().toJson(arr1);
			// JSON ���� ����
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	void getAllSchedule(HttpServletRequest request, HttpServletResponse response) {
		try {
			String sended_id = request.getParameter("send_id");
			int board_id = Integer.parseInt(request.getParameter("send_board_id"));
			ScheduleDao scheduleDao1 = new ScheduleDao();
			ScheduleData arr1 = scheduleDao1.getAllScheduleData(board_id, sended_id);
			
			String json = new Gson().toJson(arr1);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	void update_comment(HttpServletRequest request, HttpServletResponse response) {
		try {
			String sended_id = request.getParameter("send_id");
			String comment = request.getParameter("send_comment");
			int reply_id = Integer.parseInt(request.getParameter("send_reply_id"));
			int board_id = Integer.parseInt(request.getParameter("send_board_id"));
			int insert = Integer.parseInt(request.getParameter("send_insert"));
			
			ScheduleDao scheduleDao1 = new ScheduleDao();
			ArrayList<BoardScheduleBottomDto> arr1 = scheduleDao1.updateComment(sended_id, comment, board_id,insert,reply_id);
			
			String json = new Gson().toJson(arr1);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	void update_love_bookmark(HttpServletRequest request, HttpServletResponse response) {
		try {
			String sended_id = request.getParameter("send_id");
			int board_id = Integer.parseInt(request.getParameter("send_board_id"));
			int love = Integer.parseInt(request.getParameter("send_love"));
			int bookmark = Integer.parseInt(request.getParameter("send_bookmark"));
			int loveOrBook = Integer.parseInt(request.getParameter("send_loveOrBook"));
			
			WithDao dao = new WithDao();
			dao.updateLoveBookmark(sended_id, board_id, love, bookmark,loveOrBook);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	void choice_join(HttpServletRequest request, HttpServletResponse response) {
		try {
			String sended_id = request.getParameter("send_id");
			int board_id = Integer.parseInt(request.getParameter("send_board_id"));
			int join = Integer.parseInt(request.getParameter("send_join"));
			
			ScheduleDao dao = new ScheduleDao();
			dao.choiceJoin(sended_id,board_id,join);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	void load_folder(HttpServletRequest request, HttpServletResponse response) {
		try {
			String sended_id = request.getParameter("send_id");
			WithDao dao = new WithDao();
			ArrayList<FolderDto> arr1 = dao.loadMyFolder(sended_id);
			
			String json = new Gson().toJson(arr1);
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	void create_folder(HttpServletRequest request, HttpServletResponse response) {
		try {
			String sended_id = request.getParameter("send_id");
			String folder_name = request.getParameter("folder_name");
			WithDao dao = new WithDao();
			dao.createFolder(sended_id, folder_name);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	void admin_permission(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
		String id = request.getParameter("send_id");
		WithDao dao = new WithDao();
		try {
			boolean check = dao.adminPermission(id);
			response.getWriter().write(String.valueOf(check));
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int num = Integer.parseInt(request.getParameter("send_num"));
		switch(num) {
			case 1:load_project_category(request,response);break;
			case 2:create_project(request,response);break;
			case 3:load_open_project(request,response);break;
			case 4:pick_project(request,response);break;
			case 5:load_all_schedule(request,response);break;
			case 6:getAllSchedule(request,response);break;
			case 7:update_comment(request,response);break;
			case 8:update_love_bookmark(request,response);break;
			case 9:choice_join(request,response);break;
			case 10:load_folder(request,response);break;
			case 11:create_folder(request,response);break;
			case 12:admin_permission(request,response);break;
		}
	}

}
