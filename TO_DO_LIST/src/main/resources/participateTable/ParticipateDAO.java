package participateTable;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


// 12-01 Work on making the fetchAll_fromUserID function operate so that you can continue making the MyPage.

public class ParticipateDAO {
	// JSP에서 회원 데이터베이스 테이블에 접근할 수 있도록 생성
	// DAO = Data Access Object, 실질적으로 데이터베이스에서 회원정보를 관리, 처리할때 사용

	private Connection conn;
	// DB 접근 객체
	private PreparedStatement pstmt;
	private ResultSet rs;
	// 정보를 담을 객체

	// Ctrl + Shift + O => "Organize Imports" = 클래스에 불필요한 import구문은 제거, 필요한 구문은 자동으로
	// 추가

	public ParticipateDAO() {
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
	public int join(ParticipateDTO User) {
		System.out.println("join works");
		String SQL_Search = "SELECT 1 FROM participate WHERE userID = ? AND evaluationID = ?;";
		String SQL_Insert = "INSERT INTO Participate VALUES (?,?)";
		try {
			System.out.println("try works");
			pstmt = conn.prepareStatement(SQL_Search); //sql쿼리문을 대기 시킨다
			pstmt.setString(1, User.getUserID());
			pstmt.setInt(2, User.getEvaluationID());//첫번째 '?'에 매개변수로 받아온 'userID'를 대입
			rs = pstmt.executeQuery(); //쿼리를 실행한 결과를 rs에 저장
			if (rs.next()) { // 결과가 존재한다면
				System.out.println("already in post");
				return 0; // 이미 등록되어있음
			}
			pstmt = conn.prepareStatement(SQL_Insert);
			pstmt.setInt(1, User.getEvaluationID());
			pstmt.setString(2, User.getUserID());
			System.out.println("Finished putting it in");
			System.out.print("EvaluationID: ");
			System.out.println(User.getEvaluationID());
			System.out.print("UserID: ");
			System.out.println(User.getUserID());
			return pstmt.executeUpdate(); // 실제 받은 데이터 값 계수 반환
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn!=null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch (Exception e) {e.printStackTrace();}
		}
		return -1; // 회원가입 실패
	}
}