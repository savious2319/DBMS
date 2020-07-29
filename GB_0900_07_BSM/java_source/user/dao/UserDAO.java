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
	// 2�� �̻��� �޼ҵ忡�� ���Ǵ� ������ ���������� �����Ѵ�

	// DBMS�� ������ �� �ֵ��� ���� ��ü�� ��� ����
	Connection conn;

	// JAVA���� �ۼ��� SQL���� ��ü�� ��� ����
	PreparedStatement pstm;
	// Statement stat;

	// SQL���� ������ �� ������ ������� ��� ����
	ResultSet rs;

	// Model
	UserVO user;

	public static String session_id;

	private static final int KEY_CODE = 3; // ��ȣȭ, ��ȣȭ �� �� ����� Ű��!

	// ���̵� �˻�
	public boolean checkId(String id) {
		// �ܺο��� ����ڰ� �Է��� id���� ���޹޴´�.

		// Flag
		boolean check = false;

		// ���ڿ� �������� sql���� �ۼ��Ѵ�. ���� ������ ���� �Ѵٸ�
		// �� �ڸ��� ?�� ������ش�. �̷� sql�� ���� ������� �Ѵ�
		// ��, PreparedStatement ��ü�� ?�� Ȱ���� �� �ִ�
		String query = "SELECT COUNT(*) FROM TBL_USER WHERE ID = ?";
		// String query = "SELECT * FROM TBL_USER WHERE ID = ?";

		try {
			// DBConnection�� ������ ���� conn��ü�� �����´�.
			conn = DBConnection.getConnection();

			// �ۼ��� sql���� pstm�� ����ش�.
			pstm = conn.prepareStatement(query);

			// stat = conn.createStatement();
			// ù��° ����ǥ �ڸ��� id���� �־��
			pstm.setString(1, id);

			// sql���� ������ �� ����� rs�� ����ش�
			rs = pstm.executeQuery();
			System.out.println("Ȯ��");

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
			// ����� �ִ� sql���̸� �ݵ�� next()�� ����ؾ� get...()�� ���ؼ� ���� ������ �� �ִ�
			rs.next();

			// sql���� COUNT(*)�� ����̱� ������ �����̰�,
			// �ߺ����� ���� ���� �������� �־��� ������ ����� 0 �Ǵ� 1�̴�
			// 1�̸� �˻� ����� �ִٴ� ���̰�, 0�̸� ���ٴ� ���̴�

			if (rs.getInt(1) == 1) { // ù��° �÷��� ī��Ʈ�� 1�̸� true
				// flag�� true�� �����Ͽ� �ߺ��� ������ �˸�
				check = true;
			}

		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:33, checkId()���� ���� " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:35, checkId() ���� " + e);
		} finally {
			try {
				// ������ �ݴ� ������ �ݾ��ش�
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
				// close�κп��� ���ܹ߻��� ���� ������ �߻��� �� �ֱ� ������
				// ���� ���ܸ� ó������ �ʰ�, ���� ���ܸ� �߻����Ѽ� ���� ���� ��Ų��
				throw new RuntimeException("UserDAO.java:48, checkId() close ����" + sqle.getMessage());
			}
		}
		return check;
	}

	// ȸ������
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
				System.out.println("UserDAO.java:116, join() ���� ���� : " + sqle);
			} catch (Exception e) {
				System.out.println("UserDAO.java:118, join() ���� " + e);
			} finally {
				try {
					if (pstm != null) {
						pstm.close();
					}
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException sqle) {
					throw new RuntimeException("UserDAO.java:48, join() close ����" + sqle.getMessage());
				}
			}
		}

		return check;
	}

	// ��ȣȭ
	public String encrypt(String pw) {
		String enc_pw = "";

		for (int i = 0; i < pw.length(); i++) {
			enc_pw += (char) (pw.charAt(i) * KEY_CODE);
		}
		System.out.println("���� ��ȣ : " + pw + ", enc��ȣ : " + enc_pw);
		return enc_pw;
	}

	// ��ȣȭ
	public String decrypt(String enc_pw) {
		// String dec_pw; // dec_pw�� null �� ���� �ȴ�. += ������ �� ��, null12345 ������ null����
		// ����!!!
		String dec_pw = ""; // �������� �ʱ�ȭ�� ���ϸ� null ���� ����!

		for (int i = 0; i < enc_pw.length(); i++) {
			dec_pw += (char) (enc_pw.charAt(i) / KEY_CODE);
		}
		System.out.println("enc��ȣ : " + enc_pw + ", dec��ȣ : " + dec_pw);
		return dec_pw;
	}

	// �α���
	//�ܺο��� ����ڰ� �Է��� ���̵�� �н����带 ���޹޴´�
	public boolean login(String id, String pw) {
		//Flag
		boolean check = false;
		
		//���޹��� ���̵�� �н������ ��ġ�ϴ� ������ �ִ��� �˻� ��
		//��� �Ǽ��� COUNT(*)�� �˾Ƴ���
		String query = "";

		//query = "SELECT COUNT(*) FROM TBL_USER WHERE ID = ? AND PW = ?";
		query = "SELECT ID, PW FROM TBL_USER WHERE ID = ? AND PW = ?";
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			pstm.setString(1, id);
			//��й�ȣ�� ��ȣȭ�� ���·� DB�� ����Ǿ� �ֱ� ������
			//���� ������ ��ȣȭ�ؼ� �����Ѵ�
			pstm.setString(2, encrypt(pw));
			rs = pstm.executeQuery();

			if (rs.next()) {
				check = true;
				session_id = id;
				System.out.println("�α��� ����");
			}
//			rs.next(); //�ߺ��� �����Ƿ� ��� ���� �Ѱ��̱� ������ next()�� �ѹ��� ����Ѵ�
			
			//COUNT(*)�� 1�̸� ��ϵ� ������̹Ƿ� �α��� ����
//			if (rs.getInt(1) == 1) {
//				check = true;
			
				//�α��� �� �ٸ� ������ �̵��� �α��� ���¸� ID�� �Ǵ��� �� �ֵ���
				//static ������ session_id�� ����ش�!
			
//				session_id = id;
//				System.out.println("�α��� ����");
//			}
		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:181, login() ���� ���� : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, login() ����" + e);
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
				throw new RuntimeException("UserDAO.java:48, login() close ����" + sqle.getMessage());
			}
		}
		return check;
	}

	// �α׾ƿ�
	public void logout() {
		//����Ǿ� �ִ� session_id ���� �����ش�
		session_id = null;
	}

	// ����(��й�ȣ ����)
	// ������ȣ��, �α����� �Ǿ����� ������ ��й�ȣ�� �� �� �� �Է¹޴´�
	// ���� ��й�ȣ�� ���Ӱ� ������ ��й�ȣ�� ���޹޴´�
	public boolean update(String pw, String new_pw) {
		boolean check = false;
		//�α��ε� id�� �Է��� pw�� �˻��� �� ã�Ҵٸ� �ش� ������� pw�� ���ο� pw�� �������ش�
		String query = "UPDATE TBL_USER SET PW = ? WHERE ID = ? AND PW = ?";
		if (session_id == null) {
			//���� �α��� ���°� �ƴ϶�� ���� ������ �������� �ʵ��� �ٷ� false�� �������ش�
			return check;
		}
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			pstm.setString(1, encrypt(new_pw));
			pstm.setString(2, session_id);
			pstm.setString(3, encrypt(pw));
			
			//SQL�� ��� �Ǽ��� 1�̶�� �ش� ������� ��й�ȣ ���� ����
			if (pstm.executeUpdate() == 1) {
				check = true;
				System.out.println("���� ����");
			}

		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:236, update() ���� ���� : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, update() ����" + e);
		} finally {
			try {
				if (pstm != null) {
					pstm.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				throw new RuntimeException("UserDAO.java:251, update() close ����" + sqle.getMessage());
			}
		}

		return check;
	}

	// ����(���� ����)
	// ȸ�� Ż��� ������ȣ��, ������ ��й�ȣ�� �ٽ� �� �� �Է¹޴´�
	// �ٽ� �Է��� ��й�ȣ�� ���޹޴´�
	public boolean delete(String pw) {
		//�α��ε� ID�� �Է��� PW�� �˻��� user_number ������ �����ϱ� ���� ���������� ����Ѵ�
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
			System.out.println("UserDAO.java:236, delete() ���� ���� : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, delete() ����" + e);
		} finally {
			try {
				if (pstm != null) {
					pstm.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				throw new RuntimeException("UserDAO.java:251, delete() close ����" + sqle.getMessage());
			}
		}

		return check;
	}

	// �α��εǾ��ִ� ȸ�� �˻�
	// �α��ε� ������� ������������ �����ϱ� ���� �ش� ������� ������ ��� �����´�
	// ���� session_id�� ����ϱ� ������ ���޹��� �Ű������� ����
	// ���� �������� ������ �ִٰ� �ؼ�, ArrayList�� ����Ѵٸ� �� �濡 �ִ� ���� 
	// � ���� �ǹ��ϴ��� �˱� ��Ʊ� ������, �� ���� �̸��� �ִ� UserVO(��)��ü�� ����Ͽ� �������ش�
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
			System.out.println("UserDAO.java:236, select() ���� ���� : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, select() ����" + e);
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
				throw new RuntimeException("UserDAO.java:251, select() close ����" + sqle.getMessage());
			}
		}
		
		
		return user;
	}
	
	
	// ���
	// ȸ�� ��ü ����� �������� ���� �޼���
	// �˻��Ǵ� ���� 2�� �̻��� �� �����Ƿ� �� ���� UserVO�𵨿� ��� ���� �𵨰�ü����
	// �����ϰ� ������ ArrayList�� ����ش�
	public ArrayList<UserVO> selectAll(){
		String query = "SELECT * FROM TBL_USER";
		ArrayList<UserVO> users = null;
		UserVO user = null;
		
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			rs = pstm.executeQuery();
			
			//���� �˻� ����� ���ٸ� ArrayList�� �Ҵ��� �ʿ䰡 ���� ������
			//1���� ���� �� new ArrayList<>()�� ���� �Ҵ����ش�
			if(rs != null) {users = new ArrayList<>();}
			
			//rs.next() �ϳ��� ���� �ҷ��´�
			//rs.get...() : �ϳ��� ���� �ҷ��´�
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
			System.out.println("UserDAO.java:236, selectAll() ���� ���� : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, selectAll() ����" + e);
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
				throw new RuntimeException("UserDAO.java:251, selectAll() close ����" + sqle.getMessage());
			}
		}
		
		
		return users;
	}
	
	// ���̵� ã��(��ȣ, ��й�ȣ)
	// ����ڰ� ȸ�����Խ� �ۼ��� �ڵ��� ��ȣ�� ��й�ȣ�� �Է��Ѵ�
	// ���޹��� ������ ID�� �˻��Ͽ� �����Ѵ�
	// ��, ����� ���Ƿ� �� ���� ȸ�����Ը� �����ϴ�
	// (���� ���� �� ȸ�������� �����ϴٸ�, ���� Ÿ���� ArrayList<String>���� �����ؾ� �Ѵ�)
	public String findId(String phone_number, String pw) {
		String query = "SELECT ID FROM TBL_USER WHERE PHONE_NUMBER = ? AND PW = ?";
		
		String id = null;
		
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			pstm.setString(1, phone_number);
			pstm.setString(2, encrypt(pw)); //��ȣȭ�� pw�� ȸ�������߱⶧���� ���̵� ã������ pw�� ��ȣȭ�ؾ� �Ѵ�!
			
			rs = pstm.executeQuery();
			
			if(rs.next()) {
				id = rs.getString(1);
			}
		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:236, findId() ���� ���� : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, findId() ����" + e);
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
				throw new RuntimeException("UserDAO.java:251, findId() close ����" + sqle.getMessage());
			}
		}
		
		
		
		return id;
	}
	//���� ��й�ȣ�� �ӽ� ��й�ȣ�� ����
	/**
	 * ��й�ȣ ã�� �� ������� ��й�ȣ�� �ӽ� ��й�ȣ�� �������ִ� �޼���
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
			System.out.println("UserDAO.java:236, update() ���� ���� : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, update() ����" + e);
		} finally {
			try {
				
				if (pstm != null) {
					pstm.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException sqle) {
				throw new RuntimeException("UserDAO.java:251, update() close ����" + sqle.getMessage());
			}
		}
		return check;
	}
	
	
	// ��� ã��
	public boolean findPw(String id, String phone_number) {
		//������ ������ �������� �ӽ� ��й�ȣ�� �����
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
				//8�ڸ� �ӽ� ��й�ȣ ����
				for (int i = 0; i < 8; i++) {
					temp_pw += temp.charAt(r.nextInt(temp.length()));
				}
				if(update(rs.getInt(1), temp_pw)) {
					//�ӽ� ��й�ȣ ���� �� ���� �Ϸ�
					String api_key = "NCS83W5ESY4T7DQP";
				    String api_secret = "AHR7DYOU1ULNV2AF14OYDT9N7VLWH96P";
				    Message coolsms = new Message(api_key, api_secret);

				    // 4 params(to, from, type, text) are mandatory. must be filled
				    HashMap<String, String> params = new HashMap<String, String>();
				    params.put("to", "01034005125");
				    params.put("from", "01034005125");
				    params.put("type", "SMS");
				    params.put("text", "[�׽�Ʈ]\n�ӽ� ��й�ȣ : " + temp_pw +"\n����� �� ������ �ݵ�� ��й�ȣ�� �������ּ���");
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
			System.out.println("UserDAO.java:236, findId() ���� ���� : " + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:191, findId() ����" + e);
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
				throw new RuntimeException("UserDAO.java:251, findId() close ����" + sqle.getMessage());
			}
		}
		
		return check;
	}

}























