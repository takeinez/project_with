package dto;

public class MemberDto {
	private String name;
	private String title;
	private String company;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public MemberDto(String name, String title, String company) {
		super();
		this.name = name;
		this.title = title;
		this.company = company;
	}
	
}
