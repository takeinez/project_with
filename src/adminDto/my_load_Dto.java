package adminDto;

public class my_load_Dto {
	private String employee_id;
	private String employee_pw;
	private String employee_name;
	private int company_id;
	private int department_id;
	private String job_title;
	private String phone;
	private String phone_company;
	private String status_message;
	private String join_date;
	private int status;
	private String profile_img;
	private int company_admin;
	
	private String department_name;

	public my_load_Dto(String employee_id, String employee_pw, String employee_name, int company_id, int department_id, String job_title,
			String phone, String phone_company, String status_message, String join_date, int status, String profile_img,
			int company_admin, String department_name) {
		this.employee_id = employee_id;
		this.employee_pw = employee_pw;
		this.employee_name = employee_name;
		this.company_id = company_id;
		this.department_id = department_id;
		this.job_title = job_title;
		this.phone = phone;
		this.phone_company = phone_company;
		this.status_message = status_message;
		this.join_date = join_date;
		this.status = status;
		this.profile_img = profile_img;
		this.company_admin = company_admin;
		
		this.department_name = department_name;
	}
	

	public String getEmployee_id() {
		return employee_id;
	}

	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}

	public String getEmployee_pw() {
		return employee_pw;
	}

	public void setEmployee_pw(String employee_pw) {
		this.employee_pw = employee_pw;
	}

	public String getEmployee_name() {
		return employee_name;
	}

	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}

	public int getCompany_id() {
		return company_id;
	}

	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}

	public int getDepartment_id() {
		return department_id;
	}

	public void setDepartment_id(int department_id) {
		this.department_id = department_id;
	}

	public String getJob_title() {
		return job_title;
	}

	public void setJob_title(String job_title) {
		this.job_title = job_title;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPhone_company() {
		return phone_company;
	}

	public void setPhone_company(String phone_company) {
		this.phone_company = phone_company;
	}

	public String getStatus_message() {
		return status_message;
	}

	public void setStatus_message(String status_message) {
		this.status_message = status_message;
	}

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}

	public int getCompany_admin() {
		return company_admin;
	}

	public void setCompany_admin(int company_admin) {
		this.company_admin = company_admin;
	}

	public String getDepartment_name() {
		return department_name;
	}

	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}
	
	
	
	
}
