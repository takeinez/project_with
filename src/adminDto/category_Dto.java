package adminDto;

public class category_Dto {
	private int category_id;
	private String category;
	private int status;
	
	public category_Dto(int category_id, String category, int status) {
		super();
		this.category_id = category_id;
		this.category = category;
		this.status = status;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

}
