package view;

import dao.UserDAO;
import vo.UserVO;

public class Index {
	public static void main(String[] args) {
		//���̵� �˻� �׽�Ʈ
//		System.out.println(new UserDAO().checkId("user004"));
		
		//ȸ������ �˻� �׽�Ʈ
//		System.out.println(new UserDAO().join("user000", "1234", "�ѵ���", 20, "01011112222"));
//		System.out.println(new UserDAO().join("user001", "1234", "�ѵ���", 20, "01011112222"));
//		System.out.println(new UserDAO().join("user003", "1234", "ȫ�浿", 19, "01001010101"));
//		System.out.println(new UserDAO().join("user007", "SDY-:p4X", "�鼺��", 33, "01034005125"));
		
		//���� �׽�Ʈ
//		System.out.println(UserDAO.session_id); //���� id�� ����
		
		//�α��� �׽�Ʈ
		System.out.println(new UserDAO().login("user007", "1234")); //�α���
//		System.out.println(UserDAO.session_id); //���� �α��ε� id
		
		//�˻� �׽�Ʈ
//		UserVO user = new UserDAO().select();
//		if(user != null) {
//			System.out.println(user);
//		}
		
		//��ü ��� �׽�Ʈ
//		ArrayList<UserVO> users = new UserDAO().selectAll();
//		if(users != null) {
//			for (int i = 0; i < users.size(); i++) {
//				System.out.println(users.get(i));
//			}
//		}
		
		//���ٽ� ���
								     //�����   //����(������ ������ �� �� �߰�ȣ�� ���)
//		new UserDAO().selectAll().forEach(value->System.out.println(value));
		
//		for(UserVO value : new UserDAO().selectAll()) {
//			System.out.println(value);
//		}
		
		
		//���� �׽�Ʈ
//		System.out.println(new UserDAO().update("1234", "1234"));
		
		//���� �׽�Ʈ
//		System.out.println(new UserDAO().delete("1234"));
		
		//ID ã�� �׽�Ʈ
//		System.out.println(new UserDAO().findId("01001010101", "1234"));
		
		//pw ã�� �׽�Ʈ
//		System.out.println(new UserDAO().findPw("user007", "01034005125"));
		
		//�α׾ƿ� �׽�Ʈ
		new UserDAO().logout(); //�α׾ƿ�
	}
}












