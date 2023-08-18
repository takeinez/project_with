package dto;

public class OpenProjectDto {
	private int project_id;
	private String project_name;
	private int count_member;
	private String register_id;
	private int joined;
	public OpenProjectDto(int project_id, String project_name, int count_member, String register_id, int joined) {
		super();
		this.project_id = project_id;
		this.project_name = project_name;
		this.count_member = count_member;
		this.register_id = register_id;
		this.joined = joined;
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
	public int getCount_member() {
		return count_member;
	}
	public void setCount_member(int count_member) {
		this.count_member = count_member;
	}
	public String getRegister_id() {
		return register_id;
	}
	public void setRegister_id(String register_id) {
		this.register_id = register_id;
	}
	public int getJoined() {
		return joined;
	}
	public void setJoined(int joined) {
		this.joined = joined;
	}
}
