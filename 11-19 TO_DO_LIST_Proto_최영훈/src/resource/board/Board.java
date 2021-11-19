package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.concurrent.ThreadLocalRandom;

public class Board {
	private String boardTitle;
	private String boardText;
	private String boardTags;
	private String boardUserID;
	private int boardRandomSeed;
	private ResultSet rs;
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String BoardTitle) {
		this.boardTitle = BoardTitle;
	}
	public String getBoardText() {
		return boardText;
	}
	public void setBoardText(String BoardText) {
		this.boardText = BoardText;
	}
	public String getBoardTags() {
		return boardTags;
	}
	public void setBoardTags(String BoardTags) {
		this.boardTags = BoardTags;
	}
	public String getBoardUserID() {
		return boardUserID;
	}
	public void getBoardUserID(String BoardUserID) {
		this.boardUserID = BoardUserID;
	}
	public int getRandomSeed() {
		setRandomSeed();
		return boardRandomSeed;
	}
	public void setRandomSeed() {
		this.boardRandomSeed = generateRandomSeed();
	}
	public int generateRandomSeed() {
		int randomNum = ThreadLocalRandom.current().nextInt(100000000, 999999999);
		return randomNum;
	}
}
