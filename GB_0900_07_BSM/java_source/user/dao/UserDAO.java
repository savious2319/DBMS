package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.UserVO;

public class UserDAO {
	Connection conn;
	UserVO user;
	PreparedStatement pstm;
	ResultSet rs;

	// 아이디 검사
	public boolean checkId(String id) {
		boolean check = false;
		String query = "SELECT COUNT(*) AS C FROM TBL_USER WHERE ID = ?";
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			pstm.setString(1, id); //첫번째 물음표에 id 값을 넣는다
			rs = pstm.executeQuery();

			rs.next(); //데이터의 값을 가져와라

			if (rs.getInt("C") == 1) { //rs.getInt(1)는 테이블의 첫번째 컬럼
				return true;
			}

		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:22, checkId()쿼리 오류" + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:34, checkId() 오류" + e);
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstm != null) {
					pstm.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (SQLException sqle) {
				throw new RuntimeException(
						"UserDAO.java:40, checkId() close 오류" + sqle.getMessage());
			}

		}

		return check;
	}
	
	
	//암호화
	//복호화
	//회원가입
	//로그인
	//수정
	//삭제
	//검색
	//목록
	//아이디 찾기
	//비번 찾기
	
		
}
