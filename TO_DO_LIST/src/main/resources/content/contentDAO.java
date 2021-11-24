package content;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class contentDAO {
	// JSP에서 회원 데이터베이스 테이블에 접근할 수 있도록 생성
	
	private Connection conn;
	// DB 접근 객체
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// DAO = Data Access Object, 실질적으로 데이터베이스에서 회원정보를 관리, 처리할때 사용
	public contentDAO() {
		
		try {
			String dbURL = "jdbc:mysql://localhost:3306/NUSER?characterEncoding=UTF-8&serverTimezone=UTC";			
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

	public int content_write(contentDTO contentDTO) 
	{
		
		String SQL = "INSERT INTO EVALUATION VALUES(NULL,?,?,?,?,?,?,?,?,?,?,?,0)";

		try {
			pstmt = conn.prepareStatement(SQL); //sql쿼리문을 대기 시킨다
			pstmt.setString(1, contentDTO.userID);
			pstmt.setString(2, contentDTO.contentName);
			pstmt.setInt(3, contentDTO.contentstartYear);
			pstmt.setString(4, contentDTO.contentperiod);
			pstmt.setString(5, contentDTO.tagDivide);
			pstmt.setString(6, contentDTO.contentTitle);
			pstmt.setString(7, contentDTO.contentTextbox);
			pstmt.setString(8, contentDTO.totalScore);
			pstmt.setString(9, contentDTO.creditScore);
			pstmt.setString(10, contentDTO.comfortableScore);
			pstmt.setString(11, contentDTO.contentScore);
			System.out.println("content DTO");

			return pstmt.executeUpdate(); 
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch (Exception e) {e.printStackTrace();}
			
		}
		return -2; // 데이터베이스 오류
	}
}