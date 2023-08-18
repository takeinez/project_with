package dto;

public class WithMentionDto {
	private int project_id;
	private String project_name;
	private int board_id;
	private int board_type;
	private String board_title;
	private String board_writer;
	private String regist_date;
	private String reply_writer;
	private String reply_content;
	private String reply_date;
	private int reply_count;
	public WithMentionDto(int project_id, String project_name, int board_id, int board_type, String board_title,
			String board_writer, String regist_date, String reply_writer, String reply_content, String reply_date,
			int reply_count) {
		super();
		this.project_id = project_id;
		this.project_name = project_name;
		this.board_id = board_id;
		this.board_type = board_type;
		this.board_title = board_title;
		this.board_writer = board_writer;
		this.regist_date = regist_date;
		this.reply_writer = reply_writer;
		this.reply_content = reply_content;
		this.reply_date = reply_date;
		this.reply_count = reply_count;
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
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public int getBoard_type() {
		return board_type;
	}
	public void setBoard_type(int board_type) {
		this.board_type = board_type;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_writer() {
		return board_writer;
	}
	public void setBoard_writer(String board_writer) {
		this.board_writer = board_writer;
	}
	public String getRegist_date() {
		return regist_date;
	}
	public void setRegist_date(String regist_date) {
		this.regist_date = regist_date;
	}
	public String getReply_writer() {
		return reply_writer;
	}
	public void setReply_writer(String reply_writer) {
		this.reply_writer = reply_writer;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public String getReply_date() {
		return reply_date;
	}
	public void setReply_date(String reply_date) {
		this.reply_date = reply_date;
	}
	public int getReply_count() {
		return reply_count;
	}
	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}
	
}
