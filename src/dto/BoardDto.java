package dto;

public class BoardDto {
	private String title;
	private String content;
	private String writer;
	private String writedate;
	private String tabletype;
	public BoardDto( String title, String content, String writer, String writedate, String tabletype) {
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.writedate = writedate;
		this.tabletype = tabletype;
	}
	public String gettabletype() {
		return tabletype;
	}
	public void settabletype(String tabletype) {
		this.tabletype = tabletype;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	
	
}
