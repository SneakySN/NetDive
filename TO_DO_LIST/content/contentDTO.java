package content;

public class contentDTO {

	int evaluationID;
	String userID;
	String contentName;
	int contentstartYear;
	String contentperiod;
	String tagDivide;
	String contentTitle;
	String contentTextbox;
	String totalScore;
	String creditScore;
	String comfortableScore;
	String contentScore;
	int likeCount;
	
	public int getEvaluationID() {
		return evaluationID;
	}
	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getContentName() {
		return contentName;
	}
	public void setContentName(String contentName) {
		this.contentName = contentName;
	}
	public int getContentstartYear() {
		return contentstartYear;
	}
	public void setContentstartYear(int contentstartYear) {
		this.contentstartYear = contentstartYear;
	}
	public String getContentperiod() {
		return contentperiod;
	}
	public void setContentperiod(String contentperiod) {
		this.contentperiod = contentperiod;
	}
	public String getTagDivide() {
		return tagDivide;
	}
	public void setTagDivide(String tagDivide) {
		this.tagDivide = tagDivide;
	}
	public String getContentTitle() {
		return contentTitle;
	}
	public void setContentTitle(String contentTitle) {
		this.contentTitle = contentTitle;
	}
	public String getContentTextbox() {
		return contentTextbox;
	}
	public void setContentTextbox(String contentTextbox) {
		this.contentTextbox = contentTextbox;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getCreditScore() {
		return creditScore;
	}
	public void setCreditScore(String creditScore) {
		this.creditScore = creditScore;
	}
	public String getComfortableScore() {
		return comfortableScore;
	}
	public void setComfortableScore(String comfortableScore) {
		this.comfortableScore = comfortableScore;
	}
	public String getContentScore() {
		return contentScore;
	}
	public void setContentScore(String contentScore) {
		this.contentScore = contentScore;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public contentDTO(int evaluationID, String userID, String contentName, int contentstartYear, String contentperiod,
			String tagDivide, String contentTitle, String contentTextbox, String totalScore, String creditScore,
			String comfortableScore, String contentScore, int likeCount) {
		super();
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.contentName = contentName;
		this.contentstartYear = contentstartYear;
		this.contentperiod = contentperiod;
		this.tagDivide = tagDivide;
		this.contentTitle = contentTitle;
		this.contentTextbox = contentTextbox;
		this.totalScore = totalScore;
		this.creditScore = creditScore;
		this.comfortableScore = comfortableScore;
		this.contentScore = contentScore;
		this.likeCount = likeCount;
	}
	contentDTO(){
		
	}
	
}
