package adminDto;

public class project_category_Dto {
	private int category_id;
	private int company_id;
	private String category;
	private int status;
	private int project_count;
	
	public project_category_Dto(int category_id, int company_id, String category, int status, int project_count) {
		this.category_id = category_id;
		this.company_id = company_id;
		this.category = category;
		this.status = status;
		this.project_count = project_count;
	}

	public int getCategory_id() {
		return category_id;
	}

	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}

	public int getCompany_id() {
		return company_id;
	}

	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getProject_count() {
		return project_count;
	}

	public void setProject_count(int project_count) {
		this.project_count = project_count;
	}

}
