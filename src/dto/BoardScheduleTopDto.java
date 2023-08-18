package dto;

public class BoardScheduleTopDto {
	private int project_id;
	private String project_name;
	private String board_title;
	private String regist_date;
	private int public_scope;
	private String start_date;
	private String deadline;
	private int love;
	private int love_count;
	private int bookmark;
	private String lat;
	private String lng;
	private String employee_id;
	private String employee_name;
	private String profile_img;
	public BoardScheduleTopDto(int project_id, String project_name, String board_title, String regist_date,
			int public_scope, String start_date, String deadline, int love, int love_count, int bookmark, String lat,
			String lng, String employee_id, String employee_name, String profile_img) {
		super();
		this.project_id = project_id;
		this.project_name = project_name;
		this.board_title = board_title;
		this.regist_date = regist_date;
		this.public_scope = public_scope;
		this.start_date = start_date;
		this.deadline = deadline;
		this.love = love;
		this.love_count = love_count;
		this.bookmark = bookmark;
		this.lat = lat;
		this.lng = lng;
		this.employee_id = employee_id;
		this.employee_name = employee_name;
		this.profile_img = profile_img;
	}
	public int getProject_id() {
		return project_id;
	}
	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getRegist_date() {
		return regist_date;
	}
	public void setRegist_date(String regist_date) {
		this.regist_date = regist_date;
	}
	public int getPublic_scope() {
		return public_scope;
	}
	public void setPublic_scope(int public_scope) {
		this.public_scope = public_scope;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public int getLove() {
		return love;
	}
	public void setLove(int love) {
		this.love = love;
	}
	public int getLove_count() {
		return love_count;
	}
	public void setLove_count(int love_count) {
		this.love_count = love_count;
	}
	public int getBookmark() {
		return bookmark;
	}
	public void setBookmark(int bookmark) {
		this.bookmark = bookmark;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public String getEmployee_id() {
		return employee_id;
	}
	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}
	public String getEmployee_name() {
		return employee_name;
	}
	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	
	
	
}
