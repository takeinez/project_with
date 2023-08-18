package adminDto;

public class open_project_Dto {
	private int project_id;
	private String project_name;
	private String project_birthday;
	private String recent_date;
	private int member_count;
	private int board_count;
	private int reply_count;
	private String register_id;
	private int category_id;
	private String category;
	
	public open_project_Dto(int project_id, String project_name, String project_birthday, String recent_date,
			int member_count, int board_count, int reply_count, String register_id, int category_id,
			String category) {
		super();
		this.project_id = project_id;
		this.project_name = project_name;
		this.project_birthday = project_birthday;
		this.recent_date = recent_date;
		this.member_count = member_count;
		this.board_count = board_count;
		this.reply_count = reply_count;
		this.register_id = register_id;
		this.category_id = category_id;
		this.category = category;
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

	public String getProject_birthday() {
		return project_birthday;
	}

	public void setProject_birthday(String project_birthday) {
		this.project_birthday = project_birthday;
	}

	public String getRecent_date() {
		return recent_date;
	}

	public void setRecent_date(String recent_date) {
		this.recent_date = recent_date;
	}

	public int getMember_count() {
		return member_count;
	}

	public void setMember_count(int member_count) {
		this.member_count = member_count;
	}

	public int getBoard_count() {
		return board_count;
	}

	public void setBoard_count(int board_count) {
		this.board_count = board_count;
	}

	public int getReply_count() {
		return reply_count;
	}

	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}

	public String getRegister_id() {
		return register_id;
	}

	public void setRegister_id(String register_id) {
		this.register_id = register_id;
	}

	public int getCategory_id() {
		return category_id;
	}

	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}

	public String getCategory_name() {
		return category;
	}

	public void setCategory_name(String category) {
		this.category = category;
	}
	
	
	
}
