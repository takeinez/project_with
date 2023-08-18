package adminDto;

public class department_Dto {
	private int company_id;
	private String department_name;
	private int up_department_id;
	private int exposure_procedure;
	private int department_id;
	
	public department_Dto(int company_id, String department_name, int up_department_id, int exposure_procedure,
			int department_id) {
		super();
		this.company_id = company_id;
		this.department_name = department_name;
		this.up_department_id = up_department_id;
		this.exposure_procedure = exposure_procedure;
		this.department_id = department_id;
	}

	public int getCompany_id() {
		return company_id;
	}

	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}

	public String getDepartment_name() {
		return department_name;
	}

	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}

	public int getUp_department_id() {
		return up_department_id;
	}

	public void setUp_department_id(int up_department_id) {
		this.up_department_id = up_department_id;
	}

	public int getExposure_procedure() {
		return exposure_procedure;
	}

	public void setExposure_procedure(int exposure_procedure) {
		this.exposure_procedure = exposure_procedure;
	}

	public int getDepartment_id() {
		return department_id;
	}

	public void setDepartment_id(int department_id) {
		this.department_id = department_id;
	}
	
	

}
