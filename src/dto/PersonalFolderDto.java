package dto;

public class PersonalFolderDto {
	private int folder_id;
	private String employee_id;
	private String folder_name;
	public PersonalFolderDto(int folder_id, String employee_id, String folder_name) {
		super();
		this.folder_id = folder_id;
		this.employee_id = employee_id;
		this.folder_name = folder_name;
	}
	public int getFolder_id() {
		return folder_id;
	}
	public void setFolder_id(int folder_id) {
		this.folder_id = folder_id;
	}
	public String getEmployee_id() {
		return employee_id;
	}
	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}
	public String getFolder_name() {
		return folder_name;
	}
	public void setFolder_name(String folder_name) {
		this.folder_name = folder_name;
	}
}
