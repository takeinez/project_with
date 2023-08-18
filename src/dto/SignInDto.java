package dto;

public class SignInDto {
	private String employee_id;
	private String employee_pw;
	public SignInDto(String employee_id, String employee_pw) {
		this.employee_id = employee_id;
		this.employee_pw = employee_pw;
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
}
