package dto;

public class AllBoardDto3 {
	private String startdate;
	private String deadline;
	private String lat;
	private String lng;
	private int Alarm;
	private String joinId;
	private String place;
	private String address;
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
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public int getAlarm() {
		return Alarm;
	}
	public void setAlarm(int alarm) {
		this.Alarm = alarm;
	}
	public String getJoinId() {
		return joinId;
	}
	public void setJoinId(String joinId) {
		this.joinId = joinId;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public AllBoardDto3(String startdate, String deadline, String lat, String lng, int alarm,String joinId, String place, String address) {
		this.startdate = startdate;
		this.deadline = deadline;
		this.lat = lat;
		this.lng = lng;
		this.Alarm = alarm;
		this.joinId = joinId;
		this.place= place;
		this.address = address;
	}
}
