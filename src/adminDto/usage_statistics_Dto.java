package adminDto;

public class usage_statistics_Dto {
	private String company_name;
	private String employee_name;
	private String department_name;
	private String job_title;
	private String employee_id;
	private int project_count;
	private int board_count;
	private int reply_count;
	private int chatRoom_count;
	private int chating_count;
	public usage_statistics_Dto(String company_name, String employee_name, String department_name, String job_title,
			String employee_id, int project_count, int board_count, int reply_count, int chatRoom_count,
			int chating_count) {
		super();
		this.company_name = company_name;
		this.employee_name = employee_name;
		this.department_name = department_name;
		this.job_title = job_title;
		this.employee_id = employee_id;
		this.project_count = project_count;
		this.board_count = board_count;
		this.reply_count = reply_count;
		this.chatRoom_count = chatRoom_count;
		this.chating_count = chating_count;
	}
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getEmployee_name() {
		return employee_name;
	}
	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}
	public String getDepartment_name() {
		return department_name;
	}
	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}
	public String getJob_title() {
		return job_title;
	}
	public void setJob_title(String job_title) {
		this.job_title = job_title;
	}
	public String getEmployee_id() {
		return employee_id;
	}
	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}
	public int getProject_count() {
		return project_count;
	}
	public void setProject_count(int project_count) {
		this.project_count = project_count;
	}
	public int getBoard_count() {
		return board_count;
	}
	public void setBoard_count(int board_count) {
		this.board_count = board_count;
	}
	public int getReply_count() {
		return reply_count;
	}
	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}
	public int getChatRoom_count() {
		return chatRoom_count;
	}
	public void setChatRoom_count(int chatRoom_count) {
		this.chatRoom_count = chatRoom_count;
	}
	public int getChating_count() {
		return chating_count;
	}
	public void setChating_count(int chating_count) {
		this.chating_count = chating_count;
	}
	
	
	
}
