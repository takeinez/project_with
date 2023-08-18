package adminDto;

public class admin_log_Dto {
	private String employee_id;
	private String employee_name;
	private String change_menu;
	private String function;
	private String object;
	private String changes;
	private String changes_date;
	private int company_id;
	
	public admin_log_Dto(String employee_id, String employee_name, String change_menu, String function, String object,
			String changes, String changes_date, int company_id) {
		super();
		this.employee_id = employee_id;
		this.employee_name = employee_name;
		this.change_menu = change_menu;
		this.function = function;
		this.object = object;
		this.changes = changes;
		this.changes_date = changes_date;
		this.company_id = company_id;
	}

	public String getEmployee_id() {
		return employee_id;
	}

	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}

	public String getEmployee_name() {
		return employee_name;
	}

	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}

	public String getChange_menu() {
		return change_menu;
	}

	public void setChange_menu(String change_menu) {
		this.change_menu = change_menu;
	}

	public String getFunction() {
		return function;
	}

	public void setFunction(String function) {
		this.function = function;
	}

	public String getObject() {
		return object;
	}

	public void setObject(String object) {
		this.object = object;
	}

	public String getChanges() {
		return changes;
	}

	public void setChanges(String changes) {
		this.changes = changes;
	}

	public String getChanges_date() {
		return changes_date;
	}

	public void setChanges_date(String changes_date) {
		this.changes_date = changes_date;
	}
	
	public int getCompany_id() {
		return company_id;
	}

	public void setCompany_id(int company_id) {
		this.company_id = company_id;
	}
	

}
