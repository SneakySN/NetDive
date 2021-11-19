package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BoardWrite {
	// JSP에서 회원 데이터베이스 테이블에 접근할 수 있도록 생성
		// DAO = Data Access Object, 실질적으로 데이터베이스에서 회원정보를 관리, 처리할때 사용

	private Connection conn;
	// DB 접근 객체
	private PreparedStatement pstmt;
	private ResultSet rs;
	// 정보를 담을 객체

	// Ctrl + Shift + O => "Organize Imports" = 클래스에 불필요한 import구문은 제거, 필요한 구문은 자동으로
	// 추가
	public BoardWrite() {
		try {
			String dbURL = "jdbc:mysql://localhost:3308/BoardData?characterEncoding=UTF-8&serverTimezone=UTC";			// localhost:3306 => 내컴퓨터에 설치된 MySQL, port 3306의 BBS라는 DB에 접속
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			// MySQL에 접속할 수 있도록 매개체 역할을 해주는 하나의 라이브러리, JDBC 드라이버 로드

			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// DB 접속되면 conn객체에 접속정보가 저장

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public int newPost(Board Board) {
		String SQL = "INSERT INTO BOARDPOSTS VALUES (?,?,?,?,?)"; //BoardTitle, BoardText, BoardTags, UserID, RandomSeed
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, Board.getBoardTitle());
			pstmt.setString(2, Board.getBoardText());
			pstmt.setString(3, Board.getBoardTags());
			pstmt.setString(4, Board.getBoardUserID());
			pstmt.setInt(5, Board.getRandomSeed());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	public int viewPost(Board Board) {
		return 0;
	}
}

