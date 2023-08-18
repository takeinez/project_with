package dto;

public class BoardScheduleMidDto {
	private String employee_id;
	private int join_case;
	private String employee_name;
	private String profile_img;
	public BoardScheduleMidDto(String employee_id, int join_case, String employee_name, String profile_img) {
		this.employee_id = employee_id;
		this.join_case = join_case;
		this.employee_name = employee_name;
		this.profile_img = profile_img;
	}
	public String getEmployee_id() {
		return employee_id;
	}
	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}
	public int getJoin_case() {
		return join_case;
	}
	public void setJoin_case(int join_case) {
		this.join_case = join_case;
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
