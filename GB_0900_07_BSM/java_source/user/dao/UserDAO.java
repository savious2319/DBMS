package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import vo.UserVO;

public class UserDAO {
	Connection conn;
	PreparedStatement pstm;
	//Statement stat;
	ResultSet rs;
	UserVO user;
	//아이디 검사
	public boolean checkId(String id) {
		boolean check = false;
		String query = "SELECT COUNT(*) FROM TBL_USER WHERE ID = ?";
		//String query = "SELECT * FROM TBL_USER WHERE ID = ?";
		
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			//stat = conn.createStatement();
			pstm.setString(1, id);
			rs = pstm.executeQuery();
			System.out.println("확인");
			
//			if(rs.next()) {
//				System.out.println("USER_NUMBER : " + rs.getInt("USER_NUMBER") + 
//						"\nID : " + rs.getString("ID") +"\nPW : "+ rs.getString("PW")
//						+"\nNAME : " + rs.getString("NAME") + "\nAGE : " + rs.getString("AGE")
//						+"\nPHONE : " + rs.getString("PHONE_NUMBER"));
//				System.out.println("USER_NUMBER : " + rs.getInt(1) + 
//						"\nID : " + rs.getString(2) +"\nPW : "+ rs.getString(3)
//						+"\nNAME : " + rs.getString(4) + "\nAGE : " + rs.getString(5)
//						+"\nPHONE : " + rs.getString(6));
//			}
			rs.next();
			if(rs.getInt(1) == 1) {
				return true;
			}
			
			
		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:33, checkId()쿼리 오류 " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:35, checkId() 오류 " + e);
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(pstm != null) {
					pstm.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				throw new RuntimeException(
						"UserDAO.java:48, checkId() close 오류" + sqle.getMessage());
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














