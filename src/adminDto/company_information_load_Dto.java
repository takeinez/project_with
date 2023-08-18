package adminDto;
public class company_information_load_Dto {
	private int company_id;
	private String company_name;
	private String company_URL;
	private String company_img;
	private String company_version;
	private int permission_downroad;
	private int permission_duplication;
	private String company_join_option;
	private int use_department;
	
	public company_information_load_Dto(int company_id, String company_name, String company_URL, String company_img,
			String company_version, int permission_downroad, int permission_duplication, String company_join_option,
			int use_department) {
		this.company_id = company_id;
		this.company_name = company_name;
		this.company_URL = company_URL;
		this.company_img = company_img;
		this.company_version = company_version;
		this.permission_downroad = permission_downroad;
		this.permission_duplication = permission_duplication;
		this.company_join_option = company_join_option;
		this.use_department = use_department;
	}

	public int getCompany_id() {
		return company_id;
	}

	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}

	public String getCompany_name() {
		return company_name;
	}

	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}

	public String getCompany_URL() {
		return company_URL;
	}

	public void setCompany_URL(String company_URL) {
		this.company_URL = company_URL;
	}

	public String getCompany_img() {
		return company_img;
	}

	public void setCompany_img(String company_img) {
		this.company_img = company_img;
	}

	public String getCompany_version() {
		return company_version;
	}

	public void setCompany_version(String company_version) {
		this.company_version = company_version;
	}

	public int getPermission_downroad() {
		return permission_downroad;
	}

	public void setPermission_downroad(int permission_downroad) {
		this.permission_downroad = permission_downroad;
	}

	public int getPermission_duplication() {
		return permission_duplication;
	}

	public void setPermission_duplication(int permission_duplication) {
		this.permission_duplication = permission_duplication;
	}

	public String getCompany_join_option() {
		return company_join_option;
	}

	public void setCompany_join_option(String company_join_option) {
		this.company_join_option = company_join_option;
	}

	public int getUse_department() {
		return use_department;
	}

	public void setUse_department(int use_department) {
		this.use_department = use_department;
	}
	
}
