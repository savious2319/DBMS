package vo;

public class UserVO {
	//alt + shift + a -> GUI 모드가 됨.
	//거기서 shift + 방향키로 구역 지정
	private int user_number;
	private String id;
	private String pw;
	private String name;
	private int age;
	private String phone_number;
	
	public UserVO() {;} //작성하지말라!
	
	public int getUser_number() {
		return user_number;
	}
	public void setUser_number(int user_number) {
		this.user_number = user_number;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getPhone_number() {
		return phone_number;
	}
	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}
	
	
}
