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

	// ���̵� �˻�
	public boolean checkId(String id) {
		boolean check = false;
		String query = "SELECT COUNT(*) AS C FROM TBL_USER WHERE ID = ?";
		try {
			conn = DBConnection.getConnection();
			pstm = conn.prepareStatement(query);
			pstm.setString(1, id); //ù��° ����ǥ�� id ���� �ִ´�
			rs = pstm.executeQuery();

			rs.next(); //�������� ���� �����Ͷ�

			if (rs.getInt("C") == 1) { //rs.getInt(1)�� ���̺��� ù��° �÷�
				return true;
			}

		} catch (SQLException sqle) {
			System.out.println("UserDAO.java:22, checkId()���� ����" + sqle);
		} catch (Exception e) {
			System.out.println("UserDAO.java:34, checkId() ����" + e);
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
						"UserDAO.java:40, checkId() close ����" + sqle.getMessage());
			}

		}

		return check;
	}
	
	
	//��ȣȭ
	//��ȣȭ
	//ȸ������
	//�α���
	//����
	//����
	//�˻�
	//���
	//���̵� ã��
	//��� ã��
	
		
}
