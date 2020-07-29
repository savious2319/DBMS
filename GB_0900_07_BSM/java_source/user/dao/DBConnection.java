package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection getConnection() {
		Connection conn = null;
		// 연결을 하기 위해서는 url, user, pw, driver가 필요하다
		try {
			String url = "jdbc:oracle:thin:@localhost:1521:XE"; // 출시한 ip 주소가 있으면 localhost 자리에 써도 된다
			// url -> locator, uri -> identifier
			String user = "hr";
			String pw = "hr";
			String driver = "oracle.jdbc.driver.OracleDriver";
			
			//1. 자바 클래스가 아닌 경로 혹은 파일을 클래스화 시키는 작업
			//2. 외부 클래스를 가져오기 위함
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, pw);

			//Excetion 객체명은 예외 클래스 대문자를 가져와서 만든다
		} catch (ClassNotFoundException cnfe) {
			//예외 발생시 어떤 파일, 몇번 째 줄인지를 작성해주고, 해당 내용을 작성한다
			System.out.println("DBConnection.java:20, 드라이버 로딩 실패 : " + cnfe);
		} catch (SQLException sqle) {
			System.out.println("DBConnection.java:22, DB 접속 실패 : " + sqle);
		} catch (Exception e) {
			System.out.println("DBConnection.java:24: " + e);
		}

		return conn;
	}
}
















