package dto;

public class AllBoardDto4 {
	private int todoId;
	private String content;
	private String manager;
	private String deadline;
	public int getTodoId() {
		return todoId;
	}
	public void setTodoId(int todoId) {
		this.todoId = todoId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public AllBoardDto4(int todoId, String content, String manager, String deadline) {
		super();
		this.todoId = todoId;
		this.content = content;
		this.manager = manager;
		this.deadline = deadline;
	}
	
}
