package view;

import dao.UserDAO;

public class Index {
	public static void main(String[] args) {
		System.out.println(new UserDAO().checkId("user000"));
	}
}
