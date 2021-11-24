package user;

public class User {
	
	//java bins  jsp 에서 사용가능하도록 만들기 위해 source에서 generate getters and setters
	//한명이 회원 데이터를 관리하기 위한 java
	private String userID;
	private String userPassword;
	private String userName;
	private String userGender;
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public User() {
	}
	
	public User(String userID, String userPassword, String userName, String userGender) {
		super();
		this.userID = userID;
		this.userPassword = userPassword;
		this.userName = userName;
		this.userGender = userGender;
	}
	
	
}
