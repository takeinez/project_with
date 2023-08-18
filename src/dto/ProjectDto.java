package dto;

public class ProjectDto {
	private String title;
	private int id;
	private int color;
	public int getName() {
		return id;
	}
	public void setName(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getColor() {
		return color;
	}
	public void setColor(int color) {
		this.color = color;
	}
	public ProjectDto(String title, int color,int id) {
		this.title = title;
		this.color = color;
		this.id = id;
	}
}
