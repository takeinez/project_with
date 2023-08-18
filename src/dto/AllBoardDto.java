package dto;

public class AllBoardDto {
	private int BoardId;
	private String title1;
	private int Type;
	private String content1;
	private String registdate1;
	private String boardwriter1;
	private String jobTitle;
	private String replywriter;
	private String replycontent;
	private String replydate;
	public int getBoardId() {
		return BoardId;
	}
	public void setBoardId(int BoardId) {
		this.BoardId = BoardId;
	}
	public String getReplywriter() {
		return replywriter;
	}
	public void setReplywriter(String replywriter) {
		this.replywriter = replywriter;
	}
	public String getReplycontent() {
		return replycontent;
	}
	public void setReplycontent(String replycontent) {
		this.replycontent = replycontent;
	}
	public String getReplydate() {
		return replydate;
	}
	public void setReplydate(String replydate) {
		this.replydate = replydate;
	}
	public String getTitle1() {
		return title1;
	}
	public void setTitle1(String title1) {
		this.title1 = title1;
	}
	public int setType() {
		return Type;
	}
	public void setType(int Type) {
		this.Type = Type;
	}
	public String getContent1() {
		return content1;
	}
	public void setContent1(String content1) {
		this.content1 = content1;
	}
	public String getRegistdate1() {
		return registdate1;
	}
	public void setRegistdate1(String registdate1) {
		this.registdate1 = registdate1;
	}
	public String getBoardwriter1() {
		return boardwriter1;
	}
	public void setBoardwriter1(String boardwriter1) {
		this.boardwriter1 = boardwriter1;
	}
	public String getJobTitle() {
		return jobTitle;
	}
	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}
	public AllBoardDto(int BoardId ,String title1, int Type, String content1, String registdate1, String boardwriter1, 
						String jobTitle, String replywriter, String replycontent, String replydate ) {
		this.BoardId = BoardId;
		this.title1 = title1;
		this.Type = Type;
		this.content1 = content1;
		this.registdate1 = registdate1;
		this.boardwriter1 = boardwriter1;
		this.jobTitle = jobTitle;
		this.replywriter = replywriter;
		this.replycontent = replycontent;
		this.replydate = replydate;
	}
	@Override
	public String toString() {
	    return "AllBoardDto [board_id=" + BoardId + ", title=" + title1 + ", board_type=" + Type + ", ...]";
	}
}

