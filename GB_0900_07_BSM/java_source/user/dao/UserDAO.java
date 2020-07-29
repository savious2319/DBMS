package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import vo.UserVO;

public class UserDAO {
	// 2개 이상의 메소드에서 사용되는 변수를 전역변수로 선언한다

	// DBMS와 연결할 수 있도록 연결 객체를 담기 위함
	Connection conn;

	// JAVA에서 작성한 SQL문을 객체로 담기 위함
	PreparedStatement pstm;
	// Statement stat;

	// SQL문을 실행한 후 나오는 결과값을 담기 위함
	ResultSet rs;

	// Model
	UserVO user;

	public static String session_id;

	private static final int KEY_CODE = 3; // 암호화, 복호화 할 때 사용할 키값!

	// 아이디 검사
	public boolean checkId(String id) {
		// 외부에서 사용자가 입력한 id값을 전달받는다.

		// Flag
		boolean check = false;

		// 문자열 형식으로 sql문을 작성한다. 만약 변수가 들어가야 한다면
		// 그 자리에 ?를 사용해준다. 이런 sql을 동적 쿼리라고 한다
		// 단, PreparedStatement 객체만 ?를 활용할 수 있다
		String query = "SELECT COUNT(*) FROM TBL_USER WHERE ID = ?";
		// String query = "SELECT * FROM TBL_USER WHERE ID = ?";

		try {
			// DBConnection에 구현해 놓은 conn객체를 가져온다.
			conn = DBConnection.getConnection();

			// 작성한 sql문을 pstm에 담아준다.
			pstm = conn.prepareStatement(query);

			// stat = conn.createStatement();
			// 첫번째 물음표 자리에 id값을 넣어라
			pstm.setString(1, id);

			// sql문을 실행한 후 결과를 rs에 담아준다
			rs = pstm.executeQuery();
			System.out.println("확인");

//			if(rs.next()) {
//				System.out.println("USER_NUMBER : " + rs.getInt("USER_NUMBER") + 
//						"\nID : " + rs.getString("ID") +"\nPW : "+ rs.getString("PW")-
//						+"\nNAME : " + rs.getString("NAME") + "\nAGE : " + rs.getString("AGE")
//						+"\nPHONE : " + rs.getString("PHONE_NUMBER"));
//				System.out.println("USER_NUMBER : " + rs.getInt(1) + 
//						"\nID : " + rs.getString(2) +"\nPW : "+ rs.getString(3)
//						+"\nNAME : " + rs.getString(4) + "\nAGE : " + rs.getString(5)
//						+"\nPHONE : " + rs.getString(6));
//			}
			// 결과가 있는 sql문이면 반드시 next()를 사용해야 get...()을 통해서 값을 가져올 수 있다
			rs.next();

			// sql문에 COUNT(*)이 결과이기 때문에 정수이고,
			// 중복되지 않은 값을 조건절에 넣었기 때문에 결과는 0 또는 1이다
			// 1이면 검색 결과가 있다는 뜻이고, 0이면 없다는 뜻이다

			if (rs.getInt(1) == 1) { // 첫번째 컬럼의 카운트가 1이면 true
				// flag를 true로 변경하여 중복이 있음을 알림
				check = true;
			}

		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:33, checkId()쿼리 오류 " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:35, checkId() 오류 " + e);
		} finally {
			try {
				// 열어준 반대 순서로 닫아준다
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
				// close부분에서 예외발생시 여러 문제가 발생할 수 있기 때문에
				// 따로 예외를 처리하지 않고, 직접 예외를 발생시켜서 강제 종료 시킨다
				throw new RuntimeException("UserDAO.java:48, checkId() close 오류" + sqle.getMessage());
			}
		}
		return check;
	}

	// 회원가입
	public boolean join(String id, String pw, String name, int age, String phone_number) {
		String query = "";
		boolean check = false;
		if (!checkId(id)) {
			query = "INSERT INTO TBL_USER (USER_NUMBER, ID, PW, NAME, AGE, PHONE_NUMBER)"
					+ "VALUES(SEQ_USER.NEXTVAL, ?, ?, ?, ?, ?)";
			try {
//				int idx = 0; pstm.setString(++idx, id)
				conn = DBConnection.getConnection();
				pstm = conn.prepareStatement(query);
				pstm.setString(1, id);
				pstm.setString(2, encrypt(pw));
				pstm.setString(3, name);
				pstm.setInt(4, age);
				pstm.setString(5, phone_number);

				if (pstm.executeUpdate() == 1) {
					// System.out.println("pstm.executeUpdate() : " + pstm.executeUpdate());
					check = true;
				}
			} catch (SQLException sqle) {
				System.out.println("UserDAO.java:116, join() 쿼리 오류 : " + sqle);
			} catch (Exception e) {
				System.out.println("UserDAO.java:118, join() 오류 " + e);
			} finally {
				try {
					if (pstm != null) {
						pstm.close();
					}
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException sqle) {
					throw new RuntimeException("UserDAO.java:48, join() close 오류" + sqle.getMessage());
				}
			}
		}

		return check;
	}

	// 암호화
	public String encrypt(String pw) {
		String enc_pw = "";

		for (int i = 0; i < pw.length(); i++) {
			enc_pw += (char) (pw.charAt(i) * KEY_CODE);
		}
		System.out.println("원래 암호 : " + pw + ", enc암호 : " + enc_pw);
		return enc_pw;
	}

	// 복호화
	public String decrypt(String enc_pw) {
		// String dec_pw; // dec_pw에 null 이 들어가게 된다. += 연산을 할 때, null12345 등으로 null부터
		// 들어간다!!!
		String dec_pw = ""; // 공백으로 초기화를 안하면 null 값이 들어간다!

		for (int i = 0; i < enc_pw.length(); i++) {
			dec_pw += (char) (enc_pw.charAt(i) / KEY_CODE);
		}
		System.out.println("enc암호 : " + enc_pw + ", dec암호 : " + dec_pw);
		return dec_pw;
	}

	// 로그인
	//외부에서 사용자가 입력한 아이디와 패스워드를 전달받는다
	public boolean login(String id, String pw) {
		//Flag
		boolean check = false;
		
		//전달받은 아이디와 패스워드로 일치하는 정보가 있는지 검사 후
		//결과 건수를 COUNT(*)로 알아낸다
		String query = "";

		//query = "SELECT COUNT(*) FROM TBL_USER WHERE ID = ? AND PW = ?";
		query = "SELECT ID, PW FROM TBL_USER WHERE ID = ? AND PW = ?";
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			pstm.setString(1, id);
			//비밀번호는 암호화된 상태로 DB에 저장되어 있기 때문에
			//비교할 때에도 암호화해서 전달한다
			pstm.setString(2, encrypt(pw));
			rs = pstm.executeQuery();

			if (rs.next()) {
				check = true;
				session_id = id;
				System.out.println("로그인 성공");
			}
//			rs.next(); //중복이 없으므로 결과 행은 한개이기 때문에 next()를 한번만 사용한다
			
			//COUNT(*)가 1이면 등록된 사용자이므로 로그인 성공
//			if (rs.getInt(1) == 1) {
//				check = true;
			
				//로그인 후 다른 페이지 이동시 로그인 상태를 ID로 판달할 수 있도록
				//static 변수인 session_id에 담아준다!
			
//				session_id = id;
//				System.out.println("로그인 성공");
//			}
		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:181, login() 쿼리 오류 : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, login() 오류" + e);
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
				throw new RuntimeException("UserDAO.java:48, login() close 오류" + sqle.getMessage());
			}
		}
		return check;
	}

	// 로그아웃
	public void logout() {
		//저장되어 있는 session_id 값을 없애준다
		session_id = null;
	}

	// 수정(비밀번호 변경)
	// 정보보호상, 로그인이 되었더라도 본인의 비밀번호를 한 번 더 입력받는다
	// 기존 비밀번호와 새롭게 설정할 비밀번호를 전달받는다
	public boolean update(String pw, String new_pw) {
		boolean check = false;
		//로그인된 id와 입력한 pw를 검색한 후 찾았다면 해당 사용자의 pw를 새로운 pw로 변경해준다
		String query = "UPDATE TBL_USER SET PW = ? WHERE ID = ? AND PW = ?";
		if (session_id == null) {
			//만약 로그인 상태가 아니라면 밑의 로직을 수행하지 않도록 바로 false를 리턴해준다
			return check;
		}
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			pstm.setString(1, encrypt(new_pw));
			pstm.setString(2, session_id);
			pstm.setString(3, encrypt(pw));
			
			//SQL문 결과 건수가 1이라면 해당 사용자의 비밀번호 변경 성공
			if (pstm.executeUpdate() == 1) {
				check = true;
				System.out.println("수정 성공");
			}

		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:236, update() 쿼리 오류 : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, update() 오류" + e);
		} finally {
			try {
				if (pstm != null) {
					pstm.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				throw new RuntimeException("UserDAO.java:251, update() close 오류" + sqle.getMessage());
			}
		}

		return check;
	}

	// 삭제(서브 쿼리)
	// 회원 탈퇴시 정보보호상, 본인의 비밀번호를 다시 한 번 입력받는다
	// 다시 입력한 비밀번호를 전달받는다
	public boolean delete(String pw) {
		//로그인된 ID와 입력한 PW로 검색한 user_number 값으로 삭제하기 위해 서브퀴리를 사용한다
		boolean check = false;
		String query = "DELETE FROM TBL_USER WHERE (USER_NUMBER) = (SELECT USER_NUMBER FROM TBL_USER WHERE ID = ? AND PW = ?)";
		if (session_id == null) {
			return check;
		}
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			pstm.setString(1, session_id);
			pstm.setString(2, encrypt(pw));

			if (pstm.executeUpdate() == 1) {
				check = true;
			}
		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:236, delete() 쿼리 오류 : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, delete() 오류" + e);
		} finally {
			try {
				if (pstm != null) {
					pstm.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				throw new RuntimeException("UserDAO.java:251, delete() close 오류" + sqle.getMessage());
			}
		}

		return check;
	}

	// 로그인되어있는 회원 검색
	// 로그인된 사용자의 마이페이지를 구현하기 위해 해당 사용자의 정보를 모두 가져온다
	// 따라서 session_id를 사용하기 때문에 전달받을 매개변수는 없다
	// 만약 여러개의 정보가 있다고 해서, ArrayList를 사용한다면 각 방에 있는 값이 
	// 어떤 것을 의미하는지 알기 어렵기 때문에, 각 값에 이름이 있는 UserVO(모델)객체를 사용하여 리턴해준다
	public UserVO select(){
		String query = "SELECT * FROM TBL_USER WHERE ID = ?";
		UserVO user = null;
		if(session_id == null) {
			return null;
		}
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			pstm.setString(1, session_id);
			rs = pstm.executeQuery();
			
			if(rs.next()) {
				user = new UserVO();
				user.setUser_number(rs.getInt("USER_NUMBER"));
				user.setId(rs.getString(2));
				user.setPw(decrypt(rs.getString(3)));
				user.setName(rs.getString(4));
				user.setAge(rs.getInt(5));
				user.setPhone_number(rs.getString(6));
			}
			
//			while(rs.next()) {
//				System.out.println(rs.getInt(user.getUser_number()) +" "+rs.getString(user.getId()) + rs.getString(user.getPw()) + 
//									" " +rs.getString(user.getName()) + " " + rs.getString(user.getAge()) +" "
//										+ rs.getString(user.getPhone_number()));
//			}
		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:236, select() 쿼리 오류 : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, select() 오류" + e);
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if (pstm != null) {
					pstm.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				throw new RuntimeException("UserDAO.java:251, select() close 오류" + sqle.getMessage());
			}
		}
		
		
		return user;
	}
	
	
	// 목록
	// 회원 전체 목록을 가져오기 위한 메서드
	// 검색되는 행이 2개 이상일 수 있으므로 각 행을 UserVO모델에 담고 여러 모델객체들을
	// 저장하고 관리할 ArrayList에 담아준다
	public ArrayList<UserVO> selectAll(){
		String query = "SELECT * FROM TBL_USER";
		ArrayList<UserVO> users = null;
		UserVO user = null;
		
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			rs = pstm.executeQuery();
			
			//만약 검색 결과가 없다면 ArrayList를 할당할 필요가 없기 때문에
			//1개라도 있을 때 new ArrayList<>()를 통해 할당해준다
			if(rs != null) {users = new ArrayList<>();}
			
			//rs.next() 하나의 행을 불러온다
			//rs.get...() : 하나의 열을 불러온다
			while(rs.next()) {
				user = new UserVO();
				user.setUser_number(rs.getInt("USER_NUMBER"));
				user.setId(rs.getString(2));
				user.setPw(decrypt(rs.getString(3)));
				user.setName(rs.getString(4));
				user.setAge(rs.getInt(5));
				user.setPhone_number(rs.getString(6));
				
				users.add(user);
			}
		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:236, selectAll() 쿼리 오류 : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, selectAll() 오류" + e);
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if (pstm != null) {
					pstm.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				throw new RuntimeException("UserDAO.java:251, selectAll() close 오류" + sqle.getMessage());
			}
		}
		
		
		return users;
	}
	
	// 아이디 찾기(번호, 비밀번호)
	// 사용자가 회원가입시 작성한 핸드폰 번호와 비밀번호를 입력한다
	// 전달받은 정보로 ID를 검색하여 리턴한다
	// 단, 사용자 명의로 한 번의 회원가입만 가능하다
	// (만약 여러 번 회원가입이 가능하다면, 리턴 타입을 ArrayList<String>으로 변경해야 한다)
	public String findId(String phone_number, String pw) {
		String query = "SELECT ID FROM TBL_USER WHERE PHONE_NUMBER = ? AND PW = ?";
		
		String id = null;
		
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			pstm.setString(1, phone_number);
			pstm.setString(2, encrypt(pw)); //암호화한 pw로 회원가입했기때문에 아이디를 찾을때도 pw를 암호화해야 한다!
			
			rs = pstm.executeQuery();
			
			if(rs.next()) {
				id = rs.getString(1);
			}
		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:236, findId() 쿼리 오류 : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, findId() 오류" + e);
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if (pstm != null) {
					pstm.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				throw new RuntimeException("UserDAO.java:251, findId() close 오류" + sqle.getMessage());
			}
		}
		
		
		
		return id;
	}
	//기존 비밀번호를 임시 비밀번호로 변경
	/**
	 * 비밀번호 찾기 시 사용자의 비밀번호를 임시 비밀번호로 변경해주는 메서드
	 * @param user_number
	 * @param temp_pw
	 * @return boolean
	 */
	public boolean update(int user_number, String temp_pw) {
		String query = "UPDATE TBL_USER SET PW = ? WHERE USER_NUMBER = ?";
		boolean check = false;
		
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareCall(query);
			pstm.setString(1, encrypt(temp_pw));
			pstm.setInt(2, user_number);
			
			if(pstm.executeUpdate() == 1) {
				check = true;
			}
		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:236, update() 쿼리 오류 : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, update() 오류" + e);
		} finally {
			try {
				
				if (pstm != null) {
					pstm.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				throw new RuntimeException("UserDAO.java:251, update() close 오류" + sqle.getMessage());
			}
		}
		return check;
	}
	
	
	// 비번 찾기
	public boolean findPw(String id, String phone_number) {
		//랜덤한 문자의 조합으로 임시 비밀번호를 만든다
		boolean check = false;
		
		String temp = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ~!@#$%^&*()_+-=[] {};:/?";
		
		Random r = new Random();
		
		String query = "SELECT USER_NUMBER FROM TBL_USER WHERE ID = ? AND PHONE_NUMBER = ?";
		
		String temp_pw = "";
		
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			pstm.setString(1, id);
			pstm.setString(2, phone_number);
			rs = pstm.executeQuery();
			
			if(rs.next()) {
				//8자리 임시 비밀번호 생성
				for (int i = 0; i < 8; i++) {
					temp_pw += temp.charAt(r.nextInt(temp.length()));
				}
				if(update(rs.getInt(1), temp_pw)) {
					//임시 비밀번호 생성 및 변경 완료
					String api_key = "NCS83W5ESY4T7DQP";
				    String api_secret = "AHR7DYOU1ULNV2AF14OYDT9N7VLWH96P";
				    Message coolsms = new Message(api_key, api_secret);

				    // 4 params(to, from, type, text) are mandatory. must be filled
				    HashMap<String, String> params = new HashMap<String, String>();
				    params.put("to", "01034005125");
				    params.put("from", "01034005125");
				    params.put("type", "SMS");
				    params.put("text", "[테스트]\n임시 비밀번호 : " + temp_pw +"\n노출될 수 있으니 반드시 비밀번호를 변경해주세요");
				    params.put("app_version", "JAVA SDK v2.2"); // application name and version

				    try {
				      JSONObject obj = (JSONObject) coolsms.send(params);
				      System.out.println(obj.toString());
				    } catch (CoolsmsException e) {
				      System.out.println(e.getMessage());
				      System.out.println(e.getCode());
				    }
				    
				    check = true;
				}
				
			}
			
		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:236, findId() 쿼리 오류 : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, findId() 오류" + e);
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if (pstm != null) {
					pstm.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				throw new RuntimeException("UserDAO.java:251, findId() close 오류" + sqle.getMessage());
			}
		}
		
		return check;
	}

}























