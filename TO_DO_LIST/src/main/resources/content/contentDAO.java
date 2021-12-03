package content;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
			String dbPassword = "rootroot";
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
	// 선택된 evaluationID가 있는 곳에서 게시글에 대한 정보를 가져온다.
	public contentDTO get_content(int evaluationID) {
		String SQL = "select * from evaluation where evaluationID = ?";
		try {
			
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, evaluationID);
			// evaluationID 의 값을 가져와서 IF문을 진행.
			rs = pstmt.executeQuery();
			if(rs.next()) {
				contentDTO c_view = new contentDTO();
				
				c_view.setUserID(rs.getString(1));
				c_view.setContentName(rs.getString(2));
				c_view.setContentstartYear(rs.getInt(3));
				c_view.setContentperiod(rs.getString(4));
				c_view.setTagDivide(rs.getString(5));
				c_view.setContentTitle(rs.getString(6));
				c_view.setContentTextbox(rs.getString(7));

				return c_view;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		//글이 존재 하지 않을떄 null을 반환_
		return null;
	}
	public int getNext() {
		//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String sql = "select evaluationID from evaluation order by evaluationID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물인 경우
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	/*
	public ArrayList<contentDTO> getList(int pageNumber){
		String sql = "select * from evaluation where evaluationID < ? and bbsAvailable = 1 order by bbsID desc limit 10";
		ArrayList<contentDTO> list = new ArrayList<contentDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				contentDTO contentdata = new contentDTO();
				contentdata.setEvaluationID(rs.getInt(1));
				contentdata.setContentName(rs.getString(2));
				contentdata.setContentstartYear(rs.getInt(3));
				contentdata.setContentperiod(rs.getString(4));
				contentdata.setTagDivide(rs.getString(5));
				contentdata.setContentTitle(rs.getString(6));
				contentdata.setContentTextbox(rs.getString(7));

				list.add(contentdata);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public boolean nextPage(int pageNumber) {
		String sql = "select * from evaluation where evaluationID < ? and bbsAvailable = 1 order by bbsID desc limit 10";
		ArrayList<contentDTO> list = new ArrayList<contentDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				contentDTO contentdata = new contentDTO();
				contentdata.setEvaluationID(rs.getInt(1));
				contentdata.setContentName(rs.getString(2));
				contentdata.setContentstartYear(rs.getInt(3));
				contentdata.setContentperiod(rs.getString(4));
				contentdata.setTagDivide(rs.getString(5));
				contentdata.setContentTitle(rs.getString(6));
				contentdata.setContentTextbox(rs.getString(7));

				list.add(contentdata);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}*/
	public ArrayList<contentDTO> get_searchList(String tagDivide, String searchType, String search, int pageNumber){
		if(tagDivide.equals("전체")) {
			tagDivide = "";
		}
		// 게시글이 담기는 리스트 제작.
		ArrayList<contentDTO> contentList = null;
		PreparedStatement pstmt = null;
		String SQL = "";
		try {
			
			if (searchType.equals("최신순")) // 결과가 존재한다면
			{
				SQL = "SELECT * FROM EVALUATION WHERE tagDivide LIKE ? AND CONCAT(contentName, contentName, contentTitle) LIKE ? ORDER BY evaluationID DESC LIMIT " + pageNumber * 3 + ", " + pageNumber * 3 + 4;

			}else if(searchType.equals("추천순")) {
				
				
			}
			// like 뒤에 ? 에 해당하는 것으로 %를 사용하면 그 문자열을 포함하는지 물어보는 것.
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,"%"+ tagDivide + "%");
			pstmt.setString(2,"%"+ search + "%");
			rs = pstmt.executeQuery();
			contentList = new ArrayList<contentDTO>();

				// 게시글이 존재할때마다 작동
				while (rs.next()){
					contentDTO contentdata = new contentDTO(
							rs.getInt(1),
							rs.getString(2), // userid
							rs.getString(3),
							rs.getInt(4),
							rs.getString(5),
							rs.getString(6),
							rs.getString(7),
							rs.getString(8),
							rs.getString(9),
							rs.getString(10),
							rs.getString(11),
							rs.getString(12),
							rs.getInt(13)
					);
					contentList.add(contentdata);		
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt!=null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs!=null) rs.close();} catch (Exception e) {e.printStackTrace();}
			
		}
		System.out.println("view");
		return contentList; 
	}
	
}