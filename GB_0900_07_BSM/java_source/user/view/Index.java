package view;

import dao.UserDAO;

public class Index {
	public static void main(String[] args) {
//		new xxxDao().view();
		System.out.println(new UserDAO().checkId("user003"));
	}
}
