package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import adminDao.admin_log_Dao;
import adminDao.category_Dao;
import adminDao.company_Dao;
import adminDao.company_information_load_Dao;
import adminDao.company_project_add_Dao;
import adminDao.company_project_manage_load_Dao;
import adminDao.department_Dao;
import adminDao.my_load_Dao;
import adminDao.open_project_Dao;
import adminDao.project_category_Dao;
import adminDao.project_manage_load_Dao;
import adminDao.usage_statistics_Dao;
import adminDto.admin_log_Dto;
import adminDto.category_Dto;
import adminDto.company_information_load_Dto;
import adminDto.company_project_manage_load_Dto;
import adminDto.department_Dto;
import adminDto.my_load_Dto;
import adminDto.open_project_Dto;
import adminDto.project_manage_load_Dto;
import adminDto.usage_statistics_Dto;
@WebServlet("/withServlet")
public class WithServlet extends HttpServlet {
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
        	int num = Integer.parseInt(request.getParameter("send_number"));
        	String json = null;
        	switch(num) {
        		case 0:
        			String my_id = request.getParameter("send_my_id");
        			my_load_Dao my_load_Dao = new my_load_Dao();
        			my_load_Dto my_load_Dto = my_load_Dao.getDto(my_id);
        			json = new Gson().toJson(my_load_Dto);
        			break;
        		case 1:
        			String employee_id = request.getParameter("send_employee_id");
        			company_information_load_Dao company_information_load_Dao = new company_information_load_Dao();
        			ArrayList<company_information_load_Dto> company_information_load_DtoList = company_information_load_Dao.getDtoList(employee_id);
        			json = new Gson().toJson(company_information_load_DtoList);
        			break;
        		case 2:
        			int company_id = Integer.parseInt(request.getParameter("send_company_id"));
        			company_project_manage_load_Dao company_project_manage_load_Dao = new company_project_manage_load_Dao();
        			ArrayList<company_project_manage_load_Dto> company_project_manage_load_Dto_List = company_project_manage_load_Dao.getDtoList(company_id);
        			json = new Gson().toJson(company_project_manage_load_Dto_List);
        			break;
        		case 3:
        			int num1 = Integer.parseInt(request.getParameter("send_num1"));
        			int num2 = Integer.parseInt(request.getParameter("send_num2"));
        			int num3 = Integer.parseInt(request.getParameter("send_num3"));
        			int num4 = Integer.parseInt(request.getParameter("send_num4"));
        			int num5 = Integer.parseInt(request.getParameter("send_num5"));        			
        			String project_name = request.getParameter("send_project_name");
        			employee_id = request.getParameter("send_employee_id");
        			company_id = Integer.parseInt(request.getParameter("send_company_id"));
        			company_project_add_Dao company_project_add_Dao = new company_project_add_Dao();
        			company_project_add_Dao.project(project_name, employee_id, company_id);
        			company_project_add_Dao.project_permission(employee_id, num1, num2, num3, num4, num5);
        			company_project_add_Dao.project_member(company_id, employee_id, num1, num2, num3, num4, num5);
        			company_project_add_Dao.personal_project_set(company_id, employee_id);
        			json = "{\"project_id\":\"" + company_project_add_Dao.project_id_load(employee_id) + "\"}";
        			break;
        		case 4:
        			company_id = Integer.parseInt(request.getParameter("send_company_id"));
        			project_category_Dao project_category_Dao = new project_category_Dao();
        			json = new Gson().toJson(project_category_Dao.getDtoList(company_id));
        			break;
        		case 5:
        			int category_id;
        			try {
        				category_id = Integer.parseInt(request.getParameter("send_category_id"));
        			} catch (Exception e) {
        				category_id = 0;
        			}
        			String category = request.getParameter("send_category");
        			int status = Integer.parseInt(request.getParameter("send_status"));
        			int delete = Integer.parseInt(request.getParameter("send_delete"));
        			int add = Integer.parseInt(request.getParameter("send_add"));
        			
        			category_Dto category_Dto = new category_Dto(category_id, category, status);
        			category_Dao category_Dao = new category_Dao();
        			if(add==1) {
        				if(delete==1) {
        				} else {
        					company_id = Integer.parseInt(request.getParameter("send_company_id"));
        					category_Dao.category_add(company_id, category_Dto);
        				}
        			} else {
        				if(delete==1) {
            				category_Dao.category_delete(category_id);
            			} else {
    	        			category_Dao.category_correction(category_Dto);
            			}
        			}
        			break;
        		case 6:
        			company_id = Integer.parseInt(request.getParameter("send_company_id"));
        			category_Dao category_Dao2 = new category_Dao();
        			ArrayList<category_Dto> List = category_Dao2.category_load(company_id);
        			json = new Gson().toJson(List);
        			break;
        		case 7:
        			int project_id = Integer.parseInt(request.getParameter("send_project_id"));
        			category_id = Integer.parseInt(request.getParameter("send_category_id"));
        			project_category_Dao project_category_Dao2 = new project_category_Dao();
        			project_category_Dao2.project_information_correction_category(project_id, category_id);
        			break;
        		case 8:
        			company_id = Integer.parseInt(request.getParameter("send_company_id"));
        			department_Dao department_Dao = new department_Dao();
        			ArrayList<department_Dto> list = department_Dao.getList(company_id);
        			json = new Gson().toJson(list);
        			break;
        		case 9:
        			company_id = Integer.parseInt(request.getParameter("send_company_id"));
        			String department_name = request.getParameter("send_department_name");
        			int up_department_id = Integer.parseInt(request.getParameter("send_up_department_id"));
        			int exposure_procedure = Integer.parseInt(request.getParameter("send_exposure_procedure"));
        			exposure_procedure+=1;
        			department_Dto department_Dto = new department_Dto(company_id, department_name, up_department_id, exposure_procedure, 0);
        			department_Dao department_Dao2 = new department_Dao();
        			department_Dao2.add(department_Dto);
        			break;
        		case 10:
        			int department_id = Integer.parseInt(request.getParameter("send_department_id"));
        			department_Dao department_Dao3 = new department_Dao();
        			department_Dao3.delete(department_id);
        			break;
        		case 11:
        			company_id = Integer.parseInt(request.getParameter("send_company_id"));
        			int use_department = Integer.parseInt(request.getParameter("send_use_department"));
        			company_Dao company_Dao = new company_Dao();
        			company_Dao.use_department_correction(company_id, use_department);
        			break;
        		case 12:
        			department_id = Integer.parseInt(request.getParameter("send_department_id"));
        			department_name = request.getParameter("send_department_name");
        			department_Dao department_Dao4 = new department_Dao();
        			department_Dao4.department_correction(department_id, department_name);
        			break;
        		case 13:
        			company_id = Integer.parseInt(request.getParameter("send_company_id"));
        			String search_name = request.getParameter("send_search_name");
        			String start_date = request.getParameter("send_start_date");
        			String end_date = request.getParameter("send_end_date");
        			project_manage_load_Dao project_manage_load_Dao = new project_manage_load_Dao();
        			ArrayList<project_manage_load_Dto> List3 = project_manage_load_Dao.getDtoList(company_id, search_name, start_date, end_date);
        			json = new Gson().toJson(List3);
        			break;
        		case 14:
        			company_id = Integer.parseInt(request.getParameter("send_company_id"));
        			search_name = request.getParameter("send_search_name");
        			company_project_manage_load_Dao company_project_manage_load_Dao2 = new company_project_manage_load_Dao();
        			ArrayList<company_project_manage_load_Dto> company_project_manage_load_Dto_List2 = company_project_manage_load_Dao2.getDtoList(company_id, search_name);
        			json = new Gson().toJson(company_project_manage_load_Dto_List2);
        			break;
        		case 15:
        			company_id = Integer.parseInt(request.getParameter("send_company_id"));
        			search_name = request.getParameter("send_search_name");
        			open_project_Dao open_project_Dao = new open_project_Dao();
        			ArrayList<open_project_Dto> open_project_Dto_List = open_project_Dao.getDtoList(company_id, search_name);
        			json = new Gson().toJson(open_project_Dto_List);
        			break;
        		case 16:
        			break;
        		case 17:
        			company_id = Integer.parseInt(request.getParameter("send_company_id"));
        			search_name = request.getParameter("send_search_name");
        			usage_statistics_Dao usage_statistics_Dao = new usage_statistics_Dao();
        			ArrayList<usage_statistics_Dto> list3 = usage_statistics_Dao.getDtoList(company_id, search_name);
        			json = new Gson().toJson(list3);
        			break;
        		case 18:
        			company_id = Integer.parseInt(request.getParameter("send_company_id"));
        			search_name = request.getParameter("send_search_name");
        			start_date = request.getParameter("send_start_date");
        			end_date = request.getParameter("send_end_date");
        			int search_gubun = Integer.parseInt(request.getParameter("send_search_gubun"));
        			admin_log_Dao admin_log_Dao = new admin_log_Dao();
        			ArrayList<admin_log_Dto> list4 = admin_log_Dao.load(company_id, search_name, start_date, end_date, search_gubun);
        			json = new Gson().toJson(list4);
        			break;
        		case 19:
        			company_id = Integer.parseInt(request.getParameter("send_company_id"));
        			employee_id = request.getParameter("send_employee_id");
        			String change_menu = request.getParameter("send_change_menu");
        			String function = request.getParameter("send_function");
        			String object = request.getParameter("send_object");
        			String changes = request.getParameter("send_changes");
        			admin_log_Dao admin_log_Dao2 = new admin_log_Dao();
        			admin_log_Dto admin_log_Dto2 = new admin_log_Dto(employee_id, "", change_menu, function, object, changes, "", company_id);
        			admin_log_Dao2.add(admin_log_Dto2);
        			break;
        		case 20:
        			employee_id = request.getParameter("send_employee_id");
        			admin_log_Dao admin_log_Dao3 = new admin_log_Dao();
        			json = "{\"employee_name\":\"" + admin_log_Dao3.employee_name_load(employee_id) + "\"}";
        	}
        	if(json!=null) {
	        	response.setContentType("application/json");
	            response.setCharacterEncoding("UTF-8");
	            response.getWriter().write(json);
        	}

        } catch (Exception e) {
//            e.printStackTrace();
            // 예외 처리 로직 작성
        }
    }
}