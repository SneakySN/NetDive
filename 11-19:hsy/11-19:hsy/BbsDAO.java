import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BbsDAO {
	// JSP에서 회원 데이터베이스 테이블에 접근할 수 있도록 생성
		// DAO = Data Access Object, 실질적으로 데이터베이스에서 회원정보를 관리, 처리할때 사용

		private Connection conn;
		// DB 접근 객체
		
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
		
		public String getDate() {
			String SQL = "SELECT NOW()";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if(rs.next()) {return rs.getString(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return ""; 	//데이터 베이스 호 
		}
		public String getNext() {
			String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1)+1;
				}
				return 1; //첫 번쨰 게시물인 경 
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1; 	//데이터 베이스 호 
		}
		
		public int write(String bbsTitle, String userID, String bbsContent) {
			String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext());
				pstmt.setString(2, bbsTitle);
				pstmt.setString(3, userID);
				pstmt.setString(4, getDate());
				pstmt.setString(5, bbsContent);
				pstmt.setInt(6, 1);
				return pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1; 	//데이터 베이스 호 
		}
		public ArrayList<Bbs> getList(int pageNumber){
			String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
			ArrayList<Bbs> list= new ArrayList<Bbs>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() - (pageNumber -1)*10);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					Bbs bbs= new Bbs();
					bbs.setBbsId(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setUserId(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					list.add(bbs);
				}
				return 1; //첫 번쨰 게시물인 경 
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list; 	//데이터 베이스 호 
		}
		
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1;
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, getNext() - (pageNumber -1)*10);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return true;
				}
				return 1; //첫 번쨰 게시물인 경 
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false; 	//데이터 베이스 호 
		}

}
