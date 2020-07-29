package view;

import dao.UserDAO;
import vo.UserVO;

public class Index {
	public static void main(String[] args) {
		//아이디 검사 테스트
//		System.out.println(new UserDAO().checkId("user004"));
		
		//회원가입 검사 테스트
//		System.out.println(new UserDAO().join("user000", "1234", "한동석", 20, "01011112222"));
//		System.out.println(new UserDAO().join("user001", "1234", "한동석", 20, "01011112222"));
//		System.out.println(new UserDAO().join("user003", "1234", "홍길동", 19, "01001010101"));
//		System.out.println(new UserDAO().join("user007", "SDY-:p4X", "백성민", 33, "01034005125"));
		
		//세션 테스트
//		System.out.println(UserDAO.session_id); //현재 id가 없다
		
		//로그인 테스트
		System.out.println(new UserDAO().login("user007", "1234")); //로그인
//		System.out.println(UserDAO.session_id); //현재 로그인된 id
		
		//검색 테스트
//		UserVO user = new UserDAO().select();
//		if(user != null) {
//			System.out.println(user);
//		}
		
		//전체 목록 테스트
//		ArrayList<UserVO> users = new UserDAO().selectAll();
//		if(users != null) {
//			for (int i = 0; i < users.size(); i++) {
//				System.out.println(users.get(i));
//			}
//		}
		
		//람다식 기법
								     //선언부   //사용부(문장이 여러개 일 때 중괄호를 사용)
//		new UserDAO().selectAll().forEach(value->System.out.println(value));
		
//		for(UserVO value : new UserDAO().selectAll()) {
//			System.out.println(value);
//		}
		
		
		//수정 테스트
//		System.out.println(new UserDAO().update("1234", "1234"));
		
		//삭제 테스트
//		System.out.println(new UserDAO().delete("1234"));
		
		//ID 찾기 테스트
//		System.out.println(new UserDAO().findId("01001010101", "1234"));
		
		//pw 찾기 테스트
//		System.out.println(new UserDAO().findPw("user007", "01034005125"));
		
		//로그아웃 테스트
		new UserDAO().logout(); //로그아웃
	}
}












