package participateTable;

public class ParticipateDTO {

	int evaluationID;
	String userID;
	
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
	public ParticipateDTO(int evaluationID, String userID) {
		super();
		this.evaluationID = evaluationID;
		this.userID = userID;
	}
	public ParticipateDTO() {}
}