package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	// JSP에서 회원 데이터베이스 테이블에 접근할 수 있도록 생성
	// DAO = Data Access Object, 실질적으로 데이터베이스에서 회원정보를 관리, 처리할때 사용

	private Connection conn;
	// DB 접근 객체
	private PreparedStatement pstmt;
	private ResultSet rs;
	// 정보를 담을 객체

	// Ctrl + Shift + O => "Organize Imports" = 클래스에 불필요한 import구문은 제거, 필요한 구문은 자동으로
	// 추가

	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/NUSER?characterEncoding=UTF-8&serverTimezone=UTC";			// localhost:3306 => 내컴퓨터에 설치된 MySQL, port 3306의 BBS라는 DB에 접속
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

	public int login(String userID, String userPassword) 
	{
		String SQL = "SELECT userPassword FROM user WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); //sql쿼리문을 대기 시킨다
			pstmt.setString(1, userID); //첫번째 '?'에 매개변수로 받아온 'userID'를 대입
			rs = pstmt.executeQuery(); //쿼리를 실행한 결과를 rs에 저장
			
//			System.out.println("rs.next() :" + rs.next());
//			System.out.println("rs.getSrting(1) : " +  rs.getString(1));
//			System.out.println("userID :" + userID);
//			System.out.println("userPassword" + userPassword);
			System.out.println("TEST MESSAGE");
			if (rs.next()) // 결과가 존재한다면
			{
				if (rs.getString(1).equals(userPassword))
				// 결과로 나온 userPassword를 받아서 접속을 시도한 userPassword와 동일하다면
				{
					return 1; // 로그인 성공
				} else
					return 0; // 로그인 실패(비밀번호 틀림)

			}
			return -1; // 아이디가 없음 userID=?부분 확인
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch (Exception e) {e.printStackTrace();}
			
		}
		return -2; // 데이터베이스 오류
	}
	
	public int join(User User) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, User.getUserID());
			pstmt.setString(2, User.getUserPassword());
			pstmt.setString(3, User.getUserName());
			pstmt.setString(4, User.getUserGender());
			return pstmt.executeUpdate();// 실제 받은 데이터 값 계수 반환
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

/*package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// 데이터베이스에 접근가능하도록 접근가능한 객체 생성
//데이터베이스에서 회원정보를 입/출력 하는데에 사용함.
public class UserDAO {
	
	//데이터베이스에 접근하게 해주는 객체
	private Connection conn;
	
	private PreparedStatement pstmt;
	//정보를 담는 하나의 객체
	private ResultSet rs;
	//ctrl shift o 를 눌러서 라이브러리를 갖고옴.
	
	//생성자
	public UserDAO() {
		try {
			//3306 포트는 컴퓨터에 설치된 MYSQL 자체이고 NET_DIVE데이터 베이스에 접근 할 수 있도록 함.
			String dbURL = "jdbc:mysql://localhost:3306/NET_DIVE?characterEncoding=UTF-8&serverTimezone=UTC";
			//루트계정
			String dbID = "root";
			//루트 계정의 패스워드
			String dbPassword = "root";
			//mysql에 접근할 수 있도록 하는 일종의 메개체
			Class.forName("com.mysql.cj.jdbc.Driver");
			//conn 객체안에 접속된 객체가 담기게 된다.
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String userID, String userPassword) {
		//실제로 SQL에 입력할 명령어를 SQL 문장으로 만들어 준다.
		// 매개변수로 넘어올 userID를 물음표에 넣도록 한다.
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			//PREPARED STATEMENT 문장에 정해진 문장을 삽입하는 명령어
			//sql injection 같은 해킹기법을 방어하기 위해 preparedstatement 이용.
			//하나의 준비된 문장에 물음표를 넣어놓고 물음표에 넣어놓고, 물음표에 해당하는 내용으로 userid
		
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;// 로그인 성공
				}
				else {
					return 0;					
				}
			}
			return -1; // 아이디가 없음
		} catch(Exception e){
			e.printStackTrace();
		}
		return -2; //데이터베이스 오류 의미
	}
}
*/