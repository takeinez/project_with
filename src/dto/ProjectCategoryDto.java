package dto;

public class ProjectCategoryDto {
	private int company_id;
	private int category_id;
	private String category;
	public ProjectCategoryDto(int company_id, int category_id, String category) {
		super();
		this.company_id = company_id;
		this.category_id = category_id;
		this.category = category;
	}
	public int getCompany_id() {
		return company_id;
	}
	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}
	public int getCategory_id() {
		return category_id;
	}
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
}
