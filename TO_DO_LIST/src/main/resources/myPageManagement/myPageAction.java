package myPageManagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;


public class myPageAction {
	private Connection conn;
	// DB 접근 객체
	private PreparedStatement pstmt;
	private ResultSet rs;
	// 정보를 담을 객체

	// Ctrl + Shift + O => "Organize Imports" = 클래스에 불필요한 import구문은 제거, 필요한 구문은 자동으로
	// 추가

	public myPageAction() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/nuser?characterEncoding=UTF-8&serverTimezone=UTC";			// localhost:3306 => 내컴퓨터에 설치된 MySQL, port 3306의 BBS라는 DB에 접속
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
	public List<String> fetchAll_FromUserID(String UserID) {
		// TODO work from here
		// Get the string from FetchUserIDAction.jsp, and then put it to SQL_Find
		// Then return the values evaluation.contentName and evaluation.contentTextbox so that we can work on it.
		// Potentially a hyperlink using the evaluationID would be good, but I'm not sure if I can implement it right now, as the address isn't to what evaluationID is set to.
		String SQL_Fetch = "SELECT evaluation.contentName, evaluation.contentTextbox \r\n"
				+ "FROM participate \r\n"
				+ "INNER JOIN evaluation \r\n"
				+ "ON participate.evaluationID = evaluation.evaluationID WHERE participate.userID = ?;";
		try {
			System.out.println("Try on fetchAll is operational");
			pstmt = conn.prepareStatement(SQL_Fetch); //sql쿼리문을 대기 시킨다
			pstmt.setString(1, UserID);
			rs = pstmt.executeQuery();
			List<String> result = new ArrayList<>(Arrays.asList());
			while(rs.next()) {
				result.add(rs.getString(1));
				result.add(rs.getString(2));
				System.out.println("rs.next is working");
			}
			return result;
		} catch(Exception e) {
			e.printStackTrace();
		}
		List<String> default_result = new ArrayList<>();
		return default_result;
	}
}