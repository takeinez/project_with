package dto;

public class AllBoardDto2 {
	private String process;
	private String startdate;
	private String deadline;
	private String priority;
	private int progress;
	private String manager;
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public int getProgress() {
		return progress;
	}
	public void setProgress(int progress) {
		this.progress = progress;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public AllBoardDto2(String process, String startdate, String deadline, String priority, int progress, String manager) {
		super();
		this.process = process;
		this.startdate = startdate;
		this.deadline = deadline;
		this.priority = priority;
		this.progress = progress;
		this.manager = manager;
	}
}
