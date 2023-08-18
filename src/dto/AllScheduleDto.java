package dto;

public class AllScheduleDto {
	private int board_id;
	private String board_title;
	private String start_date;
	private String deadline;
	public AllScheduleDto(int board_id, String board_title, String start_date, String deadline) {
		this.board_id = board_id;
		this.board_title = board_title;
		this.start_date = start_date;
		this.deadline = deadline;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	
}
