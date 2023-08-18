package dto;

import java.util.ArrayList;

public class AllBoardDto5 {
	private String deadline;
	private int revenge_vote;
	private int anonymous_vote;
	private int anyone_add;
	private int hidden_poll;
	private int result_time;
	private ArrayList<String>contents;
	public ArrayList<String> getContents() {
		return contents;
	}
	public void setContents(ArrayList<String> contents) {
		this.contents = contents;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public int getRevenge_vote() {
		return revenge_vote;
	}
	public void setRevenge_vote(int revenge_vote) {
		this.revenge_vote = revenge_vote;
	}
	public int getAnonymous_vote() {
		return anonymous_vote;
	}
	public void setAnonymous_vote(int anonymous_vote) {
		this.anonymous_vote = anonymous_vote;
	}
	public int getAnyone_add() {
		return anyone_add;
	}
	public void setAnyone_add(int anyone_add) {
		this.anyone_add = anyone_add;
	}
	public int getHidden_poll() {
		return hidden_poll;
	}
	public void setHidden_poll(int hidden_poll) {
		this.hidden_poll = hidden_poll;
	}
	public int getResult_time() {
		return result_time;
	}
	public void setResult_time(int result_time) {
		this.result_time = result_time;
	}
	public AllBoardDto5(String deadline, int revenge_vote, int anonymous_vote, int anyone_add, int hidden_poll,
			int result_time,ArrayList<String>contents) {
		super();
		this.deadline = deadline;
		this.revenge_vote = revenge_vote;
		this.anonymous_vote = anonymous_vote;
		this.anyone_add = anyone_add;
		this.hidden_poll = hidden_poll;
		this.result_time = result_time;
		this.contents = contents;
	}

}
