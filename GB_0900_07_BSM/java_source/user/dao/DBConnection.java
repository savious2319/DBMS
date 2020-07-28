package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection getConnection() {
		Connection conn = null;
		//연결을 하기 위해서는 url, user, pw, driver가 필요하다.
		try {
			String url = "jdbc:oracle:thin:@localhost:1521:XE";
			String user = "hr";
			String pw = "hr";
			String driver = "oracle.jdbc.driver.OracleDriver";
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, pw);
			
		} catch (ClassNotFoundException cnfe) {
			System.out.println("DBConnection.java:20, 드라이버 로딩 실패 : " + cnfe);
		} catch (SQLException sqle) {
			System.out.println("DBConnection.java:22, DB 접속 실패 : " + sqle);
		} catch (Exception e) {
			System.out.println("DBConnection.java:24, " + e);
		}
		
		return conn;
	}
	
}










