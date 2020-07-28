package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection getConnection() {
		Connection conn = null;
		// ������ �ϱ� ���ؼ��� url, user, pw, driver�� �ʿ��ϴ�
		try {
			String url = "jdbc:oracle:thin:@localhost:1521:XE"; // ����� ip �ּ�
			// url -> location, uri -> identity
			String user = "hr";
			String pw = "hr";
			String driver = "oracle.jdbc.driver.OracleDriver";
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, pw);

		} catch (ClassNotFoundException cnfe) {
			System.out.println("DBConnection.java:20, ����̹� �ε� ���� : " + cnfe);
		} catch (SQLException sqle) {
			System.out.println("DBConnection.java:22, DB ���� ���� : " + sqle);
		} catch (Exception e) {
			System.out.println("DBConnection.java:24: " + e);
		}

		return conn;
	}
}















