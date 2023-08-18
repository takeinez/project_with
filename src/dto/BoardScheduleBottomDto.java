package dto;

public class BoardScheduleBottomDto {
	private int reply_id;
	private String reply_writer;
	private String reply_content;
	private String reply_regist_date;
	private int love_reply_count;
	private String reply_writer_name;
	private String reply_profile_img;
	public BoardScheduleBottomDto(int reply_id, String reply_writer, String reply_content, String reply_regist_date,
			int love_reply_count, String reply_writer_name, String reply_profile_img) {
		super();
		this.reply_id = reply_id;
		this.reply_writer = reply_writer;
		this.reply_content = reply_content;
		this.reply_regist_date = reply_regist_date;
		this.love_reply_count = love_reply_count;
		this.reply_writer_name = reply_writer_name;
		this.reply_profile_img = reply_profile_img;
	}
	public int getReply_id() {
		return reply_id;
	}
	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
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
	public String getReply_regist_date() {
		return reply_regist_date;
	}
	public void setReply_regist_date(String reply_regist_date) {
		this.reply_regist_date = reply_regist_date;
	}
	public int getLove_reply_count() {
		return love_reply_count;
	}
	public void setLove_reply_count(int love_reply_count) {
		this.love_reply_count = love_reply_count;
	}
	public String getReply_writer_name() {
		return reply_writer_name;
	}
	public void setReply_writer_name(String reply_writer_name) {
		this.reply_writer_name = reply_writer_name;
	}
	public String getReply_profile_img() {
		return reply_profile_img;
	}
	public void setReply_profile_img(String reply_profile_img) {
		this.reply_profile_img = reply_profile_img;
	}
	
	
	
}
