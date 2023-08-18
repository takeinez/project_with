package dto;

public class PersonalPushDto {
	private int push_switch;
	private int push_post;
	private int push_reply;
	private int notification_list_set;
	public PersonalPushDto(int push_switch, int push_post, int push_reply, int notification_list_set) {
		super();
		this.push_switch = push_switch;
		this.push_post = push_post;
		this.push_reply = push_reply;
		this.notification_list_set = notification_list_set;
	}
	public int getPush_switch() {
		return push_switch;
	}
	public void setPush_switch(int push_switch) {
		this.push_switch = push_switch;
	}
	public int getPush_post() {
		return push_post;
	}
	public void setPush_post(int push_post) {
		this.push_post = push_post;
	}
	public int getPush_reply() {
		return push_reply;
	}
	public void setPush_reply(int push_reply) {
		this.push_reply = push_reply;
	}
	public int getNotification_list_set() {
		return notification_list_set;
	}
	public void setNotification_list_set(int notification_list_set) {
		this.notification_list_set = notification_list_set;
	}
}
